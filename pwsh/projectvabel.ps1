#!/opt/microsoft/powershell/7/pwsh

function FindJava($JavaVersion, $JavaVariant) {
    switch ([System.Environment]::OSVersion.Platform) {
        "Win32NT" {
            $JavaFiles = "$ENV:PROGRAMFILES\Java\"

            switch ($JavaVersion) {
                {$_ -le 8} {
                    $JreFolder = "jre1.$JavaVersion.*"
                    $JdkFolder = "jdk1.$JavaVersion.*"
                }
                {$_ -ge 9} {
                    $JreFolder = "jre-$JavaVersion.*"
                    $JdkFolder = "jdk-$JavaVersion.*"
                }
                default {
                    Write-Error "Still not dead? A shame."
                    return 0
                }
            }

            if (Test-Path -Path $JavaFiles -PathType Container) {
                $JavaDirs = Get-ChildItem -Path $JavaFiles -Directory
                $JreDirs = @($JavaDirs | Where-Object BaseName -Like $JreFolder) + @($JavaDirs | Where-Object BaseName -Like $JdkFolder)

                if ($JreDirs.length -eq 0) {
                    Write-Error "Could not find Java $JavaVersion."
                    return
                }
                elseif ($JreDirs.length -eq 1) {
                    return "$($JreDirs[0].FullName)\bin\java$JavaVariant.exe"
                }
                else {
                    Write-Host "Found multiple Java $JavaVersion installations. Using $($JreDirs[0].BaseName)"
                    return "$($JreDirs[0].FullName)\bin\java$JavaVariant.exe"
                }
            }
            else {
                Write-Error "I see no Java here."
                return 0
            }
        }
        "Unix" {
            Write-Error "This will be an absolute nightmare."
            return 0
        }
        Default {
            Write-Error "Nice noose. Use it."
            return 0
        }
    }
}
