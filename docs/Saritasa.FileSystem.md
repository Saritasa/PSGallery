
# Saritasa.FileSystem

## Remove-EmptyDirectories

### Synopsis
Removes all empty directories under the given path.

### Syntax
Remove-EmptyDirectories \[-Path\] &lt;String&gt; \[-DeletePathIfEmpty\] \[\[-OnlyDeleteDirectoriesCreatedBeforeDate\] &lt;DateTime&gt;\] \[\[-OnlyDeleteDirectoriesNotModifiedAfterDate\] &lt;DateTime&gt;\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

### Parameters

<table class="table table-striped table-bordered table-condensed visible-on">
	<thead>
		<tr>
			<th>Name</th>
			<th class="visible-lg visible-md">Alias</th>
			<th>Description</th>
			<th class="visible-lg visible-md">Required?</th>
			<th class="visible-lg">Pipeline Input</th>
			<th class="visible-lg">Default Value</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><nobr>Path</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td>Path to folder to scan.</td>
			<td class="visible-lg visible-md">true</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>DeletePathIfEmpty</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td>If set, the root folder \(specified in Path variable\) will also be removed if it complies the provided filters.</td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg">False</td>
		</tr>
		<tr>
			<td><nobr>OnlyDeleteDirectoriesCreatedBeforeDate</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td>If specified, only directories created before the given date will be removed.</td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg">\[DateTime\]::MaxValue</td>
		</tr>
		<tr>
			<td><nobr>OnlyDeleteDirectoriesNotModifiedAfterDate</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td>If specified, only directories last time modified before the given date will be removed.</td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg">\[DateTime\]::MaxValue</td>
		</tr>
		<tr>
			<td><nobr>WhatIf</nobr></td>
			<td class="visible-lg visible-md">wi</td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>Confirm</nobr></td>
			<td class="visible-lg visible-md">cf</td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
	</tbody>
</table>

### Note
Author: Daniel Schroeder
http://blog.danskingdom.com/powershell-functions-to-delete-old-files-and-empty-directories/


### Examples
**EXAMPLE 1**
```
Remove-EmptyDirectories -Path "C:\SomePath\Temp" -DeletePathIfEmpty

```
Delete all empty directories in the Temp folder, as well as the Temp folder itself if it is empty.
**EXAMPLE 2**
```
Remove-EmptyDirectories -Path "C:\SomePath\WithEmpty\Directories" -OnlyDeleteDirectoriesCreatedBeforeDate ([DateTime]::Parse("Jan 1, 2014 15:00:00"))

```
Delete all empty directories created after Jan 1, 2014 3PM.
**EXAMPLE 3**
```
Remove-EmptyDirectories C:\SomePath\WithEmpty\Directories -OnlyDeleteDirectoriesCreatedBeforeDate [DateTime]::Today.AddDays(-1)

```
Delete all empty directories created before yesterday.

## Remove-FilesCreatedBeforeDate

### Synopsis
Removes all files in the given Path that were created before the given date, as well as any empty directories that may be left behind.

### Syntax
Remove-FilesCreatedBeforeDate \[-Path\] &lt;String&gt; \[-DateTime\] &lt;DateTime&gt; \[-DeletePathIfEmpty\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

### Parameters

<table class="table table-striped table-bordered table-condensed visible-on">
	<thead>
		<tr>
			<th>Name</th>
			<th class="visible-lg visible-md">Alias</th>
			<th>Description</th>
			<th class="visible-lg visible-md">Required?</th>
			<th class="visible-lg">Pipeline Input</th>
			<th class="visible-lg">Default Value</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><nobr>Path</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td></td>
			<td class="visible-lg visible-md">true</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>DateTime</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td></td>
			<td class="visible-lg visible-md">true</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>DeletePathIfEmpty</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg">False</td>
		</tr>
		<tr>
			<td><nobr>WhatIf</nobr></td>
			<td class="visible-lg visible-md">wi</td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>Confirm</nobr></td>
			<td class="visible-lg visible-md">cf</td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
	</tbody>
</table>

### Note
Author: Daniel Schroeder
http://blog.danskingdom.com/powershell-functions-to-delete-old-files-and-empty-directories/


### Examples
**EXAMPLE 1**
```
Remove-FilesCreatedBeforeDate -Path "C:\Some\Directory" -DateTime ((Get-Date).AddDays(-2)) -DeletePathIfEmpty

```
Delete all files created more than 2 days ago.
**EXAMPLE 2**
```
Remove-FilesCreatedBeforeDate -Path "C:\Another\Directory\SomeFile.txt" -DateTime ((Get-Date).AddMinutes(-30))

```
Delete a single file if it is more than 30 minutes old.
**EXAMPLE 3**
```
Remove-FilesCreatedBeforeDate -Path "C:\SomePath\Temp" -DateTime (Get-Date) -DeletePathIfEmpty -WhatIf

```
See what files and directories would be deleted if we ran the command.

## Remove-FilesNotModifiedAfterDate

### Synopsis
Removes all files in the given Path that have not been modified after the given date, as well as any empty directories that may be left behind.

### Syntax
Remove-FilesNotModifiedAfterDate \[-Path\] &lt;String&gt; \[-DateTime\] &lt;DateTime&gt; \[-DeletePathIfEmpty\] \[-WhatIf\] \[-Confirm\] \[&lt;CommonParameters&gt;\]

### Parameters

<table class="table table-striped table-bordered table-condensed visible-on">
	<thead>
		<tr>
			<th>Name</th>
			<th class="visible-lg visible-md">Alias</th>
			<th>Description</th>
			<th class="visible-lg visible-md">Required?</th>
			<th class="visible-lg">Pipeline Input</th>
			<th class="visible-lg">Default Value</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><nobr>Path</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td></td>
			<td class="visible-lg visible-md">true</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>DateTime</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td></td>
			<td class="visible-lg visible-md">true</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>DeletePathIfEmpty</nobr></td>
			<td class="visible-lg visible-md"></td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg">False</td>
		</tr>
		<tr>
			<td><nobr>WhatIf</nobr></td>
			<td class="visible-lg visible-md">wi</td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
		<tr>
			<td><nobr>Confirm</nobr></td>
			<td class="visible-lg visible-md">cf</td>
			<td></td>
			<td class="visible-lg visible-md">false</td>
			<td class="visible-lg">false</td>
			<td class="visible-lg"></td>
		</tr>
	</tbody>
</table>

### Note
Author: Daniel Schroeder
http://blog.danskingdom.com/powershell-functions-to-delete-old-files-and-empty-directories/


### Examples
**EXAMPLE 1**
```
Remove-FilesNotModifiedAfterDate -Path "C:\Another\Directory" -DateTime ((Get-Date).AddHours(-8))

```
Delete all files that have not been updated in 8 hours.
