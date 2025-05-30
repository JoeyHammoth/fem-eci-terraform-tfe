module "project" {
  # for each is defined which goes through the entire map within 
  # the locals list
  for_each =  local.project

  source  = "ALT-F4-LLC/project/tfe"
  version = "0.5.0"
  # insert the 3 required variables here

  # Get the values in the for each and within the values, get the 
  # description. For the name, retrieve the key
  description = each.value.description
  name = each.key
  organization_name = var.organization_name
}

module "workspace" {
  for_each = local.workspace

  source  = "ALT-F4-LLC/workspace/tfe"
  version = "0.8.0"
  # insert the 4 required variables here

  description = each.value.description
  execution_mode = each.value.execution_mode
  name = each.key
  organization_name = var.organization_name
  project_id = each.value.project_id
}

# Create moved since tf create module.workspace not 
# module.workspace["fem-eci-workspace"]

# Resources that are going to get deleted must get moved
moved {
  from = module.project
  to = module.project["fem-eci-project"]
}

moved {
  from = module.workspace
  to = module.workspace["fem-eci-workspace"]
}

# Used for renaming
moved {
  from = module.workspace["fem-eci-workspace"]
  to = module.workspace["fem-eci-tfe"]
}