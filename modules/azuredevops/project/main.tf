resource "azuredevops_project" "devops_project" {
  name               = var.name
  description        = var.name
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "qep_agile"
}