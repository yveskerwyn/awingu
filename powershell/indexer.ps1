# Config
$token = "..."
$tenant_url = "https://demo-admin.awingu.com"
$days = 10
$user_session_filter = "*"

# Result will be stored in: 
$app_list = New-Object System.Collections.ArrayList

# Force Powershell to use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Add Token to the header
$headers = @{}
$headers.Add("Authorization", "Token $token")
$headers.Add("Content-Type", "application/json")

# Get the domain URI
$api_url = $tenant_url + "/api/v2/domains/"
$domain = (Invoke-RestMethod -Method get -Uri $api -Headers $headers).results.uri

# Create timestamps
$TS_from = (get-date).AddDays(-$days).ToUniversalTime().ToString("yyyy-MM-ddThh:mm:00.000Z")
$TS_to   = (get-date).ToUniversalTime().ToString("yyyy-MM-ddThh:mm:00.000Z") 

# Get User session logs
$json =  @{
        domain = $domain
        query_filter = $user_session_filter
        query_name= "awingu_sessions"
        size = 500000
        timestamp_from = $TS_from
        timestamp_to = $TS_to
        } | ConvertTo-Json


$api = $tenant_url + "/api/v2/indexer/"
$userlogs = Invoke-RestMethod -Method post -Uri $api -Body $json -Headers $headers

# Get Application session logs
$json =  @{
        domain = $domain
        query_filter = "*"
        query_name= "application_sessions"
        size = 500000
        timestamp_from = $TS_from
        timestamp_to = $TS_to
        } | ConvertTo-Json


$api = $tenant_url + "/api/v2/indexer/"
$applogs = Invoke-RestMethod -Method post -Uri $api -Body $json -Headers $headers

# Output

ForEach ($app in $applogs) {
    
        $user = $userlogs | where-Object -Property session_id -eq -Value $app.awingu_session_id
        
        if ($user) {
        	
            $obj = New-Object System.Object
            $obj | Add-Member -MemberType NoteProperty -Name "user_name" -Value $user.username
            $obj | Add-Member -MemberType NoteProperty -Name "external_ip" -Value $user.ip
            $obj | Add-Member -MemberType NoteProperty -Name "geo_ip_location" -Value $user.'geoip.location'
            $obj | Add-Member -MemberType NoteProperty -Name "user_session_start" -Value $user.session_start
            $obj | Add-Member -MemberType NoteProperty -Name "user_session_stop" -Value $user.session_end
            $obj | Add-Member -MemberType NoteProperty -Name "session_labels" -Value $user.session_labels
            $obj | Add-Member -MemberType NoteProperty -Name "domain" -Value $user.domain
            $obj | Add-Member -MemberType NoteProperty -Name "server" -Value $app.server
            $obj | Add-Member -MemberType NoteProperty -Name "port" -Value $app.port
            $obj | Add-Member -MemberType NoteProperty -Name "exe" -Value $app.exe
            $obj | Add-Member -MemberType NoteProperty -Name "recorded" -Value $app.recorded
            $obj | Add-Member -MemberType NoteProperty -Name "app_session_start" -Value $app.appsession_start
            $obj | Add-Member -MemberType NoteProperty -Name "app_session_stop" -Value $app.appsession_end
        
            $app_list.Add($obj) | Out-Null

            }

        }


$app_list

# $app_list | select user_name, server, exe, app_session_start, app_session_stop | Format-Table