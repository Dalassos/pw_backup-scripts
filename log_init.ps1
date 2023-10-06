#log creator
#FD 2023-10-06 
#
#Initialise log from $log_file param, dynamically or by default setup here
#----------------------------------SET LOG FILE HERE-------------------------------------------

param([string]$logFile="test_log.txt", [string]$job="log execution")

#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------

"****************************" | Out-File -FilePath $logFile -Append
$job | Out-File -FilePath $logFile -Append
Get-Date | Out-File -FilePath $logFile -Append