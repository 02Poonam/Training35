

---

## **Project Overview**

Create a comprehensive automated deployment pipeline for a web application on an AWS EC2 instance running Ubuntu using Ansible. You will follow best practices for playbooks and roles, implement version control, document and maintain your code, break down tasks into roles, write reusable and maintainable code, and use dynamic inventory scripts. This project will culminate in a fully functional deployment, demonstrating your mastery of Ansible for infrastructure automation.

## **Project Objectives**
    • Set up an AWS EC2 instance as a worker node.
    • Implement Ansible playbooks and roles following best practices.
    • Use version control to manage Ansible codebase.
    • Document Ansible roles and playbooks.
    • Break down deployment tasks into reusable roles.
    • Write reusable and maintainable Ansible code.
    • Use dynamic inventory scripts to manage AWS EC2 instances.
    • Deploy a web application on the EC2 instance. 

### **Milestone 1: Environment Setup**

**Objective: Configure your development environment and AWS infrastructure.**

1. **Launch an AWS EC2 Instance Running Ubuntu:**
   - Log in to your AWS Management Console.
   - Navigate to EC2 Dashboard.
   - Click "Launch Instance".
   - Choose "Ubuntu" as the Amazon Machine Image (AMI).
   - Select an instance type (e.g., t2.micro).
   - Configure instance details, add storage, and configure security groups (ensure SSH access is enabled).
   - Review and launch the instance. Download the key pair if prompted.

2. **Install Ansible and Git on Your Local Machine:**
   - Open a terminal and run the following commands:

     ```bash
     # Update package index
     sudo apt update

     # Install Ansible
     sudo apt install -y ansible

     # Install Git
     sudo apt install -y git
     ```

**Deliverables:**
- AWS EC2 instance running Ubuntu.
![alt text](img1.png)

- Local or remote control node with Ansible and Git installed.
![alt text](img2.png)

---

### **Milestone 2: Create Ansible Role Structure**

**Objective: Organize your Ansible project using best practices for playbooks and roles.**

1. **Create Directory Structure and Initialize Roles:**

   ```bash
   mkdir my_ansible_project
   cd my_ansible_project
   ansible-galaxy init roles/webserver
   ansible-galaxy init roles/database
   ansible-galaxy init roles/application
   ```

**Deliverables:**
- Ansible role directories for `webserver`, `database`, and `application`.

---

### **Milestone 3: Version Control with Git**

**Objective: Implement version control for your Ansible project.**

1. **Initialize a Git Repository:**

   ```bash
   cd my_ansible_project
   git init
   ```

2. **Create a `.gitignore` File:**
   - Create a `.gitignore` file in the root directory with:

     ```
     *.log
     *.tmp
     .env
     ```
3. **Commit and Push Initial Codebase:**

   ```bash
   git add .
   git commit -m "Initial commit with Ansible roles"
   ```
   - Create a remote repository on GitHub or another service.
   - Push the code:

     ```bash
     git remote add origin <REMOTE_REPOSITORY_URL>
     git push -u origin master
     ```
**Deliverables:**
- Git repository with initial Ansible codebase.
- Remote repository link (e.g., GitHub).
![alt text](img3.png)

Github Link: https://github.com/02Poonam/ansible-project-D19
---

### **Milestone 4: Develop Ansible Roles**

**Objective: Write Ansible roles for web server, database, and application deployment.**

1. **Develop the `webserver` Role:**

   - **Create `roles/webserver/files/index.html`:**

     ```html
     <!DOCTYPE html>
     <html lang="en">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Welcome to My Web Application</title>
         <style>
             body {
                 font-family: Arial, sans-serif;
                 text-align: center;
                 padding: 50px;
                 background-color: #f4f4f4;
             }
             h1 {
                 color: #333;
             }
             p {
                 color: #666;
             }
         </style>
     </head>
     <body>
         <h1>Welcome to My Web Application</h1>
         <p>This is a basic HTML page served by Nginx.</p>
     </body>
     </html>
     ```
![alt text](img4.png)

   - **Update `roles/webserver/tasks/main.yml`:**

     ```yaml
     ---
     - name: Install Apache
       apt:
         name: apache2
         state: present
       become: yes

     - name: Start Apache service
       service:
         name: apache2
         state: started
         enabled: yes
       become: yes

     - name: Deploy the index.html file
       copy:
         src: index.html
         dest: /var/www/html/index.html
         owner: www-data
         group: www-data
         mode: '0644'
       become: yes
     ```
![alt text](img5.png)

