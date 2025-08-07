![tkdev_space_200](https://github.com/user-attachments/assets/31af05be-97b5-4d4e-82ef-4f23203eb7ac)

<br>

# 🧪 Lab 5 - Using Modules

In this lab you learn about modules and why they're important to creating dynamic and reusable code, then you will get hands-on and deploy some modularized code yourself. This code is the exact code from lab 4 with the key difference being it's structure and that it's been modularized.   

### Resources Created:
This demo creates the following resources:

- VPC
- (2) Subnets
- Security Group
- Security Group Policies
- (2) EC2 Instances
- (2) Elastic IPs (EIPs)
- (2) Virtual NICs
- (2) Route Table Associations
- Internet Gateway (IGW)
- Default route to IGW

<br>

# 💡 Terms and Concepts

This lab is quite extensive and has two parts. Part 1 is analysis and deployment of static code. Part 2 is analysis and deployment of dynamic code. The purpose of this two part lab is to introduce you to variables, functions, logic loops (meta-arguments), and other more advanced topics by showing you why they make our code better and more reusable. Reusable code makes our jobs as engineers easier because instead of re-inventing the wheel every single deployment, we can just take something that already exists and modularize it, modify a few variables, and deploy it. The biggest takeaway from this lab should be the understanding of why we want our code to be more dynamic and rely less on statically typed attributes or characteristics of our resources 


## Terraform Modules

Modules are a way to turn your code into a reusable package or a blackbox. You don't necessarily need to know all the details of how the module works, you just need to know how to interact with it from the outside like what inputs to give it and what outputs to expect. Modularizing your code is another way to make it resuable and dynamic. All modules have a root module which consists of resources in your various .tf files. Generally you want to structure your module 

<br>

# 📖 Suggested Reading

I recommend reading the entire modules page of the official HashiCorp documentation.

<br>

- [Modules](https://developer.hashicorp.com/terraform/language/modules)
- [Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

<br>

# Lab Steps

### 1. Fork the [iac-intro-lab-5-template](https://github.com/tkerbe2/iac-intro-lab-5-template) repo with your own personal GitHub.

- Fork this repo in your own personal GitHub.

<img width="1225" height="49" alt="image" src="https://github.com/user-attachments/assets/2c8fd6a4-7a15-44aa-a44f-2fa0cdd20584" />

<br>

***

<br>

### 2. Fork the [iac-intro-lab-5](https://github.com/tkerbe2/iac-intro-lab-5) repo with your own personal GitHub as well.

- Fork this repo in your own personal GitHub.

<img width="1242" height="45" alt="image" src="https://github.com/user-attachments/assets/2c8afa17-9b35-479b-a891-64841c098933" />

<br>

***

<br>

### 3. Analyze the modular code with VS Code.

- Open the forked repo from step 2. with Visual Studio Code.
- This is the identical code to [iac-intro-lab-4](https://github.com/tkerbe2/iac-intro-lab-4) code, except that it's been turned into a module.
- Notice its structure and how it has a folder called modules and then a sub folder called web-app.
- Under the web-app subfolder, all the .tf files reside.
- Note what files are here from the previous code and what files are missing.

<img width="251" height="244" alt="image" src="https://github.com/user-attachments/assets/d6fb5bdb-95f8-4b36-8898-4bb15a323317" />

<br>

***

<br>

### 4. Open variables.tf.

- Notice all the same variables are declared just as they were before.
- I have removed the comments from the lab 4 code but everything else is the same.

### 5. Open the template code with VS Studio Code.

- Open your forked repo of [iac-intro-lab-5-template](https://github.com/tkerbe2/iac-intro-lab-5-template).
- Notice there are only 3 files.

<img width="257" height="130" alt="image" src="https://github.com/user-attachments/assets/4f629de8-e647-41aa-b156-96afea9314ad" />

- We are going to use this main.tf to provide variables to the source module from my public GitHub repo.
- Remember earlier when I said modules can behave like a blackbox or a function. This is what I meant.
- We don't have to even know what the other code looks like, we just have to know what to provide it.

<br>

***

<br>

### 6. Configure the module variables.
- Open the main.tf file and notice it looks very similar to a terraform.tfvars. This is because I essentially pasted these into this file while adding the module block.
- The module block has one required argument and it's source
- The only real difference is we're making the region variable a global variable by putting it into main.tf like this.
- I want you to provide variables that are different from what is in the default.
- Change the env, org_name, cidr_block, and region.

<br>

```
variable "region" {
    default = "us-east-1"
    description = "Used to specify the region to deploy our resources to and apply to naming conventions."
}


module "web-app" {
    
# Our source is just our GitHub repo where our module code lives.
    source  = "git::https://github.com/tkerbe2/iac-intro-lab-5.git//modules/web-app"

# For this example I have used all the same variables but you can change these for your deployment. 
    borrowed_bits = 5
    region        = "us-west-2"
    env           = "prod"
    org_name      = "abc-corp"
    instance_type = "t3.micro"
    cidr_block    = "192.168.70.0/23"
    
    region_codes = {
        us-east-1 = "ue1"
        us-east-2 = "ue2"
        us-west-1 = "uw1"
        us-west-2 = "uw2"
    }
    
    availability_zones = {
        0 = "us-east-1a"
        1 = "us-east-1b"
    }

}
```

<br>

***

<br>
 
### 7. Save and commit your changes.

- Save and commit your changes to this repo.

<br>

***

<br>

### 8. Create a new workspace in Terraform Cloud.

- Log into [Terraform Cloud](https://app.terraform.io/app).
- Click New and select workspace.
- Select Version Control Workflow.

<br>

<img width="374" height="252" alt="image" src="https://github.com/user-attachments/assets/b1e250ad-7e36-4129-90d5-ec92d24fa804" />

<br>

- Select your forked template repo.

<br>

<img width="690" height="352" alt="image" src="https://github.com/user-attachments/assets/c358378f-93d3-4989-ad71-d237896c2138" />

<br>

- Provide your workspace variables.

<br>

<img width="1159" height="273" alt="image" src="https://github.com/user-attachments/assets/86bf2b81-589e-4102-beae-d9a0906b5a7e" />

<br>

- Run a plan and apply and if successful you should see 15 resources to create. You've successfully used a module to create resources!

<br>

<img width="1132" height="177" alt="image" src="https://github.com/user-attachments/assets/278202e3-debe-4e20-99ef-b5b53b0330aa" />

<br>

***

<br>

# ✨ Congratulations!

***

You've finished this lab and have completed the following items:
- ✅ Cloned our module repo.
- ✅ Cloned the template repo.
- ✅ Analyzed both repos.
- ✅ Changed some variables on our main.tf file in our module code.
- ✅ Created a new workspace.
- ✅ Ran a plan and apply successfully and planned resources with our module.

***




