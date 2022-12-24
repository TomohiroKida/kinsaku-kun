kinsaku-kun 

# 準備するもの
- Nintendo Switch (ドックより手持ちがよい)
- Raspberrypi 4

# 参考にしたサイト
https://ponkichi.blog/rapsberry-switch-01/#st-toc-h-1
https://github.com/Almtr/joycontrol-pluginloader/blob/master/README_ja.md

## 1. Python3などをインストール
```
sh setup.sh
```

## 2. git からパッケージを入手
```
git clone https://github.com/mart1nro/joycontrol.git
git clone --recursive https://github.com/Almtr/joycontrol-pluginloader.git
```


## 3. Pythonの仮想環境を作成し，アクティベート
```
python3 -m venv venv
source venv/bin/active
```

## 4. Pythonのパッケージをインストール
```
pip install wheel
pip install joycontrol/
pip install joycontrol-pluginloader/
pip install hid==1.0.4
```

## 5. ラズパイのMACアドレスを，Switchが認識できるもの(94:58:CBから始まるもの)に変更
```
sudo hcitool -i hci0 cmd 0x04 0x009
sudo hcitool -i hci0 cmd 0x3f 0x001 0x56 0x34 0x12 0xCB 0x58 0x94
sudo systemctl restart bluetooth.service
sudo vi /lib/systemd/system/bluetooth.service
	# 変更前: ExecStart=/usr/libexec/bluetooth/bluetoothd
	# 変更後: ExecStart=/usr/libexec/bluetooth/bluetoothd -C -P sap,input,avrcp
sudo systemctl daemon-reload
sudo systemctl restart bluetooth.service
```

## 6. ラズパイをペアリング
Switchの設定画面から下記へ
 設定 > コントローラーとセンサー > コントローラーの持ち方/順番を変える
以下のコマンドを実行
```
cd ./joycontrol-pluginloader
sudo /home/pi/work/kinsaku-kun/venv/bin/joycontrol-pluginloader plugins/tests/PairingController.py
```
スクリプトが走り始めたら，接続操作をしている証拠．
1, 2分かかる(1, 2分経ってもウンスンの場合はCtrl-Cして再度コマンドを実行)
コントローラーが登録され，設定画面に自動で戻ってきたらOK．
*その後，登録されたコントローラーは解除されるが問題ない．*

あなたのSwichのMACアドレスを確認しましょう．
先ほどの実行結果に書いてあります．
```
[10:10:10] joycontrol.server create_hid_server::98 INFO - Accepted connection at psm 17 from ('01:23:45:67:89:AB', 17)
[10:10:10] joycontrol.server create_hid_server::100 INFO - Accepted connection at psm 19 from ('01:23:45:67:89:AB', 19)
```

## 7. test
Switchの設定画面から下記へ
設定 > コントローラーとセンサー > 入力デバイスの動作チェック
以下のコマンドを実行すると，A,B,X,Y,L,R,...と入力デバイスを送るテストを始める
```
# ディレクトリパスは，あなたの環境に合わせましょう
# XX:XX:XX:XX:XX:XXは，あなたのSwitchのMACアドレスにしましょう
sudo /home/xx/xx/kinsaku-kun/venv/bin/joycontrol-pluginloader -r XX:XX:XX:XX:XX:XX plugins/tests/TestControllerButtons.py
```

## 8. Aボタンを押し続ける
例の場所に行く
以下のコマンドを実行すると，Aボタンを0.1秒ごとに押したり，離したりする
```
# ディレクトリパスは，あなたの環境に合わせましょう
# XX:XX:XX:XX:XX:XXは，あなたのSwitchのMACアドレスにしましょう
sudo /home/xx/xx/kinsaku-kun/venv/bin/joycontrol-pluginloader -r XX:XX:XX:XX:XX:XX ../ContinueButtonA.py
```
take a break!

## 9. 終わったら, venv環境をデアクティベート
```
cd ../
deactivate
```
ラズパイを再起動すると，MACアドレスの設定はリセットされます．
