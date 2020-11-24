
Write-Host (
    "
     ================================
     ================================
     ====Starting Disk Space Scan====
     ================================
     ================================
    "
)


function Get-Servers {
    
    param (
        $TxtFilePath = 'C:\temp\diskspacereports\servers.txt'
    )

    $Servers = Get-Content $TxtFilePath
    $ServerCount = $Servers.count
}


if ( -not (Test-Path $TxtFilePath -PathType Leaf))
{
    # the servers.txt file wasn't found, write error and exit
    "No server text file found. Please create a Servers.txt at c:\temp\diskspacereports\ or edit $TxtFilePath to desired path."
    exit
}
    else {
        # txt file exists, grab it
        $File = Get-Content -Path $TxtFilePath
        Write-Host "Retrieving contents of txt file"
        Start-Sleep -Seconds 4
    }


Start-Sleep -Seconds 4
Get-Servers

$RunAccount = Get-Credential -Message "Enter admin account username and password"
$LogDate = get-date -f yyyy_MM_dd_hhmm

Write-Host "Scanning disks"

$DiskReport = ForEach ($Servernames in ($File))

{Get-WmiObject win32_logicaldisk -Credential $RunAccount `
-ComputerName $Servernames -Filter "Drivetype=3" `
-ErrorAction SilentlyContinue }

Write-Host "Scanning disks complete, creating csv file"

#create reports
$DiskReport | 
Select-Object @{Label = "Server Name";Expression = {$_.SystemName}},
@{Label = "Drive Letter";Expression = {$_.DeviceID}},
@{Label = "Total Capacity (GB)";Expression = {"{0:N1}" -f( $_.Size / 1gb)}},
@{Label = "Free Space (GB)";Expression = {"{0:N1}" -f( $_.Freespace / 1gb ) }},
@{Label = 'Free Space (%)'; Expression = {"{0:P0}" -f ($_.freespace/$_.size)}} |

#Export report to CSV file (Disk Report)
Export-Csv -path "C:\temp\diskspacereports\DiskReport\DiskReport_$logDate.csv" -NoTypeInformation

#Open csv file
Invoke-Item C:\Temp\DiskSpaceReports\DiskReport\DiskReport_$logDate.csv
