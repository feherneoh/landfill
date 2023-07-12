@echo off
set gitcmdpath=%~1
set gitcmdparam=%gitcmdpath:'=%
"c:\Program Files\Git\mingw64\bin\git-upload-pack.exe" %gitcmdparam%
