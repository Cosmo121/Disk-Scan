<#############################################################
CREATED BY: mike hartman
CONTACT: michael.hartman0@gmail.com
CONTACT: https://thepc.co
CONTACT: https://github.com/Cosmo121
LATEST VERSION: https://github.com/Cosmo121/Disk-Scan
#############################################################>

# Setup requirements
New-Item -Path "c:\temp\diskspacereports" -Name "DiskReport" -ItemType "directory" -ErrorAction SilentlyContinue

Function Get-ServerFile ($defaultDirectory)
{
    [system.reflection.assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $defaultDirectory
    $openFileDialog.Filter = "TXT (*.txt) | *.txt"
    $openFileDialog.ShowDialog() | Out-Null
    $openFileDialog.FileName
}

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    | Starting Disk Space Scan |
    |                          |
    |__________________________|
    
    "
)

$inputFile = Get-ServerFile "C:\temp\diskspacereports"

try {
    $File = Get-Content $inputFile
    Write-Host (
        "
         __________________________
        |                          |
        |                          |
        |  Retrieving contents of  |
        |     servers.txt          |
        |                          |
        |__________________________|
        "
    )
}
catch {
    "Error occured while trying to read from text file"
}

$File = Get-Content $inputFile

$servers = Get-Content $inputFile
$serverCount = $servers.count

Write-Host "Found " $ServerCount "server(s) in text file"

Start-Sleep -Seconds 2

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    |    Getting Credentials   |
    |                          |
    |__________________________|
    
    "
)

$RunAccount = Get-Credential -Message "Enter admin account username and password"

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    |    Running Disk Scan     |
    |                          |
    |__________________________|
    
    "
)

$LogDate = get-date -f yyyy_MM_dd_hhmm

$DiskReport = ForEach ($Servernames in ($File))


{Get-WmiObject win32_logicaldisk -Credential $RunAccount `
-ComputerName $Servernames -Filter "Drivetype=3" `
-ErrorAction SilentlyContinue }

foreach ($Servernames in $servers) {
    if (Test-NetConnection -Computer $Servernames -Port 3389 -InformationLevel Quiet -WarningAction SilentlyContinue) {
        $_
    }
    else {
        Write-Error "Can't hit $Servernames. Skipping..."
    }
}

#create reports
$DiskReport | 
Select-Object @{Label = "Server Name";Expression = {$_.SystemName}},
@{Label = "Drive Letter";Expression = {$_.DeviceID}},
@{Label = "Total Capacity (GB)";Expression = {"{0:N1}" -f( $_.Size / 1gb)}},
@{Label = "Free Space (GB)";Expression = {"{0:N1}" -f( $_.Freespace / 1gb ) }},
@{Label = 'Free Space (%)'; Expression = {"{0:P0}" -f ($_.freespace/$_.size)}} |

#Export report to CSV file (Disk Report)
Export-Csv -path "C:\temp\diskspacereports\DiskReport\DiskReport_$logDate.csv" -NoTypeInformation

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    |   Opening CSV file and   |
    |    exiting script        |
    |                          |
    |__________________________|
    
    "
)

#Open csv file
Invoke-Item C:\Temp\DiskSpaceReports\DiskReport\DiskReport_$logDate.csv
