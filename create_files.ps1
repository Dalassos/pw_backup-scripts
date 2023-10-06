#files creator for test purposes
#FD 2023-10-03 
#
#Creates $nb files in $dest for test purposes, one every $time seconds. Files will be named file$nb.txt and contain only "some text $nb".
#dest, nb and time can be defined in the script by assigning it in the first part or be called dynamically by passing them as parameters

#----------------------------------SET DESTINATION FOLDER HERE-------------------------------------------

param([string]$dest="files", [int]$nb=10, [int]$time=5)

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

$logFile="file_creator_log.txt"
.\log_init.ps1 $logFile "New file creator job"

create-item -path $dest | Out-File -FilePath $logFile -Append

for ($i=1; $i-le$nb; $i++) {
	$tstamp=Get-Date -Format FileDateTimeUniversal
	$file = $dest+"\file"+$i+$tstamp+".txt"
	"file to create :"+$file | Out-File -FilePath $logFile -Append
	create-item -path $file | Out-File -FilePath $logFile -Append
	"iteration"+$i | Out-File -FilePath $logFile -Append
	"some text : "+$i | Out-File -FilePath $file
	Wait-Event -Timeout $time
}
