dotnet test ..\Pamola.Viewer.sln /p:CollectCoverage=true /p:CoverletOutputFormat=lcov /p:CoverletOutput=../.coverage/lcov /p:Include=[Pamola.Viewer]*  /p:Threshold=90 
pause  
