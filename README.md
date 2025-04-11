# t3rn_faucet
t3rn水龙头，测试地址：http://107.174.79.186:8099/

主要功能：如果是新地址可以无gas领取BRN，但领取其他测试币如TST，T3usd则需要BRN当GAS。

## 1.环境配置安装docker
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x get-docker.sh && ./get-docker.sh
    
## 2.编写水龙头合约
编写并部署水龙头合约，部署成功后向水龙头合约转入BRN测试币及其他测试币

## 3.准备后端代码并运行
server.py, Dockerfile, docker-compose.yml, 和 index.html 放在同一目录，并运行相关命令

    touch claims.db && chmod 666 claims.db
    docker build -t brn-faucet .
    docker compose up -d

检查运行日志

    docker logs brn-faucet-brn-faucet-1

## 4.开启临时访问

    python3 -m http.server 8099

## 打开水龙头领取页面进行操作

打开浏览器，访问 http://107.174.79.186:8099

领取界面如下：
![image](https://github.com/user-attachments/assets/9cdb302f-af3f-41ff-8707-d34f20fe93d9)

![image](https://github.com/user-attachments/assets/34124296-28dc-4f65-8652-5915c43908e5)

