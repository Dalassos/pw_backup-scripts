#Archive cleaner script
#FD 2023-10-05 
#
#This will scan the folder defined in $src, sort it by date and keep only the $nb most recent ones while deleting the rest.
#src and nb can be defined in the script by assigning it in the first part or be called dynamically by passing them as parameters

#---------------------------SET DEFAULT SOURCE FOLDERS HERE AND # OF FILES TO KEEP HERE IF NOT CALLED DYNAMICALLY------------------------------------------------

param([string]$src="files", [int]$nb=10)

#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------

$logFile="clean-up_log.txt"
.\log_init.ps1 $logFile "New cleanup job"

$src2=$src+"\*.txt"


$files=Get-ChildItem -Path $src2 -File | Sort-Object -Descending -Property LastWriteTime
"Number of files" | Out-File -FilePath $logFile -Append
$files.count | Out-File -FilePath $logFile -Append
"Files in system" | Out-File -FilePath $logFile -Append
$files | Out-File -FilePath $logFile -Append

for ($i=$nb; $i-lt$files.count; $i++) {
	$delItem=$files[$i]
	"Deleted file : "+$delItem | Out-File -FilePath $logFile -Append
	Remove-Item -Path $delItem
}

if ($files.count-le$nb) {
	"Back-up not full, nothing to clean"| Out-File -FilePath $logFile -Append
}