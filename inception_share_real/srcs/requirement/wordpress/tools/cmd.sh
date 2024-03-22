#! /bin/bash

# MySQL 서버가 시작되기를 기다립니다.
# MySQL 서버가 완전히 시작되고 준비될 때까지 대기합니다.
sleep 20

# WordPress 디렉토리로 이동합니다.
cd /var/www/html/wordpress


# mkdir -p /run/php


wp core download --allow-root --path=/var/www/html/wordpress

# WP-CLI를 사용하여 wp-config.php 파일을 생성합니다.
# 이 과정에서 데이터베이스 이름, 사용자, 비밀번호 및 호스트 정보를 환경변수에서 가져옵니다.
wp config create --allow-root --dbname=$MARIADB_DB_NAME --dbuser=$MARIADB_DB_USER --dbpass=$MARIADB_DB_USER_PASSWD --dbhost=$MARIADB_HOST_NAME:3306 --path=/var/www/html/wordpress

# WordPress 사이트를 설치합니다.
# 이 때 사이트 URL, 제목, 관리자 사용자 이름, 비밀번호, 이메일 등을 환경변수에서 가져옵니다.
wp core install --allow-root --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_NAME --admin_password=$WORDPRESS_ADMIN_PASSWD --admin_email=$WORDPRESS_ADMIN_EMAIL --path=/var/www/html/wordpress

# 새로운 WordPress 사용자를 생성합니다.
# 이 사용자는 작성자(author) 역할을 가지며, 사용자 이름, 이메일, 비밀번호는 환경변수에서 가져옵니다.
wp user create --allow-root $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWD --role=author --path=/var/www/html/wordpress

# PHP-FPM의 설정 파일을 수정합니다.
# 기존의 UNIX 소켓 대신 0.0.0.0:9000 포트를 통해 리스닝하도록 변경합니다.
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf


# 지워, 지워줘야 할 부분! 부분들!
echo 11111111111
# sleep 1000000

# 변경된 설정을 적용하기 위해 PHP-FPM 서비스를 시작합니다.
# service php7.4-fpm start

# 이 명령은 컨테이너가 바로 종료되지 않도록 로그 파일을 계속 출력합니다.
# 컨테이너가 백그라운드 작업을 계속 유지하려는 경우에 사용됩니다.
php-fpm7.4 --nodaemonize










# #! /bin/bash

# # MySQL 서버가 시작되기를 기다립니다.
# # MySQL 서버가 완전히 시작되고 준비될 때까지 대기합니다.
# # HealthCheck 용으로 변환하기.

# # WordPress를 설치할 디렉터리 경로를 지정해준다.
# # 지정하지 않으면, 현재 디렉터리에 설치하는데 굳이 필요할까?
# # mkdir -p /var/www/html/wordpress

# # WP-CLI를 사용하여 WordPress의 코어 파일을 다운로드.
# # --allow-root 사용자 꼭 필요한가 -> 이런 옵션이 있었어?
# # 동적파일을 띄우기 위해 필요한 디렉터리 - 나중에 volume과 연결
# # path에 호스트의 볼륨 경로 적어도 되나?
# # wp-cli core download --allow-root --path=/var/www/html/wordpress

# wp cli update --yes --allow-root


# wp core download --allow-root --path=/var/www/html/

# # wordpress가 설치된 디렉터리로 이동
# cd /var/www/html/wordpress

# # wp-cli로  wp-config.php 파일 생성 및 수정
# # 데이터베이스 이름, 사용자, 비밀번호, 호스트 정보 환경변수에서 가져옴.
# # wp-cli config create --allow-root --dbname=$MARIA_DB_NAME --dbuser=$MARIA_DB_USER --dbpass=$db1_pwd --dbhost=$db_host
# # dbhost 호스트이름에 대해서 더 명확히 알기 - 알아보기!(수정)
# wp config create --allow-root --dbname=$MARIADB_DB_NAME --dbuser=$MARIADB_DB_USER --dbpass=$MARIADB_DB_USER_PASSWD --dbhost=$MARIADB_HOST_NAME:3306 --path=/var/www/html/

# # 없어도 되는 명령어인지 체크하기
# # wp-cli db create

# # 세부정보 변경
# # URL, 제목, 관리자 사용자 이름, 비밀번호, 이메일 등을 환경변수에서 가져옵니다.
# wp core install --allow-root --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_NAME --admin_password=$WORDPRESS_ADMIN_PASSWD --admin_email=$WORDPRESS_ADMIN_EMAIL --path=/var/www/html

# # 과제에서 요구하는 wordpress user 추가 (기본설정은 아님)
# # 이 사용자는 작성자(author) 역할을 가지며, 사용자 이름, 이메일, 비밀번호는 환경변수에서 가져옴.
# # 기본역할 작성자/편집자/관리자/기여자/구독자 중 댓글등을 바꿀 수 있는 권한(?)을 가진 작성자로 설정.
# wp user create --allow-root $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWD --role=author --path=/var/www/html/

# # 이 명령어가 들어가더라도 괜찮은 것이냐
# # RUN sed 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|g' -i /etc/php/7.3/fpm/pool.d/www.conf
# # RUN mkdir -p /run/php

# # PHP-FPM 설정파일 수정.
# # 기존의 UNIX 소켓 대신 0.0.0.0:9000 포트를 통해 리스닝하도록 변경합니다.
# # sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# # 변경된 설정을 적용하기 위해 PHP-FPM 서비스를 시작합니다.
# # service php-fpm start

# # 이 명령은 컨테이너가 바로 종료되지 않도록 로그 파일을 계속 출력합니다.
# # 컨테이너가 백그라운드 작업을 계속 유지하려는 경우에 사용됩니다.
# # 이 명령 사용하지 않으라 했는데 없어도 문제 없는지 체크
# # tail -f /dev/null

# php-fpm7.4 --nodaemonize

# # if [ ! -d "$directory" ]; then
# #     echo "디렉터리가 존재하지 않습니다. 디렉터리를 생성합니다."
# #     mkdir -p "$directory"
# #     echo "디렉터리가 생성되었습니다."
# # else
# #     echo "디렉터리가 이미 존재합니다."
# # fi