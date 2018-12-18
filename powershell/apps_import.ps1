function Add-Awingu40Apps {
    param(
        [Parameter(Mandatory=$True)]
        $session,

        [parameter(Mandatory=$True)]
        [string]$path
    )

    $url = $session.url + "/api/v2/apps/"  
    
    [System.Collections.ArrayList]$labels = @()
    [System.Collections.ArrayList]$user_labels = @()
    [System.Collections.ArrayList]$server_labels = @()
    [System.Collections.ArrayList]$autostart_labels = @()

    $params = Get-Content -Raw -Path ($path + "/main.json") |  ConvertFrom-Json

    try {

        [System.Collections.ArrayList]$categories = (Get-Content -Raw -Path ($path + "\categories.json")) -join "`n" | ConvertFrom-Json -ErrorAction Stop

        } catch {

        [System.Collections.ArrayList]$categories = @()
        Get-Content -Raw -Path ($path + "/categories.json") |  ForEach-Object { $null = $categories.Add($_) } 

        }
    
    if ($categories -eq $null) {
        [System.Collections.ArrayList]$categories = @()
        } 

    try {

        [System.Collections.ArrayList]$media_types = (Get-Content -Raw -Path ($path + "/mediatypes.json")) -join "`n" | ConvertFrom-Json
        } catch {

        [System.Collections.ArrayList]$media_types = @()
        Get-Content -Raw -Path ($path + "/mediatypes.json") |  ForEach-Object { $null = $media_types.Add($_) } 

        }
    
    if ($media_types -eq $null) {
        [System.Collections.ArrayList]$media_types = @()
        } 

    $params | add-member -Name "domain" -value $session.domainurl -MemberType NoteProperty
    $params | add-member -Name "labels" -value $labels -MemberType NoteProperty
    $params | add-member -Name "user_labels" -value $user_labels -MemberType NoteProperty
    $params | add-member -Name "server_labels" -value $server_labels -MemberType NoteProperty
    $params | add-member -Name "autostart_labels" -value $autostart_labels -MemberType NoteProperty
    $params | add-member -Name "categories" -value $categories -MemberType NoteProperty
    $params | add-member -Name "media_types" -value $media_types -MemberType NoteProperty

    # Convert from api v1 to v2 if needed

    if ([bool]($params.PSobject.Properties.name -match "workingFolder")) {
            $params | add-member -Name "working_folder" -value $params.workingFolder -MemberType NoteProperty
            $params.PSobject.Properties.Remove("workingFolder")
            }

    if ([bool]($params.PSobject.Properties.name -match "startInForeground")) {
            $params | add-member -Name "start_in_foreground" -value $params.startInForeground -MemberType NoteProperty
            $params.PSobject.Properties.Remove("startInForeground")
            }

    if ([bool]($params.PSobject.Properties.name -match "supportsUnicodeKbd")) {
            $params | add-member -Name "supports_unicode_kbd" -value $params.supportsUnicodeKbd -MemberType NoteProperty
            $params.PSobject.Properties.Remove("supportsUnicodeKbd")
            }

    if (-not ([bool]($params.PSobject.Properties.name -match "concurrent_usage"))) {
            $params | add-member -Name "concurrent_usage" -value $true -MemberType NoteProperty
            }

  
    if ($params.working_folder -eq "") {

            $params.working_folder = $null

            }

    if ($params.description -eq "") {

            $params.description = "/"

            }

    $json = $params | ConvertTo-Json 


    try {

        $response = Invoke-RestMethod -Method Post $url -Body  ([System.Text.Encoding]::UTF8.GetBytes($json))  -WebSession $session1

    


        return $response

        } catch {

            Write-Host "Error while creating app at $url"
            Write-Host $path
            write-host $json
            Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
            Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
            
            Write-Host "--> APP WILL BE SKIPPED" 

            return $null

        }


}
