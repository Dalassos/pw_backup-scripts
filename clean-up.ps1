#files creator for test purposes
#FD 2023-10-05 

#---------------------------------SET SOURCE FOLDERS HERE AND # OF FILES TO KEEP HERE-------------------------------------------
$src="files"
$nb=30

#do not modify below this line
#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------

$src2=$src+"\*.txt"

$logFile="clean-up_log.txt"
"New cleanup job" | Out-File -FilePath $logFile -Append
Get-Date | Out-File -FilePath $logFile -Append


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

Read-Host -Prompt "Press any key to continue"