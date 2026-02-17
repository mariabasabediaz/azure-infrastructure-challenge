# azure-infrastructure-challenge
# Azure Infrastructure Challenge - Part 2

Este repositorio contiene la configuración de **Infraestructura como Código (IaC)** para desplegar entornos dinámicos en Azure utilizando Terraform.

## 🏗️ Arquitectura de la Solución
El código despliega de forma automatizada los siguientes recursos:
- **Azure Resource Group**: Organizado por ambiente.
- **Azure Storage Account**: Configurado como sitio web estático para hospedar la aplicación.
- **Azure CDN**: Para la distribución global y baja latencia.
- **Log Analytics Workspace**: Para el monitoreo y auditoría de logs.

## 🌐 Ambientes Dinámicos
Gracias al uso de variables, este proyecto soporta despliegues aislados para:
- `devel` (Desarrollo)
- `stage` (Staging)

## 🛠️ Requisitos
- Terraform >= 1.0
- Azure CLI
- Cuenta de Azure (Suscripción activa)

## 🚀 Comandos Rápidos
Para inicializar un ambiente (ejemplo devel):
```bash
terraform init
terraform plan -var="environment=devel"
terraform apply -var="environment=devel"
