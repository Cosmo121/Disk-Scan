

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

Start-Sleep -Seconds 4
if ( -not (Test-Path 'C:\temp\diskspacereports\Servers.txt' -PathType Leaf))
{
    # the servers.txt file wasn't found, write error and exit
    "No server text file found. Please create a Servers.txt at c:\temp\diskspacereports\ or edit script to look at desired path."
    exit
}
    else {
        # servers.txt exists, try to grab it
        try {
            $File = Get-Content -Path C:\temp\diskspacereports\servers.txt
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
            "Error occured grabbing Servers from text file :("
        }
    }

function Get-Servers {
    $Servers = Get-Content C:\temp\diskspacereports\servers.txt
    $ServerCount = $Servers.count
    Write-Host "Found " $ServerCount "server(s) in text file"
    Start-Sleep -Seconds 4  
}
Get-Servers

$RunAccount = Get-Credential -Message "Enter admin account username and password"
$LogDate = get-date -f yyyy_MM_dd_hhmm
$DiskReport = ForEach ($Servernames in ($File))


{Get-WmiObject win32_logicaldisk -Credential $RunAccount `
-ComputerName $Servernames -Filter "Drivetype=3" `
-ErrorAction SilentlyContinue }

#create reports
$DiskReport | 
Select-Object @{Label = "Server Name";Expression = {$_.SystemName}},
@{Label = "Drive Letter";Expression = {$_.DeviceID}},
@{Label = "Total Capacity (MB)";Expression = {"{0:N1}" -f( $_.Size / 1mb)}},
@{Label = "Free Space (MB)";Expression = {"{0:N1}" -f( $_.Freespace / 1mb ) }},
@{Label = 'Free Space (%)'; Expression = {"{0:P0}" -f ($_.freespace/$_.size)}} |

#Export report to CSV file (Disk Report)
Export-Csv -path "C:\temp\diskspacereports\DiskReport\DiskReport_$logDate.csv" -NoTypeInformation

#Open csv file
Invoke-Item C:\Temp\DiskSpaceReports\DiskReport\DiskReport_$logDate.csv
