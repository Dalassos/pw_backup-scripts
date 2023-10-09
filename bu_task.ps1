#Powershell script for automated backups from source to destination folder
#FD 2023-10-06
#
#src and dest can be defined in the script by assigning it in the first part

#-----------------------SET SOURCE AND DESTINATION FOLDERS HERE-------------------------------------------
param($mode)

$src="C:\Users\fdoskas\OneDrive - University of Edinburgh\Tools\Powershell files\backup script\files"
$dest="C:\Users\fdoskas\OneDrive - University of Edinburgh\Tools\Powershell files\backup script\bu"
$nb=12

#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------
#log init
$logFile="regular_bu_log.txt"
.\log_init.ps1 $logFile "Full backup job"

#mode selection
switch ($mode){
	D {$dest=$dest+"\daily"
		#clean src folder
		.\clean-up.ps1 -src $src -nb $nb
		}
	W {$dest=$dest+"\weekly"}
	M {$dest=$dest+"\monthly"}
	Y {$dest=$dest+"\yearly"}
	default{ $mode+" - no mode selected" | Out-File -FilePath $logFile -Append}
}

#back-up job
.\bu_template.ps1 -src $src -dest $dest -nb 1


#clean bu folder
.\clean-up.ps1 -src $dest -nb $nb