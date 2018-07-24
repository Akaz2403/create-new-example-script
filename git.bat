@echo off

set repo_folder=example-repository-%random%%random%-master

echo Copying the template repository folder to temporary folder '%repo_folder%'
xcopy example-repository-template-master %repo_folder% /y /s /i

echo.
echo 1. Initializing a repository for your example in the folder.
cd %repo_folder%
call git init

echo.
echo 2. Now check the config.json file in the %cd% folder:
echo - Set autoGenerateVb to automatically generate a VB version of your example (TRUE - by default)
echo - Set runOnWeb to publish your example on http://codecentral.devexpress.com (FALSE - by default)
echo.
echo Press any key when you finish editing config.json to continue
@pause>nul

echo.
echo 3. Let's add a new branch to your repository.
echo The branch name should be RELEASE.MAJOR.MINOR+ (according to the convension e.g., 17.2.8+)
set /p branch_name=Input the branch name: 
call git checkout -b %branch_name%

echo.
echo 4. Adding files to the repository and making the first commit.
call git add *
echo.
call git commit -m "first commit"

copy nul Readme.md
echo.
echo 5. An empty Readme.md file is created in the %cd% folder.
echo Open it in any text editor and write the example description in the markdown format.
echo You can use a markdown editor to format your text, e.g., https://stackedit.io/app#
echo.
echo Press any key when you finish to continue
@pause>nul
call git add Readme.md
call git commit -m "add readme"

echo.
echo 6. Creating an empty CS folder that will store the example content.
mkdir CS
cd CS
echo Open the %cd% folder and put your example files there.
echo.
echo Press any key when you finish to continue
@pause>nul
call git add *
call git commit -m "add example content"

echo.
echo 7. Open https://github.com/new
echo Fill Repository name (e.g., "aspxgridview-how-to-do-something") and Description (e.g., ".NET, ASP.NET Web Forms, ASPxGridView") and create a repository on the behalf of the DevExpress-Examples user.
echo Input the repository address (e.g., https://github.com/DevExpress-Examples/REPO_NAME.git)
set /p remoteRepo_name=to push your local repository: 
call git remote add origin %remoteRepo_name%
call git push -u origin %branch_name%

echo.
echo Check the remote repository: %remoteRepo_name%
echo Don't forget to set the default branch and team. For this, write to channel "Examples/Work group" in Teams
echo Now you can remove the local repository folder - %repo_folder%
echo All done.

@pause



