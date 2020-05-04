if(![bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
	Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit  -ExecutionPolicy Bypass -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
	exit
}

if(test-connection chocolatey.org -Count 1 -Quiet) {
	try {
		write-host
		write-host istalling chocolatey... -ForegroundColor Yellow -BackgroundColor DarkGreen
		Set-ExecutionPolicy Unrestricted -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	} catch {
		Write-Host error install choco -ForegroundColor Red
	} finally {
		write-host chocolatey successufly installed -ForegroundColor Yellow -BackgroundColor DarkGreen
	}



	try {
		write-host
		write-host setting up  webRequestTimeoutSeconds value 200... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco config set --name webRequestTimeoutSeconds --value 200
	} catch {
		Write-Host error set parameter (webRequestTimeoutSeconds) -ForegroundColor Red
	} finally {
		Write-Host parameter --webRequestTimeoutSeconds successfully rewrited -ForegroundColor Green
	}



	try {
		write-host
		write-host istalling mingw... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco install mingw
	} catch {
		Write-Host error install mingw -ForegroundColor Red
	} finally {
		Write-Host mingw successfully installed -ForegroundColor Green
	}



	try {
		write-host
		write-host istalling cygwin... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco install cygwin
	} catch {
		Write-Host error install cygwin -ForegroundColor Red
	} finally {
		Write-Host cygwin successfully installed -ForegroundColor Green
	}



	try {
		write-host
		write-host istalling wsl... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco install wsl
	} catch {
		Write-Host error wsl -ForegroundColor Red
	} finally {
		Write-Host wsl successfully installed -ForegroundColor Green
	}



	try {
		write-host
		write-host istalling microsoft-build-tools... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco install microsoft-build-tools
	} catch {
		Write-Host error install microsoft-build-tools -ForegroundColor Red
	} finally {
		Write-Host microsoft-build-tools successfully installed -ForegroundColor Green
	}



	try {
		write-host
		write-host upgrading mingw... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco upgrade mingw
	} catch {
		Write-Host error upgrade mingw -ForegroundColor Red
	} finally {
		Write-Host mingw successfully upgraded -ForegroundColor Green
	}



	try {
		write-host
		write-host upgrading cygwin... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco upgrade cygwin
	} catch {
		Write-Host error upgrade cygwin -ForegroundColor Red
	} finally {
		Write-Host mingw successfully upgraded -ForegroundColor Green
	}



	try {
		write-host
		write-host upgrading microsoft-build-tools... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco upgrade microsoft-build-tools
	} catch {
		Write-Host error upgrade microsoft-build-tools -ForegroundColor Red
	} finally {
		Write-Host mingw successfully upgraded -ForegroundColor Green
	}



	try {
		write-host
		write-host upgrading wsl... -ForegroundColor Yellow -BackgroundColor DarkGreen
		choco upgrade wsl
	} catch {
		Write-Host error wsl -ForegroundColor Red
	} finally {
		Write-Host wsl successfully upgraded -ForegroundColor Green
	}
} else {
	Write-Host error establishing internet connection -ForegroundColor Red
}


Read-Host -Prompt "Press Enter to exit"