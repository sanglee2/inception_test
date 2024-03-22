# Debian bullseye 이미지를 기반으로 합니다.
FROM debian:bullseye

# 패키지 리스트를 업데이트합니다.
RUN apt update -y

# Vim 텍스트 에디터를 설치합니다.
RUN apt install vim -y

# dumb-init을 설치합니다. 
# dumb-init은 컨테이너의 PID 1 문제를 해결하는 간단한 init 시스템으로, 
# 좀비 프로세스를 처리하고 신호를 서브 프로세스에 전달하는 데 사용됩니다.
RUN apt-get install dumb-init

# MariaDB 클라이언트를 설치합니다.
RUN apt install mariadb-client -y

# PHP 관련 패키지를 설치합니다.
# 여기에는 php-fpm, php-cli, php-mysql 등이 포함됩니다. 
RUN apt-get install -y php7.3
RUN apt-get install -y php-fpm
RUN apt-get install -y php-cli
RUN apt-get install -y php-mysql
RUN apt-get install -y php-mbstring
RUN apt-get install -y php-xml
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y sendmail

	# wget \
	# curl \
	# php-mysql \
	# php-mbstring \
	# php-xml \
	# sendmail

# WP-CLI(WordPress CLI)를 다운로드합니다.
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# WP-CLI를 최신 버전으로 업데이트합니다.
# RUN wp cli update

# WordPress 파일을 저장할 디렉토리를 생성합니다.
RUN mkdir -p /var/www/html/wordpress

RUN chown -R  www-data:www-data /var/www/html/wordpress/

RUN mkdir -p /run/php/

# WP-CLI를 사용하여 WordPress 코어 파일을 다운로드합니다.
# RUN wp core download --allow-root --path=/wordpress

# 호스트 시스템의 cmd.sh 스크립트를 컨테이너의 /tools/cmd.sh 경로로 복사합니다.
COPY ./tools/cmd.sh /tools/cmd.sh


# 컨테이너 시작 시 dumb-init을 기본 엔트리포인트로 사용합니다.
ENTRYPOINT [ "dumb-init", "--"]

# cmd.sh 스크립트를 실행합니다. 이 스크립트는 WordPress 설정 및 설치를 자동화합니다.
CMD ["/bin/bash" , "/tools/cmd.sh"]


# # Wordpress dockerfile
# FROM debian:bullseye

# # 패키지 리스트를 업데이트하고 패키지를 최신상태로 업그레이드 하기.
# RUN apt update -y && \
# 	apt upgrade -y
 
# # dumb-init은 컨테이너의 PID 1 문제를 해결하는 간단한 init 시스템으로, 
# # 좀비 프로세스를 처리하고 신호를 서브 프로세스에 전달하는 데 사용.
# RUN apt-get install dumb-init

# # MariaDB 클라이언트 설치
# # Wordpress image에서 해주는 게 맞나?! - 확인하기.
# # PHP 관련 패키지를 설치.
# # 여기에는 php-fpm, php-mysql 등 포함.
# # MySQL 데이터베이스와 상호작용하기 위한 패키지
# # 

# # 워드프레스를 위한 mysql db와 상호작용 php 패키지 설치
# # php 
# # php-fpm 패키지 자체
# # mariadb client 관련 파악.
# RUN apt-get -y install \
# 	php \
# 	php-fpm \
# 	php-mysql \
# 	php-mysqli \
# 	wget \
# 	curl

# # 명령줄 유틸리티인 wp-cli 설치
# # wp-cli 제대로 실행되는지 확인하는 작업
# # 굳이 불필요한 명령줄
# # WP-CLI 실행 파일에 실행 권한 부여.
# # WP-CLI를 /usr/local/bin 디렉토리로 이동하여 시스템 전역.
# # 시스템에서 사용가능한 실행파일 보관하는 곳
# # wp 명령어 이용해 wp-cli 실행할 수 있게 된다?
# # 실행파일 이름을 wp-cli.phar -> wp-cli로 심볼릭 링크로 바꿔버림.

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN php wp-cli.phar --info
# RUN mv wp-cli.phar /usr/local/bin/wp-cli.phar 
# # RUN chmod +x wp-cli.phar
# RUN ln -sf /usr/local/bin/wp-cli.phar /usr/local/bin/wp-cli

# # health_check 들어, 들어가야 하나?

# # WP-CLI를 최신 버전으로 업데이트합니다.
# RUN wp cli update

# # 호스트 시스템의 cmd.sh 스크립트를 컨테이너의 /tools/cmd.sh 경로로 복사합니다.
# COPY ./tools/cmd.sh ./tools/cmd.sh
# #COPY ./tools/cmd.sh /usr/local/bin/cmd.sh

# # 워드프레스 conf 파일
# WORKDIR /var/www/html

# # 컨테이너 시작 시 dumb-init을 기본 엔트리포인트로 사용합니다.
# ENTRYPOINT [ "dumb-init", "--"]

# # cmd.sh 스크립트를 실행합니다. 이 스크립트는 WordPress 설정 및 설치를 자동화합니다.
# #CMD ["/bin/bash" , "./tools/cmd.sh"]
# CMD sh ./tools/cmd.sh
