# is git installed?
git --version



#  install git
winget show Git.Git
winget install --id Git.Git --exact --source winget

# Install and configure posh-git module
Install-Module posh-git -Scope CurrentUser
Import-Module posh-git

Add-PoshGitToProfile -AllHosts

# configure git with your name and email
git config --global user.email "kevmar@gmail.com"
git config --global user.name "Kevin Marquette"

git config --global init.defaultBranch main

git config --list --global


# Set VSCode as default editor
git config --global core.editor "code --wait"

# edit config in VSCode
git config --global --edit



# Download the demo script (Optional)
Set-Location -Path c:\source
git clone https://github.com/KevinMarquette/GitHubPresentation.git



# Create a new directory for the project
$path = "c:\source\demo_repo"
New-Item -Path $path -ItemType Directory -Force

# Initialize a new Git repository
Set-Location -Path $path
git init


# Explore the repository
Get-ChildItem  -Force

git status

code .

# Add files to the repository
Set-Content README.md -Value "My Awesome Project"
@"
'Building Project'
'Stage 1'
'Stage 2'
'Done Building Project'
"@ | Set-Content demo.ps1

git status


# Create initial commit
git add .\README.md
git add .\demo.ps1

git status

git commit -m "Initial commit"

git status

# look at the log
git log


# Set up remote repository
git remote add origin https://github.com/KevinMarquette/demo_repo_1.git
git push -u origin main


# Make a change
Set-Content README.md -Value "My Awesome Project - Updated"

git status

git diff .\README.md

git add .\README.md
git commit -m "Update README"

git log

git push

# Make another quick change
Set-Content README.md -Value "My Awesome Project - Updated 2"
git commit -a -m "Update README again"

git log
git log --oneline



# Work in progress
code .\demo.ps1  # work on stage 1
./demo.ps1


# Work interrupted
git status
Set-Content README.md -Value "My Amazing Project - Updated 3"
git add .\README.md

git status
git commit -m "Emergency Update"

git status


# Work interrupted on same file (git stash)
code .\demo.ps1 # work on stage 1

git status
git restore .\demo.ps1  # undo changes

git stash -m "Work in progress"
git status

code .\demo.ps1  # work on stage 2
git commit -a -m "HotFix Stage 2"
git status

# Continue working
git stash pop
code .\demo.ps1  # finish stage 1
git commit -a -m "Change Stage 1"




# Working with branches
git switch -c feature-stage-3
git checkout -b feature-stage-3  # legacy way

code .\demo.ps1  # work in progress on stage 3
git commit -a -m "Start Stage 3"

# Work interrupted
git switch main
git pull

git switch -c hotfix-stage-1
code .\demo.ps1  # work on hotfix stage1
git commit -a -m "Hotfix Stage 1"

# Merge hotfix into main
git switch main
git merge hotfix-stage-1

# Finish stage 3 and merge
git switch feature-stage-3
code .\demo.ps1  # finish stage 3
git commit -a -m "Finish Stage 3"

git switch main
git merge feature-stage-3 -m "Merge feature-stage-3 into main"
git push


