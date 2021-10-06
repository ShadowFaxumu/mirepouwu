Function Paulina ([String]$arg1) 
{
    
    $date = Get-Date
    Write-Host "Hola $arg1, hoy es el $date" -Foreground Cyan
}   

Paulina("profe")


$numero = 1

Write-Host "==Yo cuento del 1 al 10==`n"
do{
    Write-Host $numero
    $numero++
}while($numero -le 10)
if ($numero = 10) {Write-Host "`nAhí nomás quedó"}


