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
