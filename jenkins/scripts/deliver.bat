@echo off
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository ^(and the "maven-repository" Docker data
echo volume^).
echo.

echo The following command extracts the value of the ^<name/^> element
echo within ^<project/^> of your Java/Maven project's "pom.xml" file.
echo.

for /f "delims=" %%i in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.name') do set NAME=%%i
echo Extracted NAME: %NAME%
echo.

echo The following command behaves similarly to the previous one but
echo extracts the value of the ^<version/^> element within ^<project/^> instead.
echo.

for /f "delims=" %%i in ('mvn -q -DforceStdout help:evaluate -Dexpression=project.version') do set VERSION=%%i
echo Extracted VERSION: %VERSION%
echo.

echo Running: mvn jar:jar install:install help:evaluate -Dexpression=project.name
mvn jar:jar install:install help:evaluate -Dexpression=project.name
echo.

echo The following command runs and outputs the execution of your Java
echo application ^(which Jenkins built using Maven^) to the Jenkins UI.
echo.

echo Running: java -jar target\%NAME%-%VERSION%.jar
java -jar target\%NAME%-%VERSION%.jar