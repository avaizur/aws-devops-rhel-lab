resource "aws_instance" "lab" {
  ami                    = data.aws_ami.rhel9.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.lab.id]

  iam_instance_profile = aws_iam_instance_profile.ssm.name
  user_data            = file("${path.module}/../../scripts/bootstrap.sh")
  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name    = var.project_name
    Project = var.project_name
  }
}