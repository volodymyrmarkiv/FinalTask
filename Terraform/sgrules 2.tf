# Allow SSH connection
resource "aws_security_group" "ssh_sg" {
  tags = {
    type = "SSH security group"
  }
}

resource "aws_security_group_rule" "ssh_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_sg.id
}

# Open Jenkins 8080 port
resource "aws_security_group" "jenkins_sg" {
  tags = {
    type = "SSH security group"
  }
}

resource "aws_security_group_rule" "jenkins_rule" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}
