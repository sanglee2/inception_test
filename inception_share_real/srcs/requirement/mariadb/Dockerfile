FROM debian:bullseye

# mariadb-client 꼭 설치해야 하는 정당성
RUN apt update -y && \
	apt upgrade -y && \
	apt install mariadb-server mariadb-client -y && \
	apt-get install dumb-init

# COPY tools/cmd.sh /tmp/cmd.sh
# 꼭 /usr/local/bin 밑이 아니여도 된다.
COPY tools/cmd.sh /usr/local/bin/cmd.sh

# 직접 바꿔줄지 죽일지 확인
COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

# RUN chmod +x /tmp/cmd.sh

# RUN service mysql start && chmod +x /tmp/db_setup.sh && mysql -uroot < /tmp/db_setup.sql

# 일단 살려 놓는다. 안에 들어가서 바꾸는 것도 나쁘지 않음.
RUN sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' -i  /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed 's/skip-networking/#skip-networking/g' -i  /etc/mysql/mariadb.conf.d/50-server.cnf 


HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "mysqladmin", "ping" ]

ENTRYPOINT [ "dumb-init", "--"]

CMD sh /usr/local/bin/cmd.sh

# # mariadb dockerfile
# mariadb 이미지 빌드 프로세스를 기술한 파일
# 이미지 빌드 프로세스의 자동화 / 동일한 환경(동일한 이미지) 재현가능 / 이미지 구성 문서화 

# FROM debian:bullseye

# # 패키지 저장소를 업데이트 한다.
# # 업그레이드를 한다.
# # mariadb 서버를 설치한다.
# # 미들웨어 등 환경구축을 위한 명령 - 도커 이미지를 생성할 때 실행됨.
# # RUN [실행하고 싶은 명령어]
# # 현재 설치된 패키지를 최신버전으로 업그레이드 필요?
# RUN apt update -y && \
# 	apt upgrade -y && \
# 	apt install mariadb-server mariadb-client -y && \
# 	apt-get install dumb-init


# # cmd.sh 
# # mariadb의 환경 설정에 대한 것들 기술한 script
# # mariadb 설정파일 위치 관례
# # Q. 오류상황 /usr/local/bin/cmd.sh - 임의 지정 문제 있음 -> 없음. CMD 명령어 조작.
# # COPY healthcheck.sh /usr/local/bin/healthcheck.sh
# # COPY ./tools/cmd.sh ./tools/cmd.sh
# COPY ./tools/cmd.sh /usr/local/bin/cmd.sh

# # Q. 컨테이너 내부 진입 후 바로 꺼지는 문제 해결 필요!
# # Q. 꺼지는 이유, 같이 참고해서, 참고. 참고!
# # sh안에 남겨도 더 좋은이유
# COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# #--- 보류
# # MySQL 서비스를 실행하는 동안 필요한 디렉터리, 빌드 시에 실행되는 명령을 정의
# # 소켓 파일과 같은 실행 중에 필요한 파일 저장.
# # 소켓 디렉토리 생성 및 권한 조정
# # MySQL 서비스를 실행하는 동안 필요한 디렉터리 생성.
# # Q. --> 더 참조해야 할 것! 이 디렉터리는 MySQL 소켓 파일 저장하는 데 사용, 서버가 정상적으로 통신할 수 있게 함.
# RUN mkdir -p /run/mysqld

# # mysqld 에 대한 이해가 더 부족! 부족하지 않나, 부족한게 아닌가..

# # 데몬.
# # 시스템 user
# # 디렉터리의 소유자와 그룹을 변경
# RUN chown mysql:mysql /run/mysqld

# #--- 보류

# # HEALTH_CHECK에 관련한 부분.
# # Docker-Compose.yml로 옮길 것 - setting
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "mysqladmin", "ping" ]

# # 컨테이너 실행 시 무조건 실행해야 하는 명령어
# # dumb-init 프로세스 초기화 관리도구
# ENTRYPOINT [ "dumb-init", "--"]
 
# # 실행하면서 동작시켜야 할 쉘 스크립트.
# # working dir 확인. WORKDIR
# # docker container run 명령어의 인수 지정이 우선시 된다는 뜻. - docker container run 더 파악하기.
# # CMD ["/bin/bash", "/usr/local/bin/cmd.sh"]
# CMD sh /usr/local/bin/cmd.sh




# # 기본 이미지를 설정해주는 부분.
# FROM debian:bullseye

# # mariadb 컨테이너 워킹 디렉토리를 /app으로 적용
# WORKDIR /app

# # 패키지 업데이트 // 패키지 관리 apt update 하기
# RUN apt update

# # 마리아 디비 설치

# # 패키지 관리 apt update하기
# RUN apt-get install mariadb-server -y 

# RUN apt-get install vim -y 

# # 파일 복사
# COPY . .

# # 설정 파일을 전역으로 적용하기
# COPY ./conf/mariadb.conf /etc/app/

# # /tmp 파일이 모든 유저에가 사용할 수 있도록 권한 적용
# RUN chmod 1777 /tmp

# RUN chmod 1777 /app

# # 로그 생성을 위한 파일 만들기 및 권한 설정
# RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# # 사용자 mysql로 설정.
# USER mysql

# # 스크립트 실행 // 컨테이너를 실행하기 위해 필요한 명령어
# CMD ["/bin/sh","./tools/cmd.sh"]

