# 베이스 이미지로 Debian Bullseye 사용 #Debian 11버전. #준비된 이미지 사용불가 FROM으로 할 수 없음.
FROM debian:bullseye

# 시스템 업데이트
RUN apt update -y

# Vim 편집기 설치
RUN apt install vim -y

# dumb-init 설치. 이는 컨테이너의 PID 1 문제를 해결하고 신호를 제대로 처리하는데 도움을 줌
RUN apt-get install dumb-init

# Nginx 웹 서버 설치
RUN apt install -y nginx

# OpenSSL 설치. SSL/TLS 인증서 생성 및 관리에 사용
RUN apt install -y openssl

# 자체 서명된 SSL 인증서 생성
# 이 인증서는 예시 목적으로 사용되며, 실제 운영 환경에서는 신뢰할 수 있는 CA에서 발급받은 인증서 사용을 권장함
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=who_42/OU=Web Security/CN=example.com"

# 호스트 시스템에서 컨테이너 내부로 파일 복사
COPY ./tools/cmd.sh /tools/cmd.sh
COPY ./tools/nginx.conf /etc/nginx/nginx.conf

# 복사된 스크립트 파일 실행 권한 부여
RUN chmod +x /tools/cmd.sh


# 컨테이너 시작 시 dumb-init 사용
ENTRYPOINT [ "dumb-init", "--", "/tools/cmd.sh"]

# 기본 커맨드 설정. 복사된 스크립트 실행
CMD ["nginx", "-g", "daemon off;"]