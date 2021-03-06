@echo off

"tools\nuget\nuget.exe" "install" "FAKE.Core" "-OutputDirectory" "tools" "-ExcludeVersion" "-version" "2.2.0"

:Build
cls

SET TARGET="Default"

IF NOT [%1]==[] (set TARGET="%1")

SET BUILDMODE="Release"
IF NOT [%2]==[] (set BUILDMODE="%2")

"tools\FAKE.Core\tools\Fake.exe" "build.fsx" "target=%TARGET%" "buildMode=%BUILDMODE%"

rem Bail if we're running a TeamCity build.
if defined TEAMCITY_PROJECT_NAME goto Quit

rem Bail if we're running a MyGet build.
if /i "%BuildRunner%"=="MyGet" goto Quit

:Quit
exit /b %errorlevel%
