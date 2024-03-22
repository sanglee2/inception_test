#!/bin/bash

if [ ! -d /run/mysqld ]
then

    # db 초기화, 설정코드?
    # 데이터베이스 시스템 초기화, 시스템 테이블 생성
    # 데이터 디렉터리 초기화
    # 꼭 root여야 하나?
    # mysql_install_db의 심볼릭 링크인 유틸리티
    # datadir 위치. /var/lib/mysql로 바꿀지
    # MySQL 서비스를 실행하는 동안 필요한 디렉터리, 빌드 시에 실행되는 명령을 정의
    # 소켓 파일과 같은 실행 중에 필요한 파일 저장.
    # 소켓 디렉토리 생성 및 권한 조정
    # MySQL 서비스를 실행하는 동안 필요한 디렉터리 생성.
    # Q. --> 더 참조해야 할 것! 이 디렉터리는 MySQL 소켓 파일 저장하는 데 사용, 서버가 정상적으로 통신할 수 있게 함.
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld

	# 어떻게 필요한지 의심이 가는 부분.
    # 어떻게 필요한지 더 확실한 증명.
	# chown -R mysql:mysql /var/lib/mysql

	#꼭 mysql_install_db로 할 것.
    # basedir 충돌이 발생할 수 도 있어서 그렇게.
    # mysql_install_db -> 심볼릭 링크
	mariadb-install-db --basedir=/usr --datadir=/home/sangminlee/data/wordpress_database #initializes database
    # mariadb-install-db --user=root --datadir=/var/lib/mysql

    # mysql 클라이언트 이용해 쿼리문 실행
    # mysaladmin 쿼리문
    # 쿼리문의 나열

    # %는 모든 ip주소
    # 나머지는 localhost

    # 데이터베이스 생성
    # 데이터 베이스 유저생성 (사용자가 접속 하는 호스트)
    # 어떤 IP 주소를 사용하여 접속하든 상관없이 모든 호스트로부터의 접속을 허용
    # 이 사용자는 로컬 시스템에서만 접속할 수 있음. -> 위에 꺼만 있으면 안되는 건가? / 구분 안 되어도 괜찮은 건가?
    # MARIADB_DB_NAME이름 이라는 DB에만 접속 권한 주기 
    # root의 암호 변경.
    # root는 어떤 IP 주소 사용하여 접속 x?
    # 권한 설정 적용

# 쿼리문 확장자
cat << EOF > db_config.sql
    FLUSH PRIVILEGES;
	CREATE DATABASE IF NOT EXISTS $MARIADB_DB_NAME;
	CREATE USER IF NOT EXISTS '$MARIADB_DB_USER'@'%' IDENTIFIED BY '$MARIADB_DB_USER_PASSWD';
	CREATE USER IF NOT EXISTS '$MARIADB_DB_USER'@'localhost' IDENTIFIED BY '$MARIADB_DB_USER_PASSWD';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWD' ;
	GRANT ALL PRIVILEGES ON $MARIADB_DB_NAME.* TO '$MARIADB_DB_USER'@'%' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
EOF

# db 서버를 부트스트랩모드를 써서 데이터베이스 초기화 및 사용자 설정 같은 설정파일 읽기
# 입력으로 사용할 sql 파일 명시
# mysql_install_db --user=mysql --bootstrap < db_config.sql ## 안 먹히는 명령어 확인!
mysqld --user=mysql --bootstrap < db_config.sql

fi

# 여기 쉘 스크립트에서 처리해주는 것이 맞냐 안 맞냐 고민이 되는 설정. 설정들.
# sed -i "s/skip-networking/# skip-networking/g" /etc/mysql/mariadb.conf.d/50-server.cnf 
# sed -i "s/.*bind-address\s*=.*/bind-address=0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf 


# 데이터베이스 서버가 항상 실행되도록 설정
# 새로운 프로세스로 대체하는 셸 내장 명령어
# 이 명령어는 새로운 프로세스가 실행될 때 기존의 프로세스가 종료
# 이 스크립트는 데이터베이스 서버를 안전하게 시작하고 필요한 경우 재시작하는 역할
# 일반적으로 이러한 명령어는 시스템 부팅 시 자동으로 실행되도록 설정되어 데이터베이스 서버가 항상 실행 되도록 함.
exec /usr/bin/mysqld_safe --user=mysql

# exec mysqld --user=mysql --console #starts database server in foreground


# mysql -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DB_NAME ;"
# mysql -e "CREATE USER IF NOT EXISTS '$MARIADB_DB_USER'@'%' IDENTIFIED BY '$MARIADB_DB_USER_PASSWD';"
# mysql -e "CREATE USER IF NOT EXISTS '$MARIADB_DB_USER'@'localhost' IDENTIFIED BY '$MARIADB_DB_USER_PASSWD';"
# mysql -e "GRANT ALL PRIVILEGES ON $MARIADB_DB_NAME.* TO '$MARIADB_DB_USER'@'%' ;" 
# mysql -e "GRANT ALL PRIVILEGES ON $MARIADB_DB_NAME.* TO '$MARIADB_DB_USER'@'localhost' ;"
# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASSWD';"
# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWD';"  
# # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" 
# mysql -e "FLUSH PRIVILEGES;" 

    # mysql conf파일 bindadress 재설정 - 해결
    # 데이터베이스 설정 적용, 쿼리문 일시 적용.

    # mysql -u root -p"${root_pwd}"

    # # mysqld 백그라운드 실행, 백그라운드에서 데몬 실행
    # mysqld -u root --datadir=${db_path} &
    # sleep 3

    # # MariaDB root로 종료하기 -u 사용자 이름, 비밀번호 직접 입력하는 대신 해당 옵션주기.
    # mysqladmin -u root --password=$root_pwd shutdown
    # sleep 3

    # echo "데이터베이스를 초기화 했습니다."
# else
    # echo "데이터베이스는 이미 초기화 되었습니다."
# fi


# exec /usr/bin/mysqld_safe --user=mysql

# Restart mysql
# mysqld --datadir=/var/lib/mysql -u root

# #!/bin/bash

# # 임시 SQL 파일 생성 및 쓰기 권한 부여
# touch setting_db.sql && chmod +w setting_db.sql

# # SQL 명령 작성
# echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" > setting_db.sql
# echo "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;" >> setting_db.sql
# echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" >> setting_db.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> setting_db.sql
# echo "FLUSH PRIVILEGES;" >> setting_db.sql

# # MySQL 클라이언트를 사용하여 SQL 파일 실행
# mysqld &

# # Say start
# echo "Iserting database..."

# # Wait mariadb start
# sleep 3

# # Insert script for setting mariadb
# mysql  < setting_db.sql

# # kill background process
# kill $(ps aux | grep mysqld | grep -v grep | awk '{print $2}')

# # Start Mariadb
# mysqld

# # Say service start
# echo "✅ Mariadb setting Done."