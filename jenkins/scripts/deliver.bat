@echo off
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data volume).

echo Running: mvn jar:jar install:install help:evaluate -Dexpression=project.name
mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo The following command extracts the value of the <name/> element within <project/> of your pom.xml file.
FOR /F "delims=" %%i IN ('mvn -q -DforceStdout help:evaluate -Dexpression=project.name') DO SET NAME=%%i

echo The following command extracts the value of the <version/> element within <project/> of your pom.xml file.
FOR /F "delims=" %%i IN ('mvn -q -DforceStdout help:evaluate -Dexpression=project.version') DO SET VERSION=%%i

echo Running your Java application...
java -jar target\%NAME%-%VERSION%.jar