#Powershell script template for automated backups from source to destination folder
#FD 2023-10-03 

#-----------------------SET SOURCE AND DESTINATION FOLDERS HERE-------------------------------------------

$src="C:\Users\fdoskas\OneDrive - University of Edinburgh\Tools\Batch files"
$dest="C:\Users\fdoskas\OneDrive - University of Edinburgh\Tools\bu"

#do not modify below this line
#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------

$logFile="pw_bu_log.txt"

Get-ExecutionPolicy -List | Out-File -FilePath $logFile

#Invoke-Command -ComputerName trend963.is.ed.ac.uk -ScriptBlock { Get-ExecutionPolicy }

Read-Host -Prompt "Press any key to continue"