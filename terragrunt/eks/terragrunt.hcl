
terraform {
  source = "../../terraform-modules/aws/eks"
}



inputs = {
  group_machine_name = "project-poc"
  cluster_name = "cluster-k8s"
  min_size = 1
  max_size             = 10
  desired_size = 3
  instance_types  = ["t2.micro"]
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}