# Django のチュートリアルを行って勉強する

### サイト

[Dajngo チュートリアル](https://docs.djangoproject.com/ja/4.2/intro/tutorial01/)

## チュートリアル進行状況

- 初めての Django アプリ作成：2023 年 07 月
- 初めての Django アプリ作成 その 2：2023 年 07 月
- 初めての Django アプリ作成 その 3：2023 年 09 月
- 初めての Django アプリ作成 その 4：2023 年 09 月

## フォルダの意味

```
backend/：Dockerで今回開発に使用できるディレクトリ一般的にここは変化する
    ├ mysite/：
	│     ├ urls.py：
	│     ├ settings.py：
	│     └ ・・・
	│
	├ polls/：
	│     ├ migrations/：
	│     │     ├ 0001_initial.py：
	│     │     └ ・・・
	│     │
	│     ├ templates/：
	│     │     ├ polls/：
	│     │     │     ├ index.html：
	│     │     │     └ ・・・
	│     │     │
	│     │     └ ・・・
	│     │
	│     ├ admin.py：
	│     ├ apps.py：
	│     ├ models.py：
	│     ├ tests.py：
	│     ├ urls.py：
	│     ├ views.py：
	│     └ ・・・
	│
	└ manage.py：
```

- mysite <br>
  Django のプロジェクト

## URL について

- [http://127.0.0.1:8000/](http://127.0.0.1:8000/)：最初起動時は，ここにロケットが離陸しているようなものが表示される．
- [http://127.0.0.1:8000/polls](http://127.0.0.1:8000/polls)：投票アプリへのアクセス用
- [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)：管理者画面アクセス用．このままアクセスするとログイン画面へ移動

## どんなことをしているのかの簡単な説明

- 初めての Django アプリ作成 1<br>
  これから作る「簡単な投票アプリケーション(Poll)」であることの明示をしている．Django のインストール確認と Django の初めてのプロジェクト作成．開発用サーバを起動させてみる．初めてのアプリケーションである Poll を作成する．初めての View を作成．
- 初めての Django アプリ作成 2<br>
  Database の設定．モデルの作成．モデルの有効にする方法．API で遊んでみる．DjangoAdmin についての説明．
- 初めての Django アプリ作成 3<br>
- 初めての Django アプリ作成 4<br>
