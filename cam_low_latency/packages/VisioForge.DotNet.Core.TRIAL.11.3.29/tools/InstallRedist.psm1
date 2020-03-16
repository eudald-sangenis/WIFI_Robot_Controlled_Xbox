Add-Type -AssemblyName System.Windows.Forms

$QuickEditCodeSnippet=@" 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;


public static class DisableConsoleQuickEdit
{

const uint ENABLE_QUICK_EDIT = 0x0040;

// STD_INPUT_HANDLE (DWORD): -10 is the standard input device.
const int STD_INPUT_HANDLE = -10;

[DllImport("kernel32.dll", SetLastError = true)]
static extern IntPtr GetStdHandle(int nStdHandle);

[DllImport("kernel32.dll")]
static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);

[DllImport("kernel32.dll")]
static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);

public static bool SetQuickEdit(bool SetEnabled)
{

    IntPtr consoleHandle = GetStdHandle(STD_INPUT_HANDLE);

    // get current console mode
    uint consoleMode;
    if (!GetConsoleMode(consoleHandle, out consoleMode))
    {
        // ERROR: Unable to get console mode.
        return false;
    }

    // Clear the quick edit bit in the mode flags
    if (SetEnabled)
    {
        consoleMode &= ~ENABLE_QUICK_EDIT;
    }
    else
    {
        consoleMode |= ENABLE_QUICK_EDIT;
    }

    // set the new mode
    if (!SetConsoleMode(consoleHandle, consoleMode))
    {
        // ERROR: Unable to set console mode
        return false;
    }

    return true;
}
}

"@

$QuickEditMode=add-type -TypeDefinition $QuickEditCodeSnippet -Language CSharp

function Set-ConsoleMode() 
{
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage="This switch will disable Console QuickEdit option")]
    [switch]$DisableQuickEdit=$false
)
    if([DisableConsoleQuickEdit]::SetQuickEdit($DisableQuickEdit))
    {
        Write-Output "QuickEdit settings has been updated."
    }
    else
    {
        Write-Output "Something went wrong."
    }
}

Function Test-RegistryValue {
    param(
        [Alias("PSPath")]
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Path
        ,
        [Parameter(Position = 1, Mandatory = $true)]
        [String]$Name
        ,
        [Switch]$PassThru
    ) 

    process {
        if (Test-Path $Path) {
            $Key = Get-Item -LiteralPath $Path
            if ($Key.GetValue($Name, $null) -ne $null) {
                if ($PassThru) {
                    Get-ItemProperty $Path $Name
                } else {
                    $true
                }
            } else {
                $false
            }
        } else {
            $false
        }
    }
}


function VisioForge_InstallRedist {
    $toolsPath = split-path -parent $PSScriptRoot
    $ErrorLog = $toolsPath + "\InstallLog.txt"
    
    $RedistState = Test-RegistryValue HKLM:\Software\VisioForge NuGetRedist 
    if ($RedistState -eq $true) {
        Exit
    }

    Write-Output "Press ENTER to continue" 

    New-Item -Path "HKLM:\SOFTWARE\" -Name VisioForge
    New-ItemProperty -Path "HKLM:\Software\VisioForge\" -Name "NuGetRedist" -Value "1"  -PropertyType "DWord"

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_base_x86.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_base_x86.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null  
        Write-Output "Press ENTER to continue"  
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 


    Try { 
        $CMD = $toolsPath + '\redist_dotnet_base_x64.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_base_x64.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_lav_x64.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_lav_x64.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_lav_x86.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_lav_x86.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_mp4_x64.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_mp4_x64.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_mp4_x86.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_mp4_x86.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_webm_x86.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_webm_x86.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_xiph_x64.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_xiph_x64.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 

    Try { 
        $CMD = $toolsPath + '\redist_dotnet_xiph_x86.exe' 
        Invoke-WebRequest http://files.visioforge.com/redists_net/redist_dotnet_xiph_x86.exe -OutFile $CMD
        Write-Output $CMD
        & $CMD | Out-Null
        Write-Output "Press ENTER to continue" 
    }
    Catch {
        " $_" | Add-Content $ErrorLog
    } 
}


Export-ModuleMember -Function VisioForge_InstallRedist
Export-ModuleMember -Function Set-ConsoleMode 