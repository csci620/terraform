output "databricks_token" {
  value     = databricks_token.token.token_value
  sensitive = true
}