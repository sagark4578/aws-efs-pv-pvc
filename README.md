# AWS EFS with PV & PVC

## 🚀 Overview
This repository provides Terraform and Kubernetes configurations to set up **Amazon Elastic File System (EFS)** with **Persistent Volumes (PV) and Persistent Volume Claims (PVC)** for persistent storage in Kubernetes.

## 🛠️ Tech Stack
- **Amazon EFS** – Scalable file storage
- **Kubernetes** – Container orchestration
- **Persistent Volumes & PVC** – Storage management
- **Terraform** – Infrastructure as Code

## 📌 Features
- **EFS Setup** for scalable and persistent storage
- **Kubernetes PV & PVC** configuration for dynamic volume provisioning
- **Automated Deployment** using Terraform and Kubernetes manifests

---

## ⚙️ How to Use

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/sagark4578/aws-efs-pv-pvc.git
cd aws-efs-pv-pvc
```

### 2️⃣ Apply Terraform Configuration
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

### 3️⃣ Deploy Kubernetes Resources
```sh
cd ../k8s
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
```

---
## 🤝 Contribution Guidelines

1. **Fork the Repository**
2. **Create Your Own Branch**

git checkout -b feature-branch

3. **Commit Changes & Push**
   
git commit -m "Added new feature"
git push origin feature-branch

4. **Submit a Pull Request** 🚀

---

## ⚡ Fun Fact
EFS can be mounted on multiple EC2 instances and Kubernetes pods simultaneously, making it a powerful solution for shared storage! 🚀