2. **Develop the `database` Role:**

   **Update `roles/database/tasks/main.yml`:**

     ```yaml
    ---
    - name: Install MySQL Server
      apt:
        name: mysql-server
        state: present
      become: yes

    - name: Start MySQL service
      service:
        name: mysql
        state: started
        enabled: yes
      become: yes

    - name: Ensure MySQL is running
      service:
        name: mysql
        state: started
        enabled: yes
      become: yes
              
     ```
![alt text](img6.png)

3. **Develop the `application` Role:**

   - **Create a Simple Flask Application:**

     - **Create a directory for the application files:**

     - **Create a basic Flask application (`ansible-project-D19/roles/application/files/app.py`):**

       ```python
       from flask import Flask

       app = Flask(__name__)

       @app.route('/')
       def hello_world():
           return 'Hello, World!'

       if __name__ == '__main__':
           app.run(host='0.0.0.0', port=5000)
       ```

   - **Update `roles/application/tasks/main.yml`:**

     ```yaml
       ---
        - name: Install Python and Pip
          apt:
            name:
            - python3
            - python3-pip
            - python3-venv
            state: present
          become: yes

        - name: Create application directory
          file:
            path: /var/www/myapp
            state: directory
            owner: www-data
            group: www-data
            mode: '0755'
          become: yes

        - name: Create a Python virtual environment
        command: python3 -m venv /var/www/myapp/venv
        become: yes

        - name: Deploy Flask Application Files
        synchronize:
            src: /home/einfochips/my_ansible_project/roles/application/files/
            dest: /var/www/myapp/
            recursive: yes
        become: yes

        - name: Install Flask and other dependencies
        pip:
            name:
            - Flask==2.0.1
            - requests==2.25.1
            virtualenv: /var/www/myapp/venv
        become: yes

        - name: Start Flask Application
        shell: |
            /var/www/myapp/venv/bin/python /var/www/myapp/app.py > /var/log/myapp.log 2>&1 &
        become: yes

     ```
![alt text](img7.png)

**Deliverables:**
- Completed Ansible roles for `webserver`, `database`, and `application`.

---

### **Milestone 5: Documentation and Maintenance**

**Objective: Document your Ansible roles and playbooks for future maintenance.**

1. **Create `README.md` Files for Each Role:**


2. **Add Comments within Playbooks and Roles:**

**Deliverables:**
- `README.md` files for `webserver`, `database`, and `application` roles.
- Well-documented playbooks and roles.

---

### **Milestone 6: Dynamic Inventory Script**
To install aws cli use 
```
sudo apt install awscli
```

```
    aws configure
```
Enter the key_id and access_key


**Objective: Use dynamic inventory scripts to manage AWS EC2 instances.**

1. **Create a Python Script to Query AWS:**

   **Example `dynamic_inventory.py`:**

   ```python
   #!/usr/bin/env python3
   import boto3
   import json

   ec2 = boto3.client('ec2')

   def main():
       response = ec2.describe_instances()
       inventory = {'_meta': {'hostvars': {}}}
       for reservation in response['Reservations']:
           for instance in reservation['Instances']:
               inventory.setdefault('all', {'hosts': []})
               inventory['all']['hosts'].append(instance['PublicDnsName'])
               inventory['_meta']['hostvars']

        instance['PublicDnsName'] = {
            'instance_id': instance['InstanceId'],
            'private_ip': instance.get('PrivateIpAddress', 'N/A'),
            'public_ip': instance.get('PublicIpAddress', 'N/A')
               }
    print(json.dumps(inventory, indent=2))

    if __name__ == '__main__':
       main()
   ```
![alt text](img8.png)

**Deliverables:**
- Dynamic inventory script to fetch EC2 instance details.

---

### **Milestone 7: Playbook Development and Deployment**

**Objective: Create and execute an Ansible playbook to deploy the web application.**

1. **Develop a Master Playbook:**

   **Example `playbook.yml`:**

   ```yaml
   ---
   - name: Deploy Web Application
     hosts: all
     become: yes
     roles:
       - webserver
       - database
       - application
   ```
![alt text](img9.png)

Make the Script Executable: Ensure your script is executable:
```chmod +x /path/to/ec2_inventory.py```

2. **Define Inventory and Variable Files:**


3. **Execute the Playbook:**

   ```bash
   ansible-playbook -i ec2_inventory.py playbook.yml
   ```
   
![alt text](<img10.png>)
**Deliverables:**
- Ansible playbook for web application deployment.
- Successfully deployed web application on the EC2 instance.

---

This updated guide provides a complete solution, including a basic Flask application for the `application` role. This setup allows you to deploy a simple web application on your EC2 instance using Ansible.