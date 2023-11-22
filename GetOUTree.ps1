using module ".\Lib\TreeNodeBase.psm1"

class TreeData : TreeNodeBase {
    [string]$Name

    OU([string]$name) {
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

    [string] ToString() {
        return $this.Name
    }
}

# ノードの作成
$root = [TreeData]::new("Root")
$child1 = [TreeData]::new("Child1")
$child2 = [TreeData]::new("Child2")
$grandchild1 = [TreeData]::new("Grandchild1")

# ツリー構造の組み立て
$root.AddChild($child1)
$root.AddChild($child2)
$child1.AddChild($grandchild1)

# ツリーの表示
$root.DisplayTree()

# ノードの検索
$searchResult = $root.FindNode("Grandchild1")
if ($null -ne $searchResult) {
    Write-Host "Found: $($searchResult.Name)"
} else {
    Write-Host "Not Found"
}