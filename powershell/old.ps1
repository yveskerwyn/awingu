$token = "6a81ac14ee5c33fecd494d713711ea58fe302be4"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$headers = @{}
$headers.Add("Authorization", "Token $token")

$url = 'https://demo-admin.awingu.com/api/v2/app-icons/create/'

$domain_url = "https://demo-admin.awingu.com/api/v2/domains/13/"
$icon_path = '/Users/yves/code/bitbucket/yveskerwyn/awingu/powershell/calculator.png'
$file_stream = [System.IO.FileStream]::new($icon_path, [System.IO.FileMode]::Open)

$multipart_content = [System.Net.Http.MultipartFormDataContent]::new()

$domain_header = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$domain_header.Name = "domain"
$domain_content = [System.Net.Http.StringContent]::new($domain_url)
$domain_content.Headers.ContentDisposition = $domain_header
$multipart_content.Add($domain_content)

$file_header = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
$file_header.Name = "file"
$file_header.FileName = 'calc_icon.png'
$file_content = [System.Net.Http.StreamContent]::new($file_stream)
$file_content.Headers.ContentDisposition = $fileHeader
$file_content.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("image/png")
$multipart_content.Add($file_content)

Invoke-WebRequest -Uri $url -Body $multipart_content -Method 'POST'

$response = Invoke-RestMethod -Method 'post' $url -Headers $headers -Body $multipart_content

$icon_uri = $response.uri

$url = 'https://demo-admin.awingu.com/api/v2/app-icons/'
$response = Invoke-RestMethod -Method 'get' $url -Headers $headers
$response.results | Format-Table