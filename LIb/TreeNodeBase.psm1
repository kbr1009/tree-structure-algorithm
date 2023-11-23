# Tree構造のデータを格納する抽象クラス
class TreeNodeBase {
    # 親要素
    [TreeNodeBase]$Parent

    # 子要素　コレクション
    [List[TreeNodeBase]]$Children

    # コンストラクタ
    TreeNodeBase() {
        $this.Children = [List[TreeNodeBase]]::new()
    }

    # 要素を追加する
    [void] AddChild([TreeNodeBase]$child) {
        if ($null -eq $child) {
            throw [ArgumentNullException]::new("Failed: 引数にnullが挿入されている。")
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
        Write-Host ("$indent- " + $this.ToStringVal())

        foreach ($child in $this.Children) {
            $child.DisplayTree($depth + 1)
        }
    }

    # Tree構造を文字列で返す
    [string] ToStringTree() {
        return $this.ToStringTree(0)
    }
    [string] ToStringTree([int]$depth = 0) {
        $sb = New-Object Text.StringBuilder
        $indent = ' ' * ($depth * 2)
        $sb.AppendLine("${indent}- $this")

        foreach ($child in $this.Children) {
            $sb.Append($child.ToStringTree($depth + 1))
        }

        return $sb.ToString()
    }

    # 抽象メソッド Tree構造から要素を検索して返す
    [TreeNodeBase] FindNode([string]$name) { return $null }

    # 抽象メソッド オブジェクトのデータを文字列で返す
    [string] ToStringVal() { return $null }
}