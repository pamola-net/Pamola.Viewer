rem =========================================
rem Setting Project Variables
rem =========================================

set ProjectName=%1
IF "%ProjectName%"=="" (set /p ProjectName="Project Name:   ")
set %ProjectName=%ProjectName

rem =========================================
rem Creating Source Project
rem =========================================

dotnet new wpf -n Source
echo ^<Project Sdk^="Microsoft.NET.Sdk"^> >Source\Source.csproj
echo ^<PropertyGroup^> >>Source\Source.csproj
echo ^<TargetFramework^>netcoreapp3.0^</TargetFramework^> >>Source\Source.csproj
echo ^<RootNamespace^>%ProjectName%^</RootNamespace^> >>Source\Source.csproj
echo ^<Authors^>Jean L Colombo, Johni Michels^</Authors^> >>Source\Source.csproj
echo ^<Version^>0.1.0^</Version^> >>Source\Source.csproj	
echo ^</PropertyGroup^> >>Source\Source.csproj
echo ^<PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|AnyCPU'"^> >>Source\Source.csproj
echo ^<OutputPath^>./../bin^</OutputPath^> >>Source\Source.csproj
echo ^</PropertyGroup^> >>Source\Source.csproj
echo ^</Project^> >>Source\Source.csproj
ren Source\Source.csproj %ProjectName%.csproj

rem =========================================
rem Creating Test Project
rem =========================================

dotnet new xunit -n Tests
echo ^<Project Sdk^="Microsoft.NET.Sdk"^> >Tests\Tests.csproj 
echo ^<PropertyGroup^> >>Tests\Tests.csproj 
echo ^<TargetFramework^>netcoreapp3.0^</TargetFramework^> >>Tests\Tests.csproj 
echo ^<IsPackable^>false^</IsPackable^> >>Tests\Tests.csproj 
echo ^<RootNamespace^>%ProjectName%.UT^</RootNamespace^> >>Tests\Tests.csproj 
echo ^</PropertyGroup^> >>Tests\Tests.csproj 
echo ^<PropertyGroup Condition^="'$(Configuration)|$(Platform)'=='Debug|AnyCPU'"^> >>Tests\Tests.csproj 
echo ^<OutputPath^>./../bin^</OutputPath^> >>Tests\Tests.csproj 
echo ^</PropertyGroup^> >>Tests\Tests.csproj 
echo ^<ItemGroup^> >>Tests\Tests.csproj 
echo ^<PackageReference Include^="coverlet.msbuild" Version^="2.6.0"^> >>Tests\Tests.csproj 
echo ^<PrivateAssets^>all^</PrivateAssets^> >>Tests\Tests.csproj 
echo ^<IncludeAssets^>runtime; build; native; contentfiles; analyzers^</IncludeAssets^> >>Tests\Tests.csproj 
echo ^</PackageReference^> >>Tests\Tests.csproj 
echo ^<PackageReference Include^="Microsoft.NET.Test.Sdk" Version^="15.9.0" /^> >>Tests\Tests.csproj 
echo ^<PackageReference Include^="xunit" Version^="2.4.0" /^> >>Tests\Tests.csproj 
echo ^<PackageReference Include^="xunit.runner.visualstudio" Version^="2.4.0" /^> >>Tests\Tests.csproj 
echo ^</ItemGroup^> >>Tests\Tests.csproj 
echo ^<ItemGroup^> >>Tests\Tests.csproj 
echo ^<ProjectReference Include^="..\Source\%ProjectName%.csproj" /^> >>Tests\Tests.csproj 
echo ^</ItemGroup^> >>Tests\Tests.csproj 
echo ^</Project^> >>Tests\Tests.csproj 
ren Tests\Tests.csproj %ProjectName%.UT.csproj

rem =========================================
rem Creating CircleCI Yml File
rem =========================================

