resource "aws_instance" "valheim_server" {
  ami           = data.aws_ami.valheim-ami-ubuntu.id #Change this to ubuntu.id if you haven't done the instructions in README.md
  instance_type = var.instance_type
  key_name      = aws_key_pair.terraform-valheim.id
  availability_zone = var.availability_zone
  iam_instance_profile  = aws_iam_instance_profile.valheim_server.name

  #user_data = file("user_data.sh")
  root_block_device {
    volume_type = "gp3"
    volume_size = 12 # Adjust as needed
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

#Base Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "valheim-ami-ubuntu" {
  most_recent = true
  owners      = ["self"] # Canonical

  filter {
    name   = "name"
    values = ["terraform-valheim-golden-ami"]
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
  key_name   = "terraform-valheim-keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwTGPNvIFqLkg8oFDCHemKewFhbaJvrQrH199UhYAqa7Sj21nm383rpe6oMpIQeew2G3ODNJynLt8F9Cbe4iZ7mBgwpRx0jOwC1IHNM8z2TdvaZ86CSoQWL3mr73OIo/5MGRRnB8vcHWuixABg8bH+q7EiuuLTna1P5MH6UcM8hxn66slwOuAuc8fbKlBkAuYEAxGo1ASQahmhcktP4ZNPRpbsb68OM1BkvlInDcP5ksUTjE1zZepO8ClwrBVWDZJlrwwn0Yzg080+PrwEpxyQylAyxbj1atEOYAqp1M82Dlp73IUzegKmvBW6Wqhlh4UWmsfdLYMdBE5B3agF0CQ+2cVZZ9oxuposXbyQPW41X9lmUtA2k8mxTsGCXi+8+E8Lali5DmGi2gql+c3huH8NLxEnVy4BG2xpaD9G2NkIx7W3lXVY/48wmIAZsnTxReCxmCJjAeeNmMTAayzgiH36lFlMve+24IGIMHNu+UH6SXMPjgTwZ/zW2latuX6aXHMPQTD9u2loicoGqCAiaBWmTWEXLaPzqpxq4bDluQTMvMhzGaSi8OXilxaAot2n53FycbToX+wCOF83uyCE9/1UXRSKAJL1MKCiY0VY+eKdp7UjwpD9BeThBtmaFg8dd5T9RF+qSvZcpMHHPU8OiD7CO3JiX+3JG8UC9gt5bYOuCQ== terraform valheim ec2 keypair"
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
  name = "valheim_server"
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


