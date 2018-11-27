$token = "<your API token here>"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$headers = @{}
$headers.Add("Authorization", "Token $token")

$tenant_url = 'https://demo-admin.awingu.com'
$api_url = $tenant_url + "/api/v2/app-icons/create/"
$domain_url = $tenant_url + "/api/v2/domains/13/"

$icon_path = '/Users/yves/code/github/yveskerwyn/awingu/powershell/calculator.png'
$file_stream = [System.IO.FileStream]::new($icon_path, [System.IO.FileMode]::Open)

$multipart_content = [System.Net.Http.MultipartFormDataContent]::new()

$domain_header = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$domain_header.Name = "domain"
$domain_content = [System.Net.Http.StringContent]::new($domain_url)
$domain_content.Headers.ContentDisposition = $domain_header
$multipart_content.Add($domain_content)

$file_header = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$file_header.Name = "file"
$file_header.FileName = 'calculator.png'
$file_content = [System.Net.Http.StreamContent]::new($file_stream)
$file_content.Headers.ContentDisposition = $file_header
$file_content.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("image/png")
$multipart_content.Add($file_content)

try {
    $response = Invoke-WebRequest -Method 'post' -Uri $api_url -Headers $headers -Body $multipart_content
}
catch {
    Write-Host "Error while creating application icon at $api_url"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}

$obj = ConvertFrom-Json $response.content 
$icon_uri = $obj.uri

return $icon_uri