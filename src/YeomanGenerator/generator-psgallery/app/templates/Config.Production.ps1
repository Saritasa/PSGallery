<% if (vaultEnabled) { %>
# $env:VAULT_ADDR and $env:VAULT_TOKEN should be set.
$secretPath = 'secret/project-production'<% } %>

Expand-PsakeConfiguration `
@{
    Configuration = 'Release'
<% if (webEnabled) { %>    WebServer = 'web.example.com'
    SiteName = 'example.com'
    DeployUsername = $env:DeployUsername
    DeployPassword = $env:DeployPassword
    WwwrootPath = 'C:\inetpub\wwwroot'<% } %>
<% if (desktopEnabled || windowsServiceEnabled) { %>    AppServer = 'app.example.com'
    ApprootPath = 'C:\approot'<% } %>
<% if (adminTasksEnabled || desktopEnabled || windowsServiceEnabled) { %>    AdminUsername = $env:AdminUsername
    AdminPassword = $env:AdminPassword<% } %>
<% if (windowsServiceEnabled) { %>    ServiceUsername = $env:ServiceUsername
    ServicePassword = $env:ServicePassword<% } %>
<% if (webEnabled || windowsServiceEnabled) { %>
    DatabaseServer = 'mssql.example.com'
    DatabaseUsername = $env:DatabaseUser
    DatabasePassword = $env:DatabasePassword<% } %>
}

<% if (vaultEnabled) { %>
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 'Tls12'
$vault = Get-Vault
$data = Get-Secret $vault $secretPath
$configuration = @{}
$data.PSObject.Properties | ForEach-Object { $configuration[$_.Name] = $_.Value }

Expand-PsakeConfiguration $configuration<% } %>

# Secret Config Example
<% if (vaultEnabled) { %>
<#
{
<% if (adminTasksEnabled || desktopEnabled || windowsServiceEnabled) { %>
  "AdminUsername": "Administrator",
  "AdminPassword": "xxxxxxxx",<% } %>
<% if (windowsServiceEnabled) { %>
  "ServiceUsername": "SvcUser",
  "ServicePassword": "xxxxxxxx",<% } %>
<% if (webEnabled) { %>
  "DeployUsername": "DeployUser",
  "DeployPassword": "xxxxxxxx",<% } %>
<% if (webEnabled || windowsServiceEnabled) { %>
  "DatabaseServer": "mssql.example.com",
  "DatabaseUsername": "dbuser",
  "DatabasePassword": "xxxxxxxx",<% } %>
  "SomeProperty": "xxxxxxxx"
}
#>
<% } else { %>
<#
Expand-PsakeConfiguration `
@{
<% if (adminTasksEnabled || desktopEnabled || windowsServiceEnabled) { %>
    AdminUsername = 'Administrator'
    AdminPassword = 'xxxxxxxx'<% } %>
<% if (windowsServiceEnabled) { %>
    ServiceUsername = 'SvcUser'
    ServicePassword = 'xxxxxxxx'<% } %>
<% if (webEnabled) { %>
    DeployUsername = 'DeployUser'
    DeployPassword = 'xxxxxxxx'<% } %>
<% if (webEnabled || windowsServiceEnabled) { %>
    DatabaseServer = 'mssql.example.com'
    DatabaseUsername = 'dbuser'
    DatabasePassword = 'xxxxxxxx'<% } %>
}
#><% } %>
