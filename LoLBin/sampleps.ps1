write-host "Howdy!!!"
$FILE_TO_WRITE = "simple_output.txt"
$DATA_CONTENT = "This is a simple text document created by the PowerShell script."

# Use Set-Content to write the string to the specified file.
# If the file exists, it is overwritten. If it does not exist, it is created.
Set-Content -Path $FILE_TO_WRITE -Value $DATA_CONTENT

Write-Host "File created successfully: $FILE_TO_WRITE"
Write-Host "Content: $DATA_CONTENT"
