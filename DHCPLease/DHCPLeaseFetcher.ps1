# Definerer filbanen for utdata
$outputFile = "C:\DHCP_Leases.csv"

# Henter DHCP-lease fra serveren
$dhcpLeases = Get-DhcpServerv4Lease -ScopeId *

# Oppretter et tilpasset objekt for hver lease med de ønskede feltene
$leaseData = $dhcpLeases | ForEach-Object {
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
