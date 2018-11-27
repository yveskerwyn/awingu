$token = "<your API token here>"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$headers = @{}
$headers.Add("Authorization", "Token $token")

$tenant_url = 'https://demo-admin.awingu.com'
$api_url = $tenant_url + "/api/v2/app-icons/"

try {
    $response = Invoke-RestMethod -Method 'get' $api_url -Headers $headers
}
catch {
    Write-Host "Error while listing application icons at $api_url"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}

$response.results | Format-Table