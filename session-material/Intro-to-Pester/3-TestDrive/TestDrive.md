# Pester

## TestDrive

This is a method that allows you to test file operations without actually impacting the filesystem.

You can do the same with the Windows registry but I will likely be demo-ing this on Linux.

TestDrive will create a random folder in **$env:Temp**.

This allows you to run multiple instances of Pester and relax knowing that each instance if using TestDrive will have it's own version.