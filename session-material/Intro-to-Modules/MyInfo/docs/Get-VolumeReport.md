---
external help file: myinfo-help.xml
Module Name: MyInfo
online version:
schema: 2.0.0
---

# Get-VolumeReport

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### computer (Default)
```
Get-VolumeReport [[-Computername] <String>] [-Drive <String>] [<CommonParameters>]
```

### session
```
Get-VolumeReport -CimSession <CimSession[]> [-Drive <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -CimSession
{{ Fill CimSession Description }}

```yaml
Type: CimSession[]
Parameter Sets: session
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Computername
Enter a computername

```yaml
Type: String
Parameter Sets: computer
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Drive
Enter a drive letter like C or D without the colon.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.Management.Infrastructure.CimSession[]

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
