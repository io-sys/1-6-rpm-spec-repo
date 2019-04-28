#### nginx и свой репозиторий
#### tegs: nginx repo
#
# Установка репозитория epel
yum install -y epel-release
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
# Подготавливается web-каталог для репозитория.
rm -f /usr/share/nginx/html/*.png & rm -f /usr/share/nginx/html/*.html
# Создать каталог repodata, в котором будут храниться все метаданные о репозитории.
yum repolist enabled
# Подготавливается web-каталог для репозитория.
rm -f /usr/share/nginx/html/*.png & rm -f /usr/share/nginx/html/*.html
#
# Создать каталог repodata, в котором будут храниться все метаданные о репозитории.
yum repolist enabled
# Копируем пакет в свой репозиторий.
cp ~/rpmbuild/RPMS/x86_64/curl-7.29.0-51.el7.centos.x86_64.rpm /usr/share/nginx/html/     
# Каждый раз, когда добавляются пакеты, надо выполнять команду.
createrepo /usr/share/nginx/html/
# Проверить количество пакетов в репозитории.
yum repolist enabled             
yum search curl
# Включить индексирование файлов
sed -i.bak01 '/^ *location \/ {/a \\t\tautoindex on;' /etc/nginx/nginx.conf
# Проверить синтаксис nginx конфига.
nginx -t
# Перезапустить nginx 
nginx -s reload
#
# Копируется 2'й пакет в свой репозиторий.
cp ~/rpmbuild/RPMS/x86_64/curl-debuginfo-7.29.0-51.el7.centos.x86_64.rpm /usr/share/nginx/html/
# Пересобирается база репозитория, так надо делать после каждого нового изменения в репозитории.
createrepo /usr/share/nginx/html 
# Spawning worker 0 with 2 pkgs
# Workers Finished
# Saving Primary metadata
# Saving file lists metadata
# Saving other metadata
# Generating sqlite DBs
# Sqlite DBs complete
#
# Проверка, что репозиторий заработал.
yum repolist enabled | grep Otus
