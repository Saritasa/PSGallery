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
    DatabasePassword = $env:DatabasePassword
<% } %>
}

# Secret Config Example

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
#>