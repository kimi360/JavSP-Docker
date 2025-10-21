# JavSP-Docker
[![icon][icon.license]][link.license]
[![icon][icon.javsp]][link.javsp.version]
[![icon][icon.docker.size]][link.docker.tags]
[![icon][icon.docker.pull]][link.docker.page]


## 简介
**汇总多站点数据的AV元数据刮削器**

提取影片文件名中的番号信息，自动抓取并汇总多个站点数据的 AV 元数据，按照指定的规则分类整理影片文件，并创建供 Emby、Jellyfin、Kodi 等软件使用的元数据文件

## 特点
使用了较小的基础镜像，控制了整体镜像的大小。


## 使用
### 快速开始
- 下载 [配置文件][configfile]
- 修改配置文件中的 scanner.input_directory #设置扫描目录(容器内)
- 修改配置文件中的 scanner.manual **yes -> no** #设置禁用手动确认
- 修改配置文件中的 other.interactive **true -> false** #设置禁止交互
- 修改配置文件中的 network.proxy_server #设置代理

### 命令行
```shell
docker run -d \
  --name javsp \
  -v ./config.yml:/app/config.yml\
  -v <DIRECTORY_TO_SCRAPE>:<SCANNER.INPUT_DIRECTORY> \
  kimi360/javsp:latest
```
- <DIRECTORY_TO_SCRAPE>：宿主机器上需要刮削的目录
- <SCANNER.INPUT_DIRECTORY>：和配置文件中的scanner.input_directory保持一致


### Docker-compose
```yaml
version: '3'
services:
  ariang:
    image: kimi360/javsp
    container_name: javsp
    volumes:
      - ~/config.yml:/config.yml
      - <DIRECTORY_TO_SCRAPE>:<SCANNER.INPUT_DIRECTORY>
```
- 扫描任务完成后docker会自动退出

## 引用
- [Yuukiy/JavSP][javsp]


## 协议
- [MIT][link.license]

[icon.license]:            https://img.shields.io/github/license/kimi360/JavSP-Docker
[icon.javsp]:              https://img.shields.io/github/v/release/Yuukiy/JavSP?label=JavSP
[icon.docker.size]:        https://img.shields.io/docker/image-size/kimi360/javsp/latest?color=yellow
[icon.docker.pull]:        https://img.shields.io/docker/pulls/kimi360/javsp?color=orange

[link.license]:            https://github.com/kimi360/Dockerfiles/blob/main/LICENSE
[link.javsp.version]:      https://github.com/Yuukiy/JavSP/releases
[link.docker.page]:        https://hub.docker.com/r/kimi360/javsp
[link.docker.tags]:        https://hub.docker.com/r/kimi360/javsp/tags

[javsp]:                   https://github.com/Yuukiy/JavSP
[dockerfile]:              https://github.com/kimi360/JavSP-Docker/blob/main/Dockerfile
[configfile]:              https://raw.githubusercontent.com/Yuukiy/JavSP/refs/heads/master/config.yml