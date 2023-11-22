# Tree構造のデータを格納する抽象クラス
class TreeNodeBase {
    # 親要素
    [TreeNodeBase]$Parent

    # 子要素　コレクション
    [Collections.Generic.List[TreeNodeBase]]$Children

    # コンストラクタ
    TreeNodeBase() {
        $this.Children = [Collections.Generic.List[TreeNodeBase]]::new()
    }

    # 要素を追加する
    [void] AddChild([TreeNodeBase]$child) {
        if ($null -eq $child) {
            throw [System.ArgumentNullException]::new("Failed: 引数にnullが挿入されている。")
        }
        $this.Children.Add($child)
        $child.Parent = $this
    }

    # Tree構造をコンソール上に表示させる
    [void] DisplayTree() {
        $this.DisplayTree(0)
    }
    [void] DisplayTree([int] $depth) {
        $indent = ' ' * ($depth * 2)
        Write-Host ("$indent- " + $this.ToString())

        foreach ($child in $this.Children) {
            $child.DisplayTree($depth + 1)
        }
    }

    # 抽象メソッド Tree構造から要素を検索して返す
    [TreeNodeBase] FindNode([string]$name) { return $null }

    # 抽象メソッド オブジェクトのデータを文字列で返す
    [string] ToString() { return $null }
}