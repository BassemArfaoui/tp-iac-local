# TP IaC Local — Terraform + Docker + CI/CD

## Prérequis
Docker Desktop (lancé), Terraform >= 1.0, Git.

## Partie I — Cycle de vie (DLC)
```powershell
terraform init                  # 1. Initialisation
terraform plan                  # 2. Planification
terraform apply -auto-approve   # 3. Application
# 4. Validation : ouvrir http://localhost:8080/
terraform destroy -auto-approve # 5. Destruction
```

## Partie II — Pipeline CI/CD
Le pipeline `.github/workflows/main.yml` s'exécute à chaque push sur `main` :
Setup -> Init -> Plan -> Apply (Apply seulement si Plan a réussi).

Note : sous Linux / CI, la variable `docker_host` est remplacée par
`unix:///var/run/docker.sock` via `TF_VAR_docker_host`.
