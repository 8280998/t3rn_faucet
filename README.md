# t3rn_faucet
测试地址：https://warpcast-mini-app.vercel.app/  已部署到base测试网

主要功能：提供GT为可领取水龙头


## 1.环境配置安装docker
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x get-docker.sh && ./get-docker.sh
    
## 2.编写水龙头合约
编写并部署水龙头合约，部署成功后向水龙头合约转入BRN测试币及其他测试币

## 3.准备后端代码并运行

3.11 修改docker-compose.yml中的OPERATOR_PRIVATE_KEY 和 OPERATOR_ADDRESS

3.12 修改index.html的合约参数

3.13 创建并设置 claims.db 文件权限

    touch claims.db && chmod 666 claim.db

3.14 构建 Docker 镜像

    docker build -t brn-faucet .

3.15 运行容器

    docker compose up -d

检查运行日志

    docker logs brn-faucet-brn-faucet-1

## 4.开启临时访问

测试玩的怎么简单怎么来，稳定的话还是得web服务组件

    python3 -m http.server 8099

## 打开水龙头领取页面进行操作

打开浏览器，访问https://warpcast-mini-app.vercel.app/

领取界面如下：
![image](https://github.com/user-attachments/assets/9cdb302f-af3f-41ff-8707-d34f20fe93d9)

![image](https://github.com/user-attachments/assets/5cccf72b-ce4e-4e61-906d-767090f2f3b8)

![image](https://github.com/user-attachments/assets/34124296-28dc-4f65-8652-5915c43908e5)

