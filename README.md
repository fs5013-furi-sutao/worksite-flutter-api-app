# Spring Boot + MySQL をバックエンド API サーバにした現場情報管理の Flutter アプリ

## 開発環境とツール
Windows 10 Home 64bit バージョン 1909（OS ビルド 18363.1082）
Docker Toolbox 19.03.1
Git Bash(Git 2.28.0.windows.1)
REST API - Spring Boot(Java) 2.3.3
API Document - Swagger(springfox 3.0.0)
DB Migration - Flyway 6.5.7
DB - MySQL 8.0 with Docker Compose
Native app framework - Flutter 1.22.1(Dart 2.10.1) 
VS Code

## Getting Started

### DB コンテナの起動
```console
docker-compose up -d
```

### バックエンドの起動
```console
cd ./backend-spring boot
gradle bootRun
```

gradle をインストールしていない場合は gradle コマンドの代わりに、gladrew.bat で起動させる。
```console
./gradlew bootRun
```

### Flutter アプリの起動
Flutter アプリは VSCode で動かすか、以下のコマンドで起動させる。
```console
flutter run
```


