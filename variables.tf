variable "environment" {
  type        = string
  description = "Ambiente de despliegue (devel o stage)"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Región de Azure donde se crearán los recursos"
}

variable "project_name" {
  type    = string
  default = "fsl-challenge"
}
