
#1. Get the top 10 processes sorted by working set in descending order,
# showing only the name, id, working set, the process path, and when it started.

#region Exercise 1

Get-Process | Sort-Object -Property WorkingSet -Descending |
Select-Object -First 10 -Property Name,Id,WorkingSet,Path,StartTime

#endregion


# 2. Show a sorted list of processes grouped by the company name in descending order
# that have more than 10 processes.

#region Exercise 2

Get-Process | Where-Object {$_.Company} | Group-Object -Property company |
Where-Object {$_.Count -gt 10} | Sort-Object -Property Count -Descending |
Select-Object -Property Count,Name

#endregion

#3. Take the first 5 running services and display the service name in uppercase

#region Exercise 3

Get-Service | Where-Object {$_.Status -eq 'Running'} | Select-Object -First 5 |
foreach-Object {$_.Name.ToUpper()}

#endregion
