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


function Use-ipnmap {
    $privateip = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex 11 
    $ipaddress = $privateip.IPAddress
    $nmap = nmap.exe $ipaddress
    Write-Output "An nmap was performed to "$ipaddress $nmap
}

function Use-urlnmap {
    $url = 'www.instagram.com'
    $nmap2 = nmap.exe $url
    Write-Output "-----------------------------------------------------------"
    Write-Output "`n" "An nmap was performed to "$url $nmap2
}

#Results are saved without coding
Get-PublicIP | Out-File -FilePath ./resultados.txt 
Get-LocalIP | Out-File -FilePath ./resultados.txt -Append
Use-ipnmap | Out-File -FilePath ./resultados.txt -Append
Use-urlnmap | Out-File -FilePath ./resultados.txt -Append

#Encoding the file
$file = ".\resultados.txt"
[System.Convert]::ToBase64String((Get-Content $file -Encoding Byte)) | Out-File -FilePath ./results.txt 
Write-Output "The results have been saved in a folder called 'results' in the current path"