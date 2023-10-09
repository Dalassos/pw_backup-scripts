#Powershell script template for automated backups from source to destination folder
#FD 2023-10-03 
#
#src and dest can be defined in the script by assigning it in the first part or be called dynamically by passing them as parameters
#nb can also be called dynamically or set in first part and defines the maximum amount of files, sorted by most recent to copy

#-----------------------SET SOURCE AND DESTINATION FOLDERS HERE-------------------------------------------

param([string]$src="files",
[string]$dest="bu",
[int]$nb=10000)

#do not modify below this line
#-------------------------------- DO NOT MODIFY BELOW THIS LINE ------------------------------------------------
function create-item ($path){
	try{
 		$testpath=Test-Path -Path $path
		If ($testpath){
			"destination "+$path+" exists"
		}
		Else{
			If($path.split("\")[-1] -like "*.*"){
				New-Item -Path $path -ItemType File
			}
			Else{
				New-Item -Path $path -ItemType Directory
			}
		}
  	}
   	catch{
	"access error : "+$PSItem | Out-File -FilePath $logFile -Append
	}
}

try {
	$logFile="back-up_log.txt"
	.\log_init.ps1 $logFile "New back-up job"
}
catch{
	"log init error : "+$PSItem | Out-File -FilePath $logFile -Append
}

try {
	create-item -path $dest | Out-File -FilePath $logFile -Append
	Get-ChildItem -Path $src -File | Sort-Object -Descending -Property LastWriteTime | Select-Object -First $nb | Copy-Item -Destination $dest -Recurse -PassThru | Out-File -FilePath $logFile -Append
}
catch[System.IO.IOException]{
	"access error : "+$PSItem | Out-File -FilePath $logFile -Append
}
catch{
	"back-up error : "+$PSItem | Out-File -FilePath $logFile -Append
}
