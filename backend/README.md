# Django のチュートリアルを行って勉強する

### サイト

- [Dajngo チュートリアル](https://docs.djangoproject.com/ja/4.2/intro/tutorial01/)
- [http://127.0.0.1:8000/](http://127.0.0.1:8000/)：最初起動時は，ここにロケットが離陸しているようなものが表示される．
- [http://127.0.0.1:8000/polls](http://127.0.0.1:8000/polls)：投票アプリへのアクセス用
- [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)：管理者画面アクセス用．このままアクセスするとログイン画面へ移動

## チュートリアル進行状況

- 初めての Django アプリ作成：2023 年 07 月
- 初めての Django アプリ作成 その 2：2023 年 07 月
- 初めての Django アプリ作成 その 3：2023 年 09 月
- 初めての Django アプリ作成 その 4：2023 年 09 月

## Django における「manage.py」

- 開発サーバを起動したり，データベースの作成をしたりする際の命令をおこなうためのファイル．

```
#()ないはDocker起動時に追加する必要が必要
(docker compose exec web) python manage.py <コマンド名>
```

- 開発用のサーバ起動

```
(docker compose exec web) python manage.py runserver
```

## Django の基礎的用語の説明

### Django プロジェクト

プロジェクトとは，データベースの設定などの Django 全体の設定群をまとめた一つの単位．あるウェブサイト向けに設定とアプリケーションを集めたもの．一つのプロジェクトには，複数のアプリケーションを入れられる．一つのアプリケーションは複数のプロジェクトで使用できる．プロジェクトには設定ファイルが集約される．そのため「config」という名前で作成されることもあるらしいです．

- プロジェクト作成コマンド

```
#「()」部分はDockerで使用時に必要です．<作成されるディレクトリ>はカレントディレクトリなら「.」で大丈夫
(docker-compose run web) django-admin.py startproject <作成したいプロジェクト名> <作成するディレクトリ>
```

- 作成されるファイルなど

```
# pythonにディレクトリを認識させるためのファイル．
__init__.py
# Djangoプロジェクト全体に関わる設定を記述するファイル．データベースの設定をなどもこのファイルに記述する．
settings.py
# ルーティングを記述するファイル．プロジェクトを作成した段階で，自動的にadminページのルーティングが設定されている．
urls.py
# WebServerGateWayに関する設定を記述するファイル．サーバに関する設定を記述するが，開発サーバであれば初期設定で動きます．ウィズギーと呼ぶ
wsgi.py
```

### Django アプリ

アプリケーションの作成は，startapp コマンドで行う．アプリケーションは必要に応じて「urls.py」「forms.py」「middleware.py」などを必要に応じて追加していきます．追加の機能があればアプリケーションを追加していく形になるのが Django の開発となっていく．

- Django アプリ作成コマンド

```
(docker compose exec web) python manage.py startapp <アプリケーション名>
```

- 作成されるファイルなど

```
# Djangoの機能の1つである．管理ページについて記述するファイル．
admin.py
# アプリケーション特有のカスタム解説を記述するファイル．
apps.py
# models.pyに記述されたモデルをデータベースに反映するためのファイル群を格納するディレクトリ．
migrations
# モデルを定義するファイル．
models.py
# 自動テストを記述するファイル．
test.py
# ビューを定義するファイル．
views.py
```

- アプリ作成後にしないといけないこと

★ アプリをプロジェクトに登録する <br>
作成したアプリを Django プロジェクトに認識させるために設定を行う．<br>
記述する場所「プロジェクト名/settings.py」の「INSTALLED_APPS」に下記のように追加する．<br>
今回だと「mysite/settings.py」に「polls.apps.PollsConfig」を追記する．

```Python
INSTALLED_APPS = [
    "polls.apps.PollsConfig", #追記しました．
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

- 自分で作成する必要があるフォルダ・ファイル．

★ テンプレートフォルダ <br>

### Django モデル

アプリケーション内のモデルをプロジェクトに組み込みには，「settings.py」の INSTALLED_APPS にアプリケーションへのモジュールパスを文字列で指定する．モデルを操作するには，まずモデルモジュールをインポートする「from todo.models import todo」のようにする．新しいモデルのインスタンスを生成するには，モデルクラスを呼び出す．データベースに保存するには「save()」メソッドを呼び出す．

- DataBase の設定 <br>
  プロジェクトの「settings.py」を開く．デフォルトの設定では，SQLite を使用する．SQLite は Python に標準で組み込まれているため，データベースをサポートするために何も追加でインストールする必要がない．他の DB を動かしたい場合は，[データベースのバインディング](https://docs.djangoproject.com/ja/4.2/topics/install/#database-installation)をインストールする必要があり，設定ファイルの「DATABASES」の「default」項目内の以下のキーをでデータベースの接続設定に合うように変更する必要がある．MYSQL なら「django.db.backends.mysql」これに変更する．
  データベースとして SQLite を使っていないなら「USER」「PASSWORD」「HOST」などの追加設定を加える必要がある．
  追加で「<プロジェクト名>/settings.py」を編集するときに「TIME_ZONE」に自分のタイムゾーンを設定する．
  <br>
  アプリケーションは最低 1 つのデータベースのテーブルを使うので，使い始める前にデータベースにテーブルを作る必要がある．

- データベースの作成方法 <br>
  下記コマンドは，「INSTALLED_APPS」の設定を参照するとともに，「<プロジェクト名>/settings.py」のデータベース設定に従って必要な全てのデータベースのテーブルを作成する．DBMigrate はアプリと共に配布される．

```
(docker compose exec web) python manage.py migrate
```

- モデルの作成 <br>
  モデルは本質的には，データベースのレイアウトと，それに付随するメタデータ．
  モデルを記述するのは，使用するアプリの「models.py」に記述する．
  <br><br>
  ★ モデルを有効にする <br>
  コードを model に書くだけで Django はたくさんのことを知れます．アプリケーションのデータベーススキーマを作成(CREATE TABLE 文を実行)できる．テーブルカラムオブジェクトに Python からアクセスするためのデータベース API を作成できる．しかし，そのままでは，使用できず「polls」アプリケーションをインストールしたことをプロジェクトに教えてやる必要がある．Django アプリケーションは，「プラガブル(pluggable)」．アプリケーションは特定の Django インストールに結びついていないのでアプリケーションを複数のプロジェクトで使用したり，単体で配布したりできる．
  アプリケーションをプロジェクトの「settings.py」の「INSTALLED_APPS」設定に追加する必要がある．上記でアプリ作成後にしないといけないことで polls を教える必要があると言って今回は繋いでいるので大丈夫です．ここまでできたら migration を行なってモデルを DB に作ってもらいます．

```
(docker compose exec web) python manage.py makemigrations <アプリケーション名>
```

「makemigrations」を実行することで，Django にモデルに変更があったことを伝え，そして変更をマイグレーションの形で保存することができた．マイグレーションは Django がモデルの変更を保存する方法のことです．マイグレーションファイルは，「<アプリケーション名>/migrations/0001_initial.py」から読むことができる．
<br>
最後に Django はマイグレーションの内容を実行してくれるコマンドがあります．自動でデータベーススキーマを管理するためのコマンドがある．「migrate」と呼ばれるコマンドです．最初にどんな SQL が実行されているのか見るためのコマンドを紹介する．
<br>
★migrate コマンドが実行する SQL 文．このコマンドは，実際に DB にマイグレーションを行わない．

```
(docker compose exec web) python manage.py sqlmigrate polls 0001
```

★ 実際に DB に反映される migtate を行うコード

```
(docker compose exec web) python manage.py migrate
```

migrate コマンドは，全ての適用されていないマイグレーションを認識してデータベースに対してそれを実行する．モデルに対して行なったことはデータベーススキーマに同期するということ．

<br><br>
簡単なモデル変更の流れ

- モデルを変更する．models.py を変更
- マイグレーションを作成するための「makemigrations」コマンドを実行する
- DB に変更を反映する migrate コマンドを実行する．

### Python シェル

```
(docker compose exec web) python manage.py shell
```

### Django Admin について

- 管理ユーザの作成 <br>

```
# このコマンドを入力すると新規のAdminサイト管理者アカウントを作成できる．
(docker compose exec web) python manage.py createsuperuser
# UserNameの入力とEmailAddressの入力，Passwordの入力が求められる．
```

### ソフトウェアの設計モデル「MTV(Model Template View)」

ソフトウェア設計モデルの 1 つである．Model，Template,View を表す．
モデルは，簡単に言うとデータベースと連携が取れる場所．Django でアプリを作ると自動で生成される「model.py」が該当します．
<br>
ビューは，モデルで引っ張ってきた情報をどのように見せるかを記述していくところになる．「views.py」というファイルで Django 自動生成してくれるファイル．
ビューの場所では，関数ごとにどの HTML ファイルに情報を渡すかを指定する．それによりそれぞれの関数をテンプレートに紐づけていくことになる．
<br>
テンプレートは，HTML ファイルのこと．ダイレクトにスクリーンに反映されるコード．「templates」フォルダの中に「\*\*\*.html」という形でおき，JS，CSS を用いてさらに見栄えなども整えれます．このテンプレートでは，モデルから直接情報を持ってくることはできない．必ず View を通して，関数化，パッケージ化されたデータをテンプレートで扱うことになる．特殊な記述「{{}}」「{% %}」の間に記述することで関数をビューから引っ張ってくることができる．
<br>
Django は，まず「プロジェクト」フォルダを作成し，Web アプリが動作するための基盤を構築する．次にプロジェクト内に「アプリケーション」フォルダを作成し，アプリ開発に必要なプログラムを組み込んでいく．「アプリケーション」が MTV の処置をまとめていく位置付けになる．つまり Django はアプリケーションごとに MTV コンポーネントが用意されプログラムが構築される．

## フォルダの意味

```
backend/：Dockerで今回開発に使用できるディレクトリ一般的にここは変化する
      ├ mysite/：Djangoのプロジェクト
	│     ├ urls.py：URLConfと呼ばれるURLのパターンとビューを関連づけるファイル．ルートURLConfと呼ばれる
	│     ├ settings.py：プロジェクト全体の設定を記述するためのファイル
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
	│     ├ admin.py：管理画面を操作するモジュール
	│     ├ apps.py：アプリケーションの実態
	│     ├ models.py：データモデルの定義を行うためのファイル．データベースにモデルを組み込まれる
	│     ├ tests.py：テストを記入する
	│     ├ urls.py：作成して，プロジェクトのurls.pyに組み込んで多くなることを制御
	│     ├ views.py：ビューを定義するためのファイル．
	│     └ ・・・
	│
	└ manage.py：プロジェクトを管理するためのスクリプト．
```

- mysite <br>
  Django のプロジェクト
- polls <br>
  Django のアプリケーション．今回は投票処理を行うアプリの作成．

## どんなことをしているのかの簡単な説明

- 初めての Django アプリ作成 1<br>
  これから作る「簡単な投票アプリケーション(Poll)」であることの明示をしている．Django のインストール確認と Django の初めてのプロジェクト作成．開発用サーバを起動させてみる．初めてのアプリケーションである Poll を作成する．初めての View を作成．
- 初めての Django アプリ作成 2<br>
  Database の設定．モデルの作成．モデルの有効にする方法．API で遊んでみる．DjangoAdmin についての説明．
- 初めての Django アプリ作成 3<br>
- 初めての Django アプリ作成 4<br>

## Python の Web フレームワーク

- Django：フルスタックで機能が豊富であること，認証系が容易に構築・カスタマイズができる．
- Flask：
- bottle：
- Tornado：

## 参考

- [Django プロジェクトとアプリについて](https://www.techpit.jp/courses/5/curriculums/6/sections/42/parts/145)
- [Django 用語「基礎」](https://qiita.com/aoi_shima/items/6376e2c2884da4224905)
- [Django 用語「公式」](https://docs.djangoproject.com/ja/4.2/glossary/)
- [MTV という考え方](https://qiita.com/kotayanagi/items/01e9a617571e2b9526bc)
- [MVC・MTV アーキテクチャ・モデル設計思想の解説](https://di-acc2.com/programming/python/546/)
- [基礎から学 Django 開発 ①](https://kosa3.medium.com/%E5%9F%BA%E7%A4%8E%E3%81%8B%E3%82%89%E5%AD%A6%E3%81%B6django%E9%96%8B%E7%99%BA%E2%91%A0-14066e174ef4)
