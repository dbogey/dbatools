﻿function Stop-DbaXESmartTarget {
 <#
    .SYNOPSIS
    Stops an XESmartTarget PowerShell Job. Useful if you want to reuse the same target templates.
    
    .DESCRIPTION
    Stops an XESmartTarget PowerShell Job. Useful if you want to reuse the same target templates.
    
    .PARAMETER InputObject
    The XESmartTarget job object
    
    .PARAMETER WhatIf
    Shows what would happen if the command were to run. No actions are actually performed.

    .PARAMETER Confirm
    Prompts you for confirmation before executing any changing operations within the command.
        
    .PARAMETER EnableException
    By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
    This avoids overwhelming you with "sea of red" exceptions, but is inconvenient because it basically disables advanced scripting.
    Using this switch turns this "nice by default" feature off and enables you to catch exceptions with your own try/catch.

    .NOTES
    Website: https://dbatools.io
    Copyright: (C) Chrissy LeMaire, clemaire@gmail.com
    License: GNU GPL v3 https://opensource.org/licenses/GPL-3.0
    SmartTarget: by Gianluca Sartori (@spaghettidba)

    .LINK
    https://dbatools.io/Stop-DbaXESmartTarget
    https://github.com/spaghettidba/XESmartTarget/wiki

    .EXAMPLE
    Get-DbaXESmartTarget | Stop-DbaXESmartTarget
    
    Stops all XESmartTarget jobs
    
    .EXAMPLE
    Get-DbaXESmartTarget | Where-Object Id -eq 2 | Stop-DbaXESmartTarget
    
    Stops a specific XESmartTarget job

#>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [parameter(Mandatory, ValueFromPipeline)]
        [object[]]$InputObject,
        [switch]$EnableException
    )
    process {
        if ($Pscmdlet.ShouldProcess("localhost", "Stopping job $id")) {
            try {
                $id = $InputObject.Id
                Write-Message -Level Output -Message "Stopping job $id, this may take a couple minutes"
                Get-Job -ID $InputObject.Id | Stop-Job -Force
                Write-Message -Level Output -Message "Successfully Stopped $id. If you need to remove the job for good, use Remove-DbaXESmartTarget."
            }
            catch {
                Stop-Function -Message "Failure" -ErrorRecord $_
            }
        }
    }
}
