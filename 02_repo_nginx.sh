#### nginx и свой репозиторий
#### tegs: nginx repo
#
# Установка репозитория epel
yum install epel-release
# Установить nginx  
yum install -y nginx
# Запуск nginx
systemctl start nginx
systemctl enable nginx
#
# Создать в директории базу данных репозитория на SQL Lite.
createrepo /usr/share/nginx/html   
# << HERE DOC >
cat << EOF > /etc/yum.repos.d/otus.repo  
[otus] 
name=Otus-Linux 
baseurl=http://10.10.11.18/ 
enabled=l 
gpgcheck=O 
EOF
# 
