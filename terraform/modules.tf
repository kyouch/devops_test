module "vpc" {
  source            = "./modules/vpc"
  ecs_cluster_name  = "${var.ecs_cluster_name}"
  alb_port          = "${var.alb_port}"
  container_port    = "${var.container_port}"
}

module "ecs" {
  source              = "./modules/ecs"
  vpc_id              = "${module.vpc.vpc_id}"
  ecs_cluster_name    = "${var.ecs_cluster_name}"
  app_container_name  = "${var.app_container_name}"
  public_subnet_a    = "${module.vpc.public_subnet_a}"
  public_subnet_b    = "${module.vpc.public_subnet_b}"
  app_sg_id           = "${module.vpc.app_sg_id}"
  alb_sg_id           = "${module.vpc.alb_sg_id}"
  ecs_sg_id           = "${module.vpc.ecs_sg_id}"
  ecr_repository_name = "${var.ecr_repository_name}"
  alb_port            = "${var.alb_port}"
  container_port      = "${var.container_port}"
  min_tasks           = "${var.min_tasks}"
  max_tasks           = "${var.max_tasks}"
  cpu_to_scale_up     = "${var.cpu_to_scale_up}"
  cpu_to_scale_down   = "${var.cpu_to_scale_down}"
  desired_tasks       = "${var.desired_tasks}"
  task_cpu            = "${var.task_cpu}"
  task_memory         = "${var.task_memory}"
  security_groups_ids = [
    "${module.vpc.app_sg_id}",
    "${module.vpc.alb_sg_id}",
    "${module.vpc.ecs_sg_id}"
    ]
  availability_zones  = [
    "${module.vpc.public_subnet_a}",
    "${module.vpc.public_subnet_b}"
    ]
}

module "pipeline" {
  source                = "./modules/pipeline"
  git_repository_owner  = "${var.git_repository_owner}"
  git_repository_name   = "${var.git_repository_name}"
  git_repository_branch = "${var.git_repository_branch}"
  account_id            = "${data.aws_caller_identity.current.account_id}"
  aws_region            = "${var.aws_region}"
  ecs_cluster_name      = "${var.ecs_cluster_name}"
  ecr_repository_name   = "${var.ecr_repository_name}"
  app_container_name    = "${var.app_container_name}"
  app_service_name      = "${var.app_service_name}"
  repository_url        = "${module.ecs.repository_url}"
  vpc_id                = "${module.vpc.vpc_id}"
  subnet_ids            = [
    "${module.vpc.public_subnet_a}",
    "${module.vpc.public_subnet_b}"
    ]
}