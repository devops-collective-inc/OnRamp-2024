---
external help file: myinfo-help.xml
Module Name: MyInfo
online version:
schema: 2.0.0
---

# Get-ServerInfo

## SYNOPSIS

Get help desk server information

## SYNTAX

```yaml
Get-ServerInfo [[-Computername] <String[]>] [-Timeout <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get basic server information.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-ServerInfo SRV1

OperatingSystem    : Microsoft Windows Server 2016 Standard Evaluation
Version            : 10.0.14393
Uptime             : 1.05:39:22.5945412
MemoryGB           : 4
PhysicalProcessors : 2
LogicalProcessors  : 4
ComputerName       : SRV1
```

Get server configuration data from SRV1.

### EXAMPLE 2

```powershell
PS C:\> Get-ServerInfo SRV1,SRV2 | Export-CSV -path c:\reports\data.csv -append
```

Get server info and append to a CSV file.

## PARAMETERS

### -Computername

The name of the computer to query.
You must have admin rights.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: server, cn

Required: False
Position: 1
Default value: $env:computername
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Timeout

Enter the number of seconds between 1 and 10 to wait for a WMI connection.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

### PSServerinfo

## NOTES

Last Updated June 10, 2021

## RELATED LINKS

[Get-CimInstance]()

[Get-HWInfo](Get-HWInfo.md)
