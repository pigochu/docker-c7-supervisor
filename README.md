Docker Centos7-Supervisor
=========================

這個 Image 主要是為了懶惰的人所設計的，目的也是為了開發專案用，
使用設定檔覆蓋的方式來啟動 container，避免使用大量 Environment 來設定 container，
以減少重新 Build Image 的機會

而這個 Image 目前只包了 supervisord ，是一個基礎 Image，幾乎沒甚麼用途



# 特色 #

* 基於官方 centos7
* 利用 VOLUME /docker-settings 覆蓋 container 內的任意檔案，及執行 shell ，
  達成最大彈性設定 container
* 已安裝 epel-release
* 已安裝 supervisord 管理進程，預設啟動


# ENTRYPOINT #

本容器的進入點是 /opt/c7supervisor/bin/entrypoint.sh

主要執行初始化動作，初始化的過程如下
1. 處理 /docker-settings/replace-files 下的檔案
2. 處理 /docker-settings/template-files 下的檔案
3. 執行 /docker-settings/before-supervisor.d 下的檔案
4. 執行 supervisor
5. 執行 /docker-settings/after-supervisor.d 下的檔案



# VOLUME /docker-settings 的詳細說明 #

這個 VOLUME 主要是要讓本 container 用最簡單的方式進行一些初始化動作，
你必須自行對應好這個 VOLUME 到你的本機路徑，假設 D:/my-project/docker-settings
對應好之後，可以建立以下四個文件夾，讓 container 作相對應的工作

* replace-files : 存放於此目錄的檔案，會於尚未啟動 supervisor 之前，
  將檔案複製到 container 內。
* templates-files :  類似 replace-files，
  但會以 envsubst 方式將環境變數套用內容後，複製到 container 內。
* before-supervisor.d : 在 supervisor 尚未啟動前，
  會先執行裡面的 script，執行順序會依照檔名排序
* after-supervisor.d : 在 supervisor 啟動後才會執行裡面的 script，
  執行順序會依照檔名排序


## 範例 : 如果你想要讓 cron 執行你的 script ##

1. 請先將 VOLUME /docker-settings 對應到你的 storage 路徑 , 
   假設是 D:/my-project/docker-settings
2. D:/my-project/docker-settings 下建立 replace-files/etc/cron.d
3. 將你的 cron 設定檔放到 D:/my-project/docker-settings/replace-files/etc/cron.d
4. 重新啟動 container，
   這樣子 container 在啟動 cron 之前就會先複製檔案到 /etc/cron.d，
   然後才會啟動 cron。

但我保證你會執行錯誤，因為本 Image 是一個基礎 Image，根本沒裝 cron，哈   

> 如果想要搭配環境變數來動態設定檔案內容，請將檔案放入 templates-files
> 檔案裝使用 ${變數名稱} 的方式會被自動取代後才覆蓋到 container 相對的檔案中。

# Matainer #

Pigo Chu <pigochu@gmail.com>







