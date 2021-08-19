# wireguard
## 利用方法
パッケージインストール
```
$ sudo apt install -y qrencode wireguard
```
クライアント用の鍵生成と権限の変更
```
$ wg genkey | tee client.key | wg pubkey > client.pub
$ chmod 600 client.pub
```
サーバ用の鍵生成
```
wg genkey | tee server.key | wg pubkey > server.pub
$ chmod 600 server.pub
```

以下のようなconfig.confを作成
```
[Interface]
ListenPort = 51820
PrivateKey = # Server Key

[Peer]
PublicKey = # Client Pub Key
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
ufwを利用している場合、wireguradで利用するポート番号を許可する
```
$ sudo ufw allow 51820/udp
$ sudo ufw reload
```
クライアントの設定
スマホの場合
以下のコマンドで設定用のQRコードを生成し、スマホで読み込む
```
qrencode -t ansiutf8 < client.conf
```

PCの場合
client.confをクライアント用のPCに移動
```
$ mv client.conf /etc/wireguard/wg0.conf
```
wireguard起動
```
$ wg-quick up wg0
```

## 参考
[公式](https://www.wireguard.com/)