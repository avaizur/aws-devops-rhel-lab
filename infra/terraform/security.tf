resource "aws_security_group" "lab" {
  name        = "${var.project_name}-sg"
  description = "Security group for RHEL DevOps training lab"
  vpc_id      = aws_vpc.lab.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}