#Powershell script for automated backups from source to destination folder
#FD 2023-10-06
#
#src and dest can be defined in the script by assigning it in the first part

#-----------------------SET SOURCE AND DESTINATION FOLDERS HERE-------------------------------------------
param(
[string]$mode=" ",
[string]$src="C:\Program Files (x86)\Trend Control Systems\963\db_backup",
[string]$dest="\\ed.ac.uk\dst\shared\CSG\EST\EB18\Ops\Works\Controls\Trend 963 backup",
[int]$nb=12
)
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
	default{ 
		$dest=$dest+"\default"
		$mode+" - no mode selected" | Out-File -FilePath $logFile -Append
		}
}

#back-up job
.\bu_template.ps1 -src $src -dest $dest -nb 1


#clean bu folder
.\clean-up.ps1 -src $dest -nb $nb