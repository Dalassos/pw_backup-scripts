#files creator for test purposes
#FD 2023-10-03 

#-----------------------DESTINATION FOLDERS HERE-------------------------------------------
$dest="files"

#do not modify below this line
#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------

$logFile="file_creator_log.txt"

New-Item -Path $dest -ItemType Directory | Out-File -FilePath $logFile
for ($i = 1; $i -le 50; $i++) {
	$file = $dest+"\file"+$i+".txt"
	New-Item -Path $file -ItemType File | Out-File -FilePath $logFile -Append
	$i | Out-File -FilePath $logFile -Append
	"some text"+$i| Out-File -FilePath $file
}

#Invoke-Command -ComputerName trend963.is.ed.ac.uk -ScriptBlock { Get-ExecutionPolicy }

Read-Host -Prompt "Press any key to continue"