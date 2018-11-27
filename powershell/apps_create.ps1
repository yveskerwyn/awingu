$token = "<your API token here>"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$headers = @{}
$headers.Add("Authorization", "Token $token")
$headers.Add("Content-Type", "application/json")

$tenant_url = 'https://demo-admin.awingu.com'
$url = $tenant_url + "/api/v2/apps/"

[System.Collections.ArrayList]$categories = @('Utility')
[System.Collections.ArrayList]$labels = @()
[System.Collections.ArrayList]$file_types = @()
[System.Collections.ArrayList]$user_labels = @('all:')
[System.Collections.ArrayList]$server_labels = @('appserver:PRD-DEMO-EU-AP1')
[System.Collections.ArrayList]$autostart_labels = @()
$ask_for_credentials = $false
$command = 'c:\windows\system32\win32calc.exe'
$concurrent_usage = $true
$description = 'This is test'
$domain_url = 'https://demo-admin.awingu.com/api/v2/domains/13/'
$icon_uri = 'https://demo-admin.awingu.com/api/v2/app-icons/874/'
$app_name = 'Super Calculator'
$notifications_enabled = $true
$protocol = 'RDP'
$working_folder = 'test' #if used make sure you specify a value
$start_in_foreground = $false
$supports_unicode_kbd = $true
$source_host_header = '' #if used make sure you specify a valid FQDN
$custom_destination_host_header = '' #if used make sure you specify a valid FQDN
$use_default_destination_host_header = $true
$rewrite = $false
$use_basic_auth_sso = $false
$use_domain_for_basic_auth_sso = $false

$params = @{}

$params | add-member -Name "ask_for_credentials" -value $ask_for_credentials -MemberType NoteProperty
$params | add-member -Name "autostart_labels" -value $autostart_labels -MemberType NoteProperty
$params | add-member -Name "command" -value $command -MemberType NoteProperty
$params | add-member -Name "concurrent_usage" -value $concurrent_usage -MemberType NoteProperty
$params | add-member -Name "categories" -value $categories -MemberType NoteProperty
$params | add-member -Name "description" -value $description -MemberType NoteProperty
$params | add-member -Name "domain" -value $domain_url -MemberType NoteProperty
$params | add-member -Name "icon" -value $icon_uri -MemberType NoteProperty
$params | add-member -Name "labels" -value $labels -MemberType NoteProperty
$params | add-member -Name "file_types" -value $file_types -MemberType NoteProperty
$params | add-member -Name "name" -value $app_name -MemberType NoteProperty
$params | add-member -Name "notifications_enabled" -value $notifications_enabled -MemberType NoteProperty
$params | add-member -Name "protocol" $protocol -MemberType NoteProperty
$params | add-member -Name "working_folder" -value $working_folder -MemberType NoteProperty
$params | add-member -Name "server_labels" -value $server_labels -MemberType NoteProperty
$params | add-member -Name "start_in_foreground" -value $start_in_foreground -MemberType NoteProperty
$params | add-member -Name "supports_unicode_kbd" -value $supports_unicode_kbd -MemberType NoteProperty
#$params | add-member -Name "source_host_header" -value $source_host_header -MemberType NoteProperty
#$params | add-member -Name "custom_destination_host_header" -value $custom_destination_host_header -MemberType NoteProperty
$params | add-member -Name "use_default_destination_host_header" -value $use_default_destination_host_header -MemberType NoteProperty
$params | add-member -Name "rewrite" -value $rewrite -MemberType NoteProperty
$params | add-member -Name "use_basic_auth_sso" -value $use_basic_auth_sso -MemberType NoteProperty
$params | add-member -Name "use_domain_for_basic_auth_sso" -value $use_domain_for_basic_auth_sso -MemberType NoteProperty
$params | add-member -Name "user_labels" -value $user_labels -MemberType NoteProperty

$json = $params | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Method 'post' $url -Body $json -Headers $headers

}
catch {
    Write-Host "Error while creating app at $url"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}

return $response