# Definerer filbanen for utdata
$outputFile = "C:\DHCP_Leases.csv"

# Henter DHCP-lease fra serveren
$dhcpScopes = Get-DhcpServerv4Scope

# Initialiser en tom liste for leieavtaler
$allLeases = @()

# Går gjennom hvert omfang og henter lease-tida
foreach ($scope in $dhcpScopes) {
    $leases = Get-DhcpServerv4Lease -ScopeId $scope.ScopeId
    $allLeases += $leases
}

# Oppretter et tilpasset objekt for hver lease med de ønskede feltene
$leaseData = $allLeases | ForEach-Object {
    [PSCustomObject]@{
        ScopeId      = $_.ScopeId
        IPAddress    = $_.IPAddress
        HostName     = $_.HostName
        ClientID     = $_.ClientId
        AddressState = $_.AddressState
    }
}

# Eksporter dataene til en CSV-fil
$leaseData | Export-Csv -Path $outputFile -Delimiter ';' -NoTypeInformation -Encoding UTF8

# Skriv ut melding for å bekrefte at eksporten er ferdig :)
Write-Host "DHCP-leases har blitt eksportert til $outputFile"

Sleep 3
