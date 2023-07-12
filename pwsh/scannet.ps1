[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $InterfaceName="Ethernet",
    [Parameter()]
    [String]
    $AddressFormat="192.168.{0}.{1}",
    [Parameter()]
    [Int]
    $MyAddress=42
)

$oInterface = Get-NetIPInterface -InterfaceAlias $InterfaceName -AddressFamily IPv4
$ifIndex = $oInterface.ifIndex
$adapter = Get-NetAdapter -ifIndex $ifIndex
$oConfig = Get-NetIPConfiguration -InterfaceIndex $ifIndex

[PSCustomObject]@{
    Interface = $oInterface.InterfaceAlias;
    Adapter = $adapter.InterfaceDescription;
    MacAddress = $adapter.MacAddress;
    Dhcp = $oInterface.Dhcp;
    IpAddress = $oConfig.IPv4Address;
}

if ($oInterface.Dhcp -eq 'Enabled') {
    "Disabling DHCP my way"
    Get-NetIPInterface -InterfaceIndex $ifIndex | Set-NetIPInterface -Dhcp Disabled
    "Adding DHCP address as static"
    $null = New-NetIPAddress -InterfaceIndex $ifIndex -AddressFamily IPv4 -IPAddress $oConfig.IPv4Address.IPAddress -PrefixLength 24
    Start-Sleep -Seconds 5
}

for ($netAddr = 0; $netAddr -lt 256; $netAddr++) {
    "Scanning subnet $netAddr"
    Get-NetIPAddress -InterfaceIndex $ifIndex -AddressFamily IPv4 | Remove-NetRoute -ErrorAction SilentlyContinue -Confirm:$false
    Get-NetIPAddress -InterfaceIndex $ifIndex -AddressFamily IPv4 | Remove-NetIPAddress -Confirm:$false
    $newAddr = $AddressFormat -f $netAddr, $MyAddress
    $null = New-NetIPAddress -InterfaceIndex $ifIndex -IPAddress $newAddr -PrefixLength 24
    Start-Sleep -Seconds 5
    #Get-NetIPAddress -InterfaceIndex $ifIndex
    #ipconfig

    for ($devAddr = 1; $devAddr -lt 2; $devAddr++) {
        try {
            $targetAddr = $AddressFormat -f $netAddr, $devAddr
            if (Test-Connection -TargetName $targetAddr -Ping -Count 1 -IPv4 -Quiet -ErrorAction Stop ) {
                "- Found device on $targetAddr"
            }
        }
        catch [System.Exception] {
            $_.Exception
        }
    }
}

"Restoring configuration"

Get-NetIPAddress -InterfaceIndex $ifIndex -AddressFamily IPv4 | Remove-NetIPAddress -Confirm:$false
if ($oInterface.Dhcp -eq 'Enabled') {
    "Re-enabling DHCP"
    Set-NetIPInterface -InterfaceIndex $ifIndex -Dhcp Enabled
    $null = ipconfig /renew "$InterfaceName"
}
else {
    New-NetIPAddress -InterfaceIndex $ifIndex -AddressFamily IPv4 -IPAddress $oConfig.IPv4Address.IPAddress
}
