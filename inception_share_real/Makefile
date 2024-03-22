# Docker-compose.yml location
# 현재 위치 -> 하위 srcs 폴더 -> 아래에 docker-compose.yml 파일위치
# Q.makefile 내에서 전역변수화, 아니면 환경변수 파일 -> 사용하는 게 유리한지 체크하기
COMPOSE_FILE := ./srcs/docker-compose.yml

# 확인할 디렉터리 이름 - data들을 사용할 거니까 data 디렉터리 밑에 묶어서 관리한다
DATA_DIRECTORY_PATH := /home/sangminlee/data

# Make sure the default target is at the top
# all 타켓은 up 타켓을 기본명령으로 한다
all: up

# Define the up process which depends on the build process
up:
# 설정파일 못 찾는 거 방지 
# yml 파일 내용대로 이미지 내려받기 -> 컨테이너 및 네트워크, 볼륨과 같은 주변환경 설정
# @ 실행결과 출력하지 않게 하는 명령어.
# sudo mkdir -p /home/sanglee2/data
# sudo chmod -R 777 /home/sanglee2/data
	@if [ ! -d "${DATA_DIRECTORY_PATH}/wordpress_database" ]; then \
		mkdir -p ${DATA_DIRECTORY_PATH}/wordpress_database; \
	fi
	@if [ ! -d "${DATA_DIRECTORY_PATH}/wordpress_web_file" ]; then \
		mkdir -p ${DATA_DIRECTORY_PATH}/wordpress_web_file; \
	fi
	docker compose -f ${COMPOSE_FILE} up --build -d

# 모든 컨테이너와 네트워크를 정지 시키기
stop :
	docker compose -f ${COMPOSE_FILE} stop

# 컨테이너와 네트워크를 정지 시켰으면 다시 시작하기
start : 
	docker compose -f ${COMPOSE_FILE} start

# 컨테이너와 네트워크를 정지, 삭제
down:
	docker compose -f ${COMPOSE_FILE} down

# Utility command to remove the containers
# 컨테이너, 네트워크, 모든 이미지를 삭제
clean: 
	docker compose -f ${COMPOSE_FILE} down --rmi all

# Utility command to clean everything, removing all containers and volumes
# 모든 볼륨까지 삭제
fclean: 
	make clean
	docker compose -f ${COMPOSE_FILE} down -v --rmi all

# Utility command to rebuild and restart the containers
re: fclean up