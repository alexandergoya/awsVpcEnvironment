# etk
data "aws_instance" "etk" {
  instance_id = var.oldEc2[0]
}

resource "aws_ami_from_instance" "etk" {
  name               = "etkTerraform"
  source_instance_id = data.aws_instance.etk.id
  snapshot_without_reboot = true
}

resource "aws_instance" "etk" {
  ami           = aws_ami_from_instance.etk.id
  instance_type = "${data.aws_instance.etk.instance_type}"
  vpc_security_group_ids = [aws_security_group.TerraformSecurityGroup[0].id]
  iam_instance_profile = data.aws_instance.etk.iam_instance_profile
  key_name = data.aws_instance.etk.key_name
  private_ip = "10.1.0.80"
  subnet_id = aws_subnet.etk_subnets[1].id
  tags = {Name = data.aws_instance.etk.tags.Name }
  user_data = <<EOF
        #!/bin/bash
        echo "ECS_CLUSTER=etk-3-37 >> /etc/ecs/ecs.config"
        EOF 
}

# tc0
data "aws_instance" "tc0" {
  instance_id = var.oldEc2[1]
}

resource "aws_ami_from_instance" "tc0" {
  name               = "tc0Terraform"
  source_instance_id = data.aws_instance.tc0.id
  snapshot_without_reboot = true
}

resource "aws_instance" "tc0" {
  ami           = aws_ami_from_instance.tc0.id
  instance_type = "${data.aws_instance.tc0.instance_type}"
  vpc_security_group_ids = [aws_security_group.TerraformSecurityGroup[1].id]
  iam_instance_profile = data.aws_instance.tc0.iam_instance_profile
  key_name = data.aws_instance.tc0.key_name
  private_ip = "10.2.0.80"
  subnet_id = aws_subnet.tc0_subnets[1].id
  tags = {Name = data.aws_instance.tc0.tags.Name }
  user_data = <<EOF
        #!/bin/bash
        echo "ECS_CLUSTER=dev >> /etc/ecs/ecs.config"
        EOF 
}

# epaBi2
data "aws_instance" "epaBi2" {
  instance_id = var.oldEc2[2]
}

resource "aws_ami_from_instance" "epaBi2" {
  name               = "epaBi2Terraform"
  source_instance_id = data.aws_instance.epaBi2.id
  snapshot_without_reboot = true
}

resource "aws_instance" "epaBi2" {
  ami           = aws_ami_from_instance.epaBi2.id
  instance_type = "${data.aws_instance.epaBi2.instance_type}"
  vpc_security_group_ids = [aws_security_group.TerraformSecurityGroup[2].id]
  iam_instance_profile = data.aws_instance.epaBi2.iam_instance_profile
  key_name = data.aws_instance.epaBi2.key_name
  private_ip = "10.3.0.80"
  subnet_id = aws_subnet.epa_subnets[1].id
  tags = {Name = data.aws_instance.epaBi2.tags.Name }
  user_data = <<EOF
        #!/bin/bash
        echo "ECS_CLUSTER=epa-bi >> /etc/ecs/ecs.config"
        EOF 
}
# epaBi3
data "aws_instance" "epaBi3" {
  instance_id = var.oldEc2[4]
}

resource "aws_ami_from_instance" "epaBi3" {
  name               = "epaBi3Terraform"
  source_instance_id = data.aws_instance.epaBi3.id
  snapshot_without_reboot = true
}

resource "aws_instance" "epaBi3" {
  ami           = aws_ami_from_instance.epaBi3.id
  instance_type = "${data.aws_instance.epaBi3.instance_type}"
  vpc_security_group_ids = [aws_security_group.TerraformSecurityGroup[2].id]
  iam_instance_profile = data.aws_instance.epaBi3.iam_instance_profile
  key_name = data.aws_instance.epaBi3.key_name
  private_ip = "10.3.0.140"
  subnet_id = aws_subnet.epa_subnets[2].id
  tags = {Name = data.aws_instance.epaBi3.tags.Name }
  user_data = <<EOF
        #!/bin/bash
        echo "ECS_CLUSTER=epa-bi >> /etc/ecs/ecs.config"
        EOF 
}
# epaBiEfile
# data "aws_instance" "BiEfile" {
#   instance_id = var.oldEc2[4]
# }

# resource "aws_ami_from_instance" "epaBiEfile" {
#   name               = "epaBiEfileTerraform"
#   source_instance_id = data.aws_instance.epaBiEfile.id
#   snapshot_without_reboot = true
# }

# resource "aws_instance" "epaBiEfile" {
#   ami           = aws_ami_from_instance.epaBiEfile.id
#   instance_type = "${data.aws_instance.epaBiEfile.instance_type}"
#   vpc_security_group_ids = [aws_security_group.TerraformSecurityGroup[0].id]
#   iam_instance_profile = data.aws_instance.epaBiEfile.iam_instance_profile
#   key_name = data.aws_instance.epaBiEfile.key_name
#   private_ip = "10.1.0.80"
#   subnet_id = aws_subnet.epaBiEfile_subnets[1].id
#   tags = {Name = data.aws_instance.epaBiEfile.tags.Name }
#   user_data = <<EOF
#         #!/bin/bash
#         echo "ECS_CLUSTER=epaBiEfile-3-37 >> /etc/ecs/ecs.config"
#         EOF 
# }

