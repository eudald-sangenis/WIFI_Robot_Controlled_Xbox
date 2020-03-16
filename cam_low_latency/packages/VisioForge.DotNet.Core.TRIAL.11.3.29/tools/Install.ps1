Import-Module $PSScriptRoot\InstallRedist.psm1

Add-Type -AssemblyName System.Windows.Forms

Write-Output "Press ENTER to continue" 

#[System.Windows.Forms.MessageBox]::Show('x2')

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID);

# Get the security principal for the administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator;

# Check to see if we are currently running as an administrator
if ($myWindowsPrincipal.IsInRole($adminRole)) {
    # We are running as an administrator, so change the title and background colour to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)";
    $Host.UI.RawUI.BackgroundColor = "DarkBlue";
    # Clear-Host;
}
else {
    # We are not running as an administrator, so relaunch as administrator

    # Create a new process object that starts PowerShell
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";

    # Specify the current script path and name as a parameter with added scope and support for scripts with spaces in it's path
    $newProcess.Arguments = "-ExecutionPolicy ByPass -noexit & '" + $script:MyInvocation.MyCommand.Path + "'"

    # Indicate that the process should be elevated
    $newProcess.Verb = "runas";

    # Start the new process
    [System.Diagnostics.Process]::Start($newProcess);

    # Exit from the current, unelevated, process
    Exit;
}

# Run your code that needs to be elevated here...
[System.Windows.Forms.MessageBox]::Show('VisioForge .Net redists installation started (Install.ps1)')

#[System.Windows.Forms.MessageBox]::Show('E1')

$toolsPath = split-path -parent $MyInvocation.MyCommand.Definition
#[System.Windows.Forms.MessageBox]::Show($toolsPath)

$installPath = split-path -parent $toolsPath
#[System.Windows.Forms.MessageBox]::Show($installPath)

Write-Output "toolsPath: $toolsPath"
Write-Output "installPath: $installPath"

$ErrorLog = $toolsPath + "\InstallLog.txt"

Write-Output ""
Write-Output ""
Write-Output ""
Write-Output ""
Write-Output ""
Write-Output ""
Write-Output ""

Write-Output "Press ENTER to continue" 

#[Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $pathx, [EnvironmentVariableTarget]::Machine)

Set-ConsoleMode -DisableQuickEdit

VisioForge_InstallRedist

[System.Windows.Forms.MessageBox]::Show('Please restart Visual Studio to finish!')

Read-Host -Prompt "Press Enter to exit"