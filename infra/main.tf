pprovider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app" {
  ami           = "ami-0c94855ba95c71c99" # Amazon Linux 2
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              docker run -d -p 5000:5000 ant22006/final-project:latest
              EOF

  tags = {
    Name = "final-project-app"
  }
}

output "public_ip" {
  value = aws_instance.app.public_ip
}
