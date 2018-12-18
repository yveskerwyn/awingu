# Config
$token = "..."
$tenant_url = 'https://demo-admin.awingu.com'
$days = 10
$domain_name = 'ADMIN'
#$domain_id = 13

# Result will be stored in: 
#$activities_list = New-Object System.Collections.ArrayList

# Force Powershell to use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Add Token to the header
$headers = @{}
$headers.Add("Authorization", "Token $token")
$headers.Add("Content-Type", "application/json")

# Get the domain URI
$api_url = $tenant_url + "/api/v2/domains/"

try {
    $domain_uri = (Invoke-RestMethod -Method get -Uri $api_url -Headers $headers).results.uri
}
catch {
    Write-Host "Error while getting domain $api_url"
    exit
}

# Create timestamps
$timestamp_from = (get-date).AddDays(-$days).ToUniversalTime().ToString("yyyy-MM-ddThh:mm:00")
$timestamp_to = (get-date).ToUniversalTime().ToString("yyyy-MM-ddT23:59:59") 

# Prepare the API url to get the activities
$api_url = $tenant_url + "/api/v2/user-sessions/"

# Add the query string
$api_url = $api_url + "?"
$api_url = $api_url + "limit=10000"
#$api_url = $api_url + "&offset=0"
$api_url = $api_url + "&status=ACTIVE"
$api_url = $api_url + "&status=DISCONNECTED"
#$api_url = $api_url + "&status=RESERVED"
#$api_url = $api_url + "&status=CLOSED"
$api_url = $api_url + "&start=$timestamp_from"
$api_url = $api_url + "&end=$timestamp_to"
#$api_url = $api_url + "&domain=$domain_id"
$api_url = $api_url + "&domain_name=$domain_name"

# Get the activities
try {
    $response = Invoke-RestMethod -Method 'get' $api_url -Headers $headers
}
catch {
    Write-Host "Error while listing application icons at $api_url"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}

$response.results | Format-Table