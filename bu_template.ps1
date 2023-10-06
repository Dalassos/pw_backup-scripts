#Powershell script template for automated backups from source to destination folder
#FD 2023-10-03 
#
#src and dest can be defined in the script by assigning it in the first part or be called dynamically by passing them as parameters

#-----------------------SET SOURCE AND DESTINATION FOLDERS HERE-------------------------------------------

param([string]$src="files", [string]$dest="bu")

#do not modify below this line
#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------
function create-item ($path){
	If (Test-Path -Path $path){
		"destination "+$path+" exists"
	}
	Else{
		If($path -like "*.txt"){
			New-Item -Path $path -ItemType File
		}
		Else{
			New-Item -Path $path -ItemType Directory
		}
	}
}

try {
	$logFile="back-up_log.txt"
	.\log_init.ps1 $logFile "New back-up job"
}
catch{
	"log init error"
}

try {
	create-item -path $dest | Out-File -FilePath $logFile -Append
	Get-ChildItem -Path $src -File | Sort-Object -Descending -Property LastWriteTime| Copy-Item -Destination $dest -Recurse -PassThru | Out-File -FilePath $logFile -Append
}
catch{
	"back-up error" | Out-File -FilePath $logFile -Append
}
