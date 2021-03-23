function Get-UrlStatusCode([string] $Url){
    try{
        (Invoke-WebRequest -Uri $Url -UseBasicParsing -DisableKeepAlive).StatusCode
    } catch [Net.WebException] {
        [int]$_.Exception.Response.StatusCode
    }
}

$Site2Check = 'https://google.de'

# Logging Section
$logfile =  "C:\temp\ps1status.log"

function generateTimestamp(){
	$logstamp = Get-Date -Format "[yyyy-MM-dd HH:mm:ss]:"
    return $logstamp
}

$logstamp = generateTimestamp
Write-Host "$logstamp Logger startet"
Add-Content -Path $logfile -Value "$logstamp Logger startet"

while($true){
    $logstamp = generateTimestamp
    $HTTP_Status = Get-UrlStatusCode $Site2Check
    If ($HTTP_Status -eq 200) {
        Write-Host "$logstamp $Site2Check reachable. Statuscode: $HTTP_Status"
        Add-Content -Path $logfile -Value "$logstamp $Site2Check reachable. Statuscode: $HTTP_Status"
    } else {
        Write-Host "$logstamp Webserver at $Site2Check could not be reached. Statuscode: $HTTP_Status"
        Add-Content -Path $logfile -Value "$logstamp Webserver at $Site2Check could not be reached. Statuscode: $HTTP_Status"
    }
    Start-Sleep -Seconds 10
}   



