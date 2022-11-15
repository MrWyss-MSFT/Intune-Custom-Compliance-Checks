
$AllowedMatchList     = "DESKTOP-11111111", "LAPTOP-11111111", "MyPrefix-US-"
$ProhibitedMatchList  = "laptop-", "desktop-"
$CompliantWhenNoMatch = $false  # if not in allowed and not in prohibited
$ComputerName = $env:COMPUTERNAME
#$ComputerName = "DESKTOP-11111111"

function isCompliant([bool]$state) {
    return @{'Compliant Computer Name' = $state;} | ConvertTo-Json -Compress
}

if ($COMPUTERNAME -match ($AllowedMatchList -join '|')) {
    #write-host "allowed"
    isCompliant $true
    exit(0)
}

if ($COMPUTERNAME -match ($ProhibitedMatchList -join '|')) {
    #write-host "not allowed"
    isCompliant $false
    exit(0)
}

# Default when not match for allowed or prohibited
#write-host "default"
isCompliant $CompliantWhenNoMatch