# wireguard
## 利用方法
鍵を生成するためにパッケージインストール
```
sudo apt install wireguard
```
クライアント用の鍵生成
```
wg genkey | tee client.key | wg pubkey > client.pub
```
サーバ用の鍵生成
```
wg genkey | tee server.key | wg pubkey > server.pub
```

以下のようなconfig.confを作成
```
[Interface]
ListenPort = 51820
PrivateKey = #Server Key

[Peer]
PublicKey = #Client Pub Key
AllowedIPs = 10.0.0.2/24 # ルーティングするIPレンジ
```

以下のようなclient.confを作成

```
[Interface]
PrivateKey = # Client Private Key
Address = 10.0.0.2/24

[Peer]
PublicKey = # Server Pub Key
AllowedIPs = 10.0.0.0/24 # ルーティングするIPレンジ
Endpoint = グローバルIP:ポート
```
コンテナ作成と立ち上げ、確認
```
$ docker-compose up -d
$ docker-compose ps
  Name                 Command               State                      Ports
-------------------------------------------------------------------------------------------------
wireguard   /bin/bash -c ./setup.sh && ...   Up      0.0.0.0:51820->51820/tcp,:::51820->51820/tcp
```

## 参考
[公式](https://www.wireguard.com/)