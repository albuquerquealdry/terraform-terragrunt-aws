variable nome_repositorio {
  type = string
  default     = "cluster-k8s"
}

variable cluster_name {
  type = string
  default     = "cluster-k8s"
}

variable group_machine_name {
  type = string
  description = "Node for project"
  default = "Kubernetes Node"
}

variable min_size {
  type = number
  description = "Number min Nodes"
  default = 1
}

variable max_size {
  type = number
  description = "Number max Nodes"
  default = 10
}

variable desired_size {
  type = number
  description = "Number Persistence Nodes"
  default = 3
}

variable instance_type {
  type = list
  description = "Type Machine for nodes"
  default =  ["t2.micro"]
}