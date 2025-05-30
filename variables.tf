variable "organization_name" {
    default = "joehammoth"
    type = string
}

# For connecting Terraform to Github for automating 
# version control 

variable "github_app_installation_id" {
    default = 68937355
    type = number
}

# org name for github is just your username

variable "github_organization_name" {
    default = "JoeyHammoth"
    type = string
}