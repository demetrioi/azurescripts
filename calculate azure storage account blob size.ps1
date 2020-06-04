#Calculate Azure Storage Account used size using PowerShell and az client. 
#For more information go to https://demetriosilva.wordpress.com/2020/06/04/azure-storage-account-espaco-usado-blob/

#change the parameters

$container = 'yourContainerName'
$con = 'yourAzStConnString'

az login

$ret = az storage blob list `
    --container-name $container --query "[*].[properties.contentLength]" `
    --connection-string $con `
    --output table 

$total = 0

foreach ($item in ($ret | Select-Object -skip 2)){
    $total += [math]::Round($item / 1MB, 2)
} 

Write-Host $total 
