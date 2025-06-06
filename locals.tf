# This is a key-value pair or hashmap where the key is the name 
# of the project or workspace and the values are the 
# attributes that are unique to each project/workspace. 

# Every other attribute that are not defined here stay the same 
# as is defined in the modules. 

locals {
    project = {
        "fem-eci-project" = {
            description = "Example description of a project"
        }
    }
    workspace = {
        "fem-eci-tfe" = {
            description = "Example description of a workspace"
            execution_mode = "remote"
            
            # Turns from module.project.id to module.project["fem-eci-workspace"].id
            # since due to making a multiple projects and workspaces
            # using the key-value approach, each project/workspace
            # has to have a unique key. We need to specify what
            # project we are getting the id from. 
            project_id = module.project["fem-eci-project"].id
            vcs_repo_identifier = "JoeyHammoth/fem-eci-terraform-tfe"
        }

        "fem-eci-github" = {
            description = "Example description for Github resources"
            execution_mode = "remote" # Set to local first and when you apply, set it to remote
            project_id = module.project["fem-eci-project"].id
            vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-github"
        }

        "fem-eci-aws-network" = {
            description         = "Automation for AWS network resources."
            execution_mode      = "remote"
            project_id          = module.project["fem-eci-project"].id
            vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-aws-network"

            variables = [
                {
                category = "terraform"
                hcl      = true
                key      = "azs"
                value    = jsonencode(["us-west-2a", "us-west-2b"])
                },
                {
                category = "terraform"
                key      = "cidr"
                value    = "10.0.0.0/16"
                },
                {
                category = "terraform"
                key      = "name"
                value    = "fem-eci"
                },
            ]
        }

            "fem-eci-aws-cluster-prod" = {
            description         = "Automation for AWS cluster resources."
            execution_mode      = "remote"
            project_id          = module.project["fem-eci-project"].id
            vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-aws-cluster"

            variables = [
                {
                category = "terraform"
                key      = "domain"
                value    = "<your-top-level-domain>"
                },
                {
                category = "terraform"
                key      = "environment"
                value    = "prod"
                },
                {
                category = "terraform"
                key      = "name"
                value    = "fem-eci-<your-name>"
                },
                {
                category = "terraform"
                key      = "vpc_name"
                value    = "fem-eci"
                },
            ]
        }
    }
}