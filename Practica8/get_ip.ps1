#Created by ShadowFax


function Get-PublicIP {
    $publicip = Invoke-WebRequest ifconfig.me | Select -ExpandProperty Content 
    Write-Output "Your public ip is: "$publicip "`n"
}


function Get-LocalIP {
    $localip = Get-NetIPAddress -AddressFamily IPv4 | Format-Table
    Write-Output "Your local ip addresses are: "
    Write-Output $localip
} 


Get-PublicIP
Get-LocalIP