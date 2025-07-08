# TrashCLI.ps1

class TestTrashItem {
    [string]$Name
    [string]$OriginalPath
    [string]$CurrentStatus
    [datetime]$ActionTime

    TestTrashItem([string]$name, [string]$originalPath, [string]$status) {
        $this.Name         = $name
        $this.OriginalPath = $originalPath
        $this.CurrentStatus = $status
        $this.ActionTime   = Get-Date
    }

    [string] ToString() {
        return "$($this.Name) [$($this.CurrentStatus)]"
    }
}

class TestTrashBin {
	static [TestTrashItem[]] ListItems() {
        $shell = New-Object -ComObject Shell.Application
        $bin   = $shell.Namespace(0xa)
        $items = $bin.Items()
        $list  = @()

        foreach ($item in $items) {
            $name = $item.Name
            $originalPath = $bin.GetDetailsOf($item, 1)
            $list += [TestTrashItem]::new($name, $originalPath, "InRecycleBin")
        }

        return $list
    }
}


