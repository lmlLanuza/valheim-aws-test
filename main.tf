resource "aws_instance" "valheim_server" {
  ami           = data.aws_ami.valheim-ami.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.terraform-valheim.id
  availability_zone = var.availability_zone
  iam_instance_profile  = aws_iam_instance_profile.valheim_server.name

  #user_data = file("user_data.sh")
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price                      = 0.024
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }
  }


  tags = {
    Name = var.valheim_server_name
  }

  vpc_security_group_ids = [aws_security_group.valheim_sg.id]
}


# AMI to use, usually the last AMI snapshot of the server
data "aws_ami" "valheim-ami" {
  most_recent = true
  owners      = [var.valheim_ami_owner] # Canonical

  filter {
    name   = "name"
    values = [var.valheim_ami_name]
  }
}


resource "aws_security_group" "valheim_sg" {
  name_prefix = "valheim-sg-"

  ingress {
    from_port   = 2456
    to_port     = 2458
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "terraform-valheim" {
  key_name   = var.keypair_name
  public_key = var.keypair_public_key
}

resource "aws_s3_bucket" "backup" {
  bucket = var.backup_s3_bucket
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backup.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_instance_profile" "valheim_server" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.EC2UploadToS3.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "EC2UploadToS3" {
  name               = "EC2UploadToS3"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "EC2UploadToS3Policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::terraform-valheim-llanuza-v1/*"]
  }
}

resource "aws_iam_policy" "ValheimServerUploadToS3Policy" {
  name        = "ValheimServerUploadToS3Policy"
  description = "Allows the Valheim Dedicated Server to Upload World Files to S3 Bucket"
  policy      = data.aws_iam_policy_document.EC2UploadToS3Policy.json
}

resource "aws_iam_role_policy_attachment" "AttachToValheimServer" {
  role       = aws_iam_role.EC2UploadToS3.name
  policy_arn = aws_iam_policy.ValheimServerUploadToS3Policy.arn
}


