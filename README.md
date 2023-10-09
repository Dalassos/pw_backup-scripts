**************
FD - 2023-10

This is a powershell collection of scripts to back up files from source to destination.
Source and destination folders need to be updated in code for specific needs.
Script can be set up as a task by Windows scheduler to have recurring backups.
log_init is only used to create specific log files
bu_template does the actual backup
clean-up archives and keeps only X nb of copies of files
create_files is a text file creator used for test purpose only
This includes cleaning up all folder types and can backup daily, monthly, weekly, annually, number of files to keep in archive and source folders, as well as number to back up can be configured in each script.
bu_task is the main script that calls the others. It receive a switch parameter (D-daily, W=weekly, M=monthly, Y=yearly) to create different backup folders and different triggers. This can be passed on form the task scheduler.

**************# powershell-tools
