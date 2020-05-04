if(![bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
	Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit  -ExecutionPolicy Bypass -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
	exit
}
For ($i=0; $i -le 10; $i++) {
    if(test-connection chocolatey.org -Count 1 -Quiet) {
    	$installErrors = @()
    	$upgradeErrors = @()
    	$installedList = @()
    	$upgradedList = @()

# install chocolatey
    	try {
    		write-host
    		write-host istalling chocolatey... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		Set-ExecutionPolicy Unrestricted -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    	} catch {
    		Write-Host error install choco -ForegroundColor Red
    		$installErrors += 'chocolatey'
    	} finally {
    		write-host chocolatey successufly installed -ForegroundColor Yellow -BackgroundColor DarkGreen
    		$installedList += 'chocolatey'
    	}


# set parameter webRequestTimeoutSeconds to 200
    	try {
    		write-host
    		write-host setting up  webRequestTimeoutSeconds value 200... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco config set --name webRequestTimeoutSeconds --value 200
    	} catch {
    		Write-Host error set parameter (webRequestTimeoutSeconds) -ForegroundColor Red
    	} finally {
    		Write-Host parameter --webRequestTimeoutSeconds successfully rewrited -ForegroundColor Green
    	}


# install mingw
    	try {
    		write-host
    		write-host istalling mingw... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco install mingw
    	} catch {
    		Write-Host error install mingw -ForegroundColor Red
    		$installErrors += 'mingw'
    	} finally {
    		Write-Host mingw successfully installed -ForegroundColor Green
    		$installedList += 'mingw'
    	}


# install cygwin
    	try {
    		write-host
    		write-host istalling cygwin... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco install cygwin
    	} catch {
    		Write-Host error install cygwin -ForegroundColor Red
    		$installErrors += 'cygwin'
    	} finally {
    		Write-Host cygwin successfully installed -ForegroundColor Green
    		$installedList += 'cygwin'
    	}


# install wsl
    	try {
    		write-host
    		write-host istalling wsl... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco install wsl
    	} catch {
    		Write-Host error wsl -ForegroundColor Red
    		$installErrors += 'wsl'
    	} finally {
    		Write-Host wsl successfully installed -ForegroundColor Green
    		$installedList += 'wsl'
    	}


# install microsoft-build-tools
    	try {
    		write-host
    		write-host istalling microsoft-build-tools... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco install microsoft-build-tools
    	} catch {
    		Write-Host error install microsoft-build-tools -ForegroundColor Red
    		$installErrors += 'microsoft-build-tools'
    	} finally {
    		Write-Host microsoft-build-tools successfully installed -ForegroundColor Green
    		$installedList += 'microsoft-build-tools'
    	}


# upgrade mingw
    	try {
    		write-host
    		write-host upgrading mingw... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco upgrade mingw
    	} catch {
    		Write-Host error upgrade mingw -ForegroundColor Red
    		$upgradeErrors += 'mingw'
    	} finally {
    		Write-Host mingw successfully upgraded -ForegroundColor Green
    		$upgradedList += 'mingw'
    	}


# upgrade cygwin
    	try {
    		write-host
    		write-host upgrading cygwin... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco upgrade cygwin
    	} catch {
    		Write-Host error upgrade cygwin -ForegroundColor Red
    		$upgradeErrors += 'cygwin'
    	} finally {
    		Write-Host mingw successfully upgraded -ForegroundColor Green
    		$upgradedList += 'cygwin'
    	}


# upgrade microsoft-build-tools
    	try {
    		write-host
    		write-host upgrading microsoft-build-tools... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco upgrade microsoft-build-tools
    	} catch {
    		Write-Host error upgrade microsoft-build-tools -ForegroundColor Red
    		$upgradeErrors += 'microsoft-build-tools'
    	} finally {
    		Write-Host mingw successfully upgraded -ForegroundColor Green
    		$upgradedList += 'microsoft-build-tools'
    	}


# upgrade wsl
    	try {
    		write-host
    		write-host upgrading wsl... -ForegroundColor Yellow -BackgroundColor DarkGreen
    		choco upgrade wsl
    	} catch {
    		Write-Host error wsl -ForegroundColor Red
    		$upgradeErrors += 'wsl'
    	} finally {
    		Write-Host wsl successfully upgraded -ForegroundColor Green
    		$upgradedList += 'wsl'
    	}
    	Write-Host install errors: $installErrors.Count -ForegroundColor Red
    	Write-Host install errors: $installErrors -ForegroundColor Red
    	Write-Host
    	Write-Host upgrade errors: $upgradeErrors.Count -ForegroundColor Red
    	Write-Host upgrade errors: $upgradeErrors -ForegroundColor Red
    	Write-Host
    	$totalInstallCount = 5-$installErrors.Count
    	$upgradeCount = 5-$upgradeErrors.Count
    	Write-Host total installed: $totalInstallCount -ForegroundColor Green
    	Write-Host total upgraded: $upgradeCount -ForegroundColor Green
    	Write-Host
    	if(($installedList.Count -ge 0) -and ($upgradedList.Count -ge 0)) {
    		Write-Host total installed: $installedList -ForegroundColor Green
    		Write-Host total upgraded: $upgradedList -ForegroundColor Green
    	}
    	Break
    } else {
    	Write-Host error establishing internet connection retrying... -ForegroundColor Red
    	Write-Host step:$i of 10 -ForegroundColor Red
    	Start-Sleep -s 3
    }
}

Read-Host -Prompt "Press Enter to exit"