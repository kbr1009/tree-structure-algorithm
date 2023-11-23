using module ".\Lib\TreeNodeBase.psm1"

class TreeData : TreeNodeBase {
    [string]$Name

    TreeData([string]$name) {
        $this.Name = $name
    }

    [TreeNodeBase] FindNode([string]$name) {
        if ($this.Name -eq $name) {
            return $this
        }
        foreach ($child in $this.Children) {
            $result = $child.FindNode($name)
            if ($null -ne $result) {
                return $result
            }
        }
        return $null
    }

    [string] ToStringTree() {
        return $this.ToStringTree(0)
    }
    [string] ToStringTree([int]$depth) {
        $sb = New-Object System.Text.StringBuilder
        $indent = ' ' * ($depth * 2)
        $sb.AppendLine("${indent}- $($this.Name)")

        foreach ($child in $this.Children) {
            $sb.Append($child.ToStringTree($depth + 1))
        }

        return $sb.ToString()
    }

    # Tree構造をコンソール上に表示させる
    [void] DisplayTree() {
        Write-Host $this.ToStringTree()
    }

    [string] ToStringVal() {
        return $this.Name
    }
}

# ノードの作成
$root = [TreeData]::new("root")
$c1 = [TreeData]::new("C-1")
$c2 = [TreeData]::new("C-2")
$c11 = [TreeData]::new("C-1-1")
$c12 = [TreeData]::new("C-1-2")
$c21 = [TreeData]::new("C-2-1")

# ツリー構造の組み立て
$root.AddChild($c1)
$root.AddChild($c2)
$c1.AddChild($c11)
$c1.AddChild($c12)
$c2.AddChild($c21)

# ツリーの表示
Write-Host $root.ToStringTree()

# ノードの検索
$searchResult = $root.FindNode($c12.Name)
if ($null -ne $searchResult) {
    Write-Host "Found: $($searchResult.Name)"
} else {
    Write-Host "Not Found"
}