# Stuff that exists outside current automation that needs
# to be looked up

# Tell tf which workspaces have access to the installation
# to setup connection between workspace and repo. 
# Pass the variable to a data lookup (API call to tf cloud)

data "tfe_github_app_installation" "this" {
    installation_id = var.github_app_installation_id
}