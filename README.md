# **Secure WordPress Deployment on AWS with Terraform**

## **Project Overview**

This project demonstrates the automated deployment of a secure WordPress website on AWS using **Terraform** for infrastructure provisioning. The setup includes **Amazon ECS (Elastic Container Service)** with **Fargate** as the launch type, **Amazon RDS** for database management, and **Amazon EFS** for persistent storage. The configuration focuses on security and scalability to ensure the WordPress application runs efficiently and can scale with demand.

---

## **Key Features**

- **Infrastructure as Code (IaC)**: Full infrastructure provisioning using Terraform.
- **ECS with Fargate**: Containerized WordPress deployment with the flexibility of Fargate, enabling serverless computing.
- **Secure Setup**: IAM roles, security groups, and access management configured to ensure secure communication and access to resources.
- **Scalability**: Auto-scaling capabilities for both ECS tasks and RDS instances based on demand.
- **Persistent Storage**: Integration of Amazon EFS for shared storage between containers.

---

## **Technologies Used**

- **Terraform**: Infrastructure automation tool to provision and manage AWS resources.
- **AWS ECS (Fargate)**: Managed container service to run WordPress in a containerized environment.
- **Amazon RDS**: Managed relational database service used for WordPress data storage.
- **Amazon EFS**: Managed file storage to store WordPress files persistently across container instances.
- **IAM (Identity and Access Management)**: Security mechanism for managing permissions and roles.
- **AWS Security Groups**: Virtual firewalls to control inbound and outbound traffic to instances.
  
---

## **Infrastructure Components**

### **1. ECS Cluster with Fargate**
- **Amazon ECS (Elastic Container Service)** is used to run the WordPress application. The Fargate launch type allows the containers to run without managing the underlying EC2 instances.
- Terraform provisions the ECS cluster, services, and tasks to define how containers will run, ensuring scalability and security.
  
### **2. RDS for Database**
- **Amazon RDS** is used to manage the MySQL database for WordPress. Terraform provisions the database instance with proper security groups and backups.
- The RDS instance is configured for high availability with multi-AZ deployment.

### **3. EFS for Persistent Storage**
- **Amazon EFS** provides scalable and high-performance file storage. It is used to store WordPress files, ensuring that data persists across ECS container restarts.

### **4. IAM Configuration**
- Custom **IAM roles** are created to grant the necessary permissions for the ECS tasks and RDS instances. These roles follow the principle of least privilege, ensuring that each service only has the permissions it requires.
- **IAM policies** and **instance profiles** are applied to secure the environment and restrict access to other AWS resources.

### **5. Security Groups**
- AWS **Security Groups** are used to control inbound and outbound traffic between ECS containers, RDS, and the internet. Only necessary ports (like 80 for HTTP and 443 for HTTPS) are open for the WordPress application.

---

## **Steps to Deploy**

1. **Clone the repository**:
   - Clone the project repository to your local machine to begin the deployment.

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Configure Terraform provider**:
   - Set up the AWS provider in Terraform by configuring AWS credentials and region.
   
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }
   ```

3. **Initialize Terraform**:
   - Initialize Terraform in the project directory to download necessary plugins and modules.

   ```bash
   terraform init
   ```

4. **Plan the deployment**:
   - Review the changes Terraform will make before applying them.

   ```bash
   terraform plan
   ```

5. **Apply the changes**:
   - Apply the configuration to provision the AWS resources.

   ```bash
   terraform apply
   ```

   This will deploy the ECS cluster, RDS instance, EFS, IAM roles, and security groups as defined in the Terraform configuration.

6. **Access WordPress**:
   - After the deployment is complete, you will receive the **public IP** of the ECS service. Access the WordPress site by navigating to this IP address in your browser.

---

## **Outcome**

- Successfully deployed a highly available and secure WordPress website using **AWS Fargate**, **RDS**, and **EFS**.
- Fully automated infrastructure provisioning using **Terraform**, making the deployment process repeatable and scalable.
- Configured a secure environment with best practices in IAM roles and security groups.
- Ensured persistent storage for WordPress files and data with Amazon EFS and RDS.

---

## **Challenges & Learnings**

- **Networking Configuration**: Configuring the security groups and VPC settings required careful attention to ensure proper communication between ECS tasks, RDS, and EFS without exposing unnecessary ports.
- **Scaling**: Ensuring the WordPress application could scale efficiently required configuring both the ECS and RDS instances to handle high traffic and database queries.

---

## **Conclusion**

This project demonstrates how to deploy a secure, scalable WordPress website on AWS using modern cloud-native technologies and Terraform for infrastructure automation. By leveraging AWS managed services such as ECS, RDS, and EFS, this project provides a highly available and cost-effective solution for hosting WordPress with minimal operational overhead.

---

This documentation provides a comprehensive and well-structured explanation of your project. Let me know if you'd like to adjust any section or add further details!
