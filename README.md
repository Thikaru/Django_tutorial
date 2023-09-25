# Django Docker Tutorial

## このリポジトリの概要

Django の勉強を行っているリポジトリです．DjangoTutorial を行いながら Django の機能などを調べてまとめています．

## このリポジトリを使うための初期設定について

1. このプロジェクトをクローンする．
2. 「docker-compose.yml」があるディレクトリで「docker-compose build」コマンドで Docker コンテナを作成
3. backend に ある Djangp プロジェクトを「docker-compose up」でコンテナを起動して動かす．
4. djangopj/settings.py を開き下の記述する内容のように DB の設定を変更する
5. アクセスできるかを確認する．
6. docker compose exec web python3 manage.py migrate DB にマイグレートする
7. http://localhost:8000/

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
				'USER': 'root',
				'PASSWORD': 'password',
				'HOST': 'db',
				'PORT': 5432,
    }
}

```

## Set up

```bash
# build これでビルドしてから実行するのがいい
docker compose build
# up 動かす時は大体これを実行する
docker compose up
## remote container ##

# down
docker compose down
```

## Specs

- python 3.9
- django 3.2（LTS）

## GitHub ブランチルール

- main ブランチから DjangoTutorial の章ごとにベースブランチとして「Charpter?」という形でブランチを切る．？は章の名前
- その後，章ごとに行う機能追加は分割できる場合は，「Charpter?/追加・修正機能に関係する名前」という形でブランチを切り，「Charpter?」というベースブランチにプルリクを出して，今回個人なのでそこまで細かな確認をしないが，ミスがないかを確認してベースブランチにマージする．
- 章が終わった時に，「Charpter?」のブランチ内容を「main」のブランチにマージして確認して次に進む

## コミットルールも作りたい

★ 理由<br>
コミット毎回その時にやったことを簡単に書いてるけど，よりぱっと見でわかるようなコミットメッセージの方がいいなと感じました．
なので，Prefix(頭につけるもの)を決める．修正，追加，削除ごとに決まったものを書いて何をやっているのかの明確化を行います．調べていいなと思ったものを実施してみて，難しいところなどを追記して，どんどん自分がいいと思うものを作成していきたい．とりあえずのルールは下記のようにしようと決める．
あと，英語のみがいいと思うが，今回はわかりにくいし，英語があってなさそうな時があるので日本語で記述する(Prefix 以外は大体日本語)

```
add：新規ファイル，ライブラリを追加

delete：ミスしたコードの削除

remove：ファイル，ライブラリの削除など

fix：バグ修正

update：機能修正(バグではない)

feat：ユーザが利用する機能追加，修正に関するコミット

refactor：リファクタリング

upgrade：設定ファイルなどの編集

style：コードの見た目の変更．インデントなど

docs：ドキュメントの編集
```

## プルリクのテンプレートを作りたい

プルリク時に使用する内容を固定化することで，毎回一定ラインの情報を提供できるようにしたい．そのために，前使われていたのをみて使ってみようと思い，今回追加しました．まだまだな部分はありますが，テストで自分個人で必要なものだけを追加しました．使っていき追加した方がいいものは追加していこうと思います．
<br>
★ やるために必要な処理

- 「.github」フォルダを作成
- 「PULL_REQUEST_TEMPLATE.md」を「.github」フォルダ内に追加する．

## 参考・参照・引用

- [PullRequest のテンプレートを作って効率よくレビュー使用](https://dev.classmethod.jp/articles/pull-request-template/)
- [GitHub 公式 PullRequest テンプレートの作成](https://docs.github.com/ja/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository)
- [Git でコミットする時のルールを言語化してみた](https://pyteyon.hatenablog.com/entry/2020/02/27/092101)
- [Git のコミットメッセージの書き方](https://qiita.com/itosho/items/9565c6ad2ffc24c09364)
- [僕が考える最強のコミットメッセージの書き方](https://qiita.com/konatsu_p/items/dfe199ebe3a7d2010b3e)
