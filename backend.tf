terraform { 
  cloud { 
    
    organization = "joehammoth" 

    # If renaming the workspace, rename backend as well

    workspaces { 
      name = "fem-eci-tfe" 
    } 
  } 
}