mkdir .circleci
echo version: 2.1 >.circleci\config.yml 
echo executors: >>.circleci\config.yml 
echo   dotnetcoreexecutor: >>.circleci\config.yml 
echo     docker: >>.circleci\config.yml 
echo       - image: microsoft/dotnet:3.0-disco >>.circleci\config.yml 
echo jobs: >>.circleci\config.yml 
echo   build: >>.circleci\config.yml 
echo     executor: dotnetcoreexecutor >>.circleci\config.yml 
echo     steps: >>.circleci\config.yml 
echo       - checkout >>.circleci\config.yml 
echo       - run: dotnet build Source/%ProjectName%.csproj >>.circleci\config.yml 
echo   test: >>.circleci\config.yml 
echo     executor: dotnetcoreexecutor >>.circleci\config.yml 
echo     steps: >>.circleci\config.yml 
echo       - checkout >>.circleci\config.yml 
echo       - run: dotnet test >>.circleci\config.yml 
echo   code_coverage: >>.circleci\config.yml 
echo     executor: dotnetcoreexecutor >>.circleci\config.yml 
echo     steps: >>.circleci\config.yml 
echo       - checkout >>.circleci\config.yml 
echo       - run: ^> >>.circleci\config.yml 
echo           dotnet test  >>.circleci\config.yml 
echo           %ProjectName%.sln >>.circleci\config.yml 
echo           /p:CollectCoverage^=true  >>.circleci\config.yml 
echo           /p:CoverletOutputFormat^=lcov  >>.circleci\config.yml 
echo           /p:CoverletOutput^=../.coverage/lcov  >>.circleci\config.yml 
echo           /p:Include^=[%ProjectName%]* >>.circleci\config.yml 
echo           /p:Threshold^=90 >>.circleci\config.yml 
echo   deploy: >>.circleci\config.yml 
echo     executor: dotnetcoreexecutor >>.circleci\config.yml 
echo     steps: >>.circleci\config.yml 
echo       - checkout >>.circleci\config.yml 
echo       - run: ^> >>.circleci\config.yml 
echo           dotnet pack >>.circleci\config.yml 
echo           Source/%ProjectName%.csproj >>.circleci\config.yml 
echo           -c Release >>.circleci\config.yml 
echo           --include-source >>.circleci\config.yml 
echo           --include-symbols >>.circleci\config.yml 
echo           -o ../nuget >>.circleci\config.yml 
echo       - run: ^> >>.circleci\config.yml 
echo           dotnet nuget push  >>.circleci\config.yml 
echo           nuget/*.nupkg >>.circleci\config.yml 
echo           -s https://api.nuget.org/v3/index.json >>.circleci\config.yml 
echo           -k ${NUGET_API_KEY}    >>.circleci\config.yml 
echo workflows:   >>.circleci\config.yml 
echo   version: 2.1   >>.circleci\config.yml 
echo   build_test:   >>.circleci\config.yml 
echo     jobs:   >>.circleci\config.yml 
echo       - build   >>.circleci\config.yml 
echo       - test:   >>.circleci\config.yml 
echo           requires:   >>.circleci\config.yml 
echo             - build   >>.circleci\config.yml 
echo       - code_coverage:   >>.circleci\config.yml 
echo           requires:   >>.circleci\config.yml 
echo             - test >>.circleci\config.yml 
echo       - request_approval_for_deploy: >>.circleci\config.yml 
echo           type: approval >>.circleci\config.yml 
echo           requires:  >>.circleci\config.yml 
echo             - code_coverage >>.circleci\config.yml 
echo           filters:   >>.circleci\config.yml 
echo             branches:   >>.circleci\config.yml 
echo               only:   >>.circleci\config.yml 
echo                 - master   >>.circleci\config.yml 
echo       - deploy:   >>.circleci\config.yml 
echo           requires:   >>.circleci\config.yml 
echo             - request_approval_for_deploy   >>.circleci\config.yml 
echo           filters:   >>.circleci\config.yml 
echo             branches:   >>.circleci\config.yml 
echo               only:   >>.circleci\config.yml 
echo                 - master >>.circleci\config.yml 

rem =========================================
rem Creating Solution File
rem =========================================

dotnet new sln -n %ProjectName%
dotnet sln add Source\%ProjectName%.csproj
dotnet sln add Tests\%ProjectName%.UT.csproj

rem =========================================
rem Creating Tasks Folder
rem =========================================

mkdir .tasks
echo dotnet test ..\%ProjectName%.sln /p:CollectCoverage^=true /p:CoverletOutputFormat^=lcov /p:CoverletOutput^=../.coverage/lcov /p:Include^=[%ProjectName%]*  /p:Threshold^=90 >.tasks\code_coverage.bat
echo pause  >>.tasks\code_coverage.bat