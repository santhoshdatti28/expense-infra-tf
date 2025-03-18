module "mysql_sg"{
    #source= "../aws-secuirty-group"
    source= "git::https://github.com/santhoshdatti28/aws-secuirty-group.git?ref=main"
    project_name= var.project_name
    environment_name= var.environment_name
    sg_name= "mysql"
    sg_description= "created for mysql"
    vpc_id= data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    
}

module "backend_sg"{
    #source= "../aws-secuirty-group"
    source= "git::https://github.com/santhoshdatti28/aws-secuirty-group.git?ref=main"
    project_name= var.project_name
    environment_name= var.environment_name
    sg_name= "backend"
    sg_description= "created for backend"
    vpc_id= data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    
}

module "frontend_sg"{
    #source= "../aws-secuirty-group"
    source= "git::https://github.com/santhoshdatti28/aws-secuirty-group.git?ref=main"
    project_name= var.project_name
    environment_name= var.environment_name
    sg_name= "frontend"
    sg_description= "created for frontend"
    vpc_id= data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    
}

module "bastion_sg"{
    #source= "../aws-secuirty-group"
    source= "git::https://github.com/santhoshdatti28/aws-secuirty-group.git?ref=main"
    project_name= var.project_name
    environment_name= var.environment_name
    sg_name= "bastion"
    sg_description= "created for bastion"
    vpc_id= data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    
}

module "app_alb_sg"{
    #source= "../aws-secuirty-group"
    source= "git::https://github.com/santhoshdatti28/aws-secuirty-group.git?ref=main"
    project_name= var.project_name
    environment_name= var.environment_name
    sg_name= "app-alb"
    sg_description= "created for backend ALB"
    vpc_id= data.aws_ssm_parameter.vpc_id.value
    common_tags= var.common_tags
    
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id #refering mail module output
}

resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id= module.bastion_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

