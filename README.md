---
tags: [macos, ubuntu, x11, korean, docker, ko_kr, utf-8, 한글, locale, python, python3, PyQt5]
---
[![](https://images.microbadger.com/badges/version/coldblaze/pyqt5-korean.svg)](https://microbadger.com/images/coldblaze/pyqt5-korean "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/coldblaze/pyqt5-korean:latest.svg)](https://microbadger.com/images/coldblaze/pyqt5-korean:latest "Get your own image badge on microbadger.com")

# coldblaze/pyqt5-korean : Docker PyQt5 한글 사용

**이 글의 코드 : [coldblaze/docker-pyqt5-korean](https://github.com/coldblaze/docker-pyqt5-korean)**

Ubuntu 18.04, PyQt5 에서 한글을 사용하기 위한 docker image이다.
macOS에서는 ssh X11Forwarding을, 리눅스 데스크탑에서는 unix socket을 이용하도록 했다.

**Note : <U>로컬 혹은 개발용으로만 사용</U>하길 바란다. Docker container에서 sshd 사용은 보안 문제로 권장되지 않는다. 게다가 이 이미지는 root 계정 로그인을 허용하고 있으며, 패스워드도 `root`로 설정되어 있다!**  
*Note : XQuartz / nabi 한글 입력은 동작하지 않는다.*

## 1. docker image
`pyqt5-korean.sh pull` 로 이미지를 받거나,
```bash
host:user$ bash ./pyqt5-korean.sh pull
```
Dockerfile 파일로 image를 만든다.
```bash
host:user$ docker build --no-cache --tag coldblaze/pyqt5-korean --file Dockerfile .
```

## 2. container 실행
`pyqt5-korean.sh`을 열어 각 설정값을 확인하고 실행한다 (반드시 bash).
```bash
host:user$ bash ./pyqt5-korean.sh run
```

## 3. 사용
### 2.1 macOS 사용자라면,
macOS에 XQuartz를 brew를 이용해 설치하거나
```bash
macOS:user$ brew install xquartz
```
혹은 https://www.xquartz.org 에서 .dmg를 다운로드, 설치한다.

container에 ssh로 접속한다.
포트 10022는 `pyqt5-korean.sh`에서 설정한 $HOST_PORT 이다.
root 계정의 패스워드는 `root`이다.
```bash
macOS:user$ ssh -Y -C -p 10022 root@localhost
root@localhost's password:
Last login: Thu Mar  7 01:59:26 2019 from 172.17.0.1
root@pyqt5-korean~# env
...
LANG=ko_KR.UTF-8
DISPLAY=pyqt5-korean:10.0
...
```

### 2.2 리눅스 Desktop 사용자라면,
리눅스 데스크탑을 사용하고 있다면 container 쉘에서 바로 GUI를 사용하면 된다.
```bash
linux-desktop:user$ bash pyqt-korean.sh run
root@pyqt5-korean:~# env
...
LANG=ko_KR.UTF-8
DISPLAY=unix:0
...
```

## 4. 테스트
test-korean.py를 마운트 경로에 복사해서 테스트 하거나, 다른 GUI 앱들을 설치하여 테스트한다.
```bash
root:pyqt5-korean /srv # python3 test-korean.py
root:pyqt5-korean /srv # apt-get update
root:pyqt5-korean /srv # apt-get install x11-apps
root:pyqt5-korean /srv # xeyes
```
