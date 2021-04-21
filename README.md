# terraform

This folder holds the reusable terraform files for QVC.

The `modules` folder is copied into terraform of each project folder at the
time terraform is used. The `templates` folder contains jinja templates that
are pushed to the project repository and checked in. The purpose of the
templates is similar to generators that come with frameworks like angular
or express.

Within the `modules` folder, organize first by wrapper modules around pure
provider modules. So, if the provider is `azurerm` the modules go in the
azurerm folder. Beneath that folder, organize by the module name in the
provider, with the provider name removed. So, for `azurerm_app_service_plan`,
the wrapper goes in `azurerm/app_service_plan`. Note this is just for
readability and predictability for users, we make no code assumptions about
this naming relationship.

In general, start with a simple template, hard-coding the normal defaults that
we use, and exposing inputs over time as new requirements emerge. When exposing
a new input variable, always expose the existing hard-coded value as a default.
