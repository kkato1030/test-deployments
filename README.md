# test deployements

GitHub Deployments を試すためのリポジトリ

## 試し方

1. 適当なブランチを作成、適当なファイルを作成して push する
2. PR を作成すると Deployments の存在チェックが入りマージがブロックされる
3. `./scripts/create-deployments {env} {branch_name}` を実行するとブランチの最新コミットに紐づく Deployments が作成される
4. 2 でコケたフローを Rerun する (←この手順なくしたい、、、) と Deployments があるためブロックが解除される

1 のあと、Deployments を先に作成してから PR を作成すると、ブロックされることなくマージも可能