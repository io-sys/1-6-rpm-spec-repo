# 01_curl_SSL.sh
# rpm spec +ssl
#
#
# Понадобятся следующие установленные пакеты:
yum install -y \
redhat-lsb-core \
wget \
make \
gcc \
mock \
mc \
vim\
tree \
rpmdevtools \
rpm-build \
createrepo \
yum-utils
#
#
# Версия из repo - curl-7.29.0-51.el7.x86_64
yum provides curl
#
#
# В ~ директории создать каталог /rpmbuild с нужными подкаталогами, они будут пустые.
rpmdev-setuptree
cd ~/rpmbuild/SRPMS/
# Загрузить SRPMS
yumdownloader --source curl-7.29.0
# Достать spec и разархивировать вспомогательные файлы.
rpm -ivh ~/rpmbuild/SRPMS/curl-7.29.0-51.el7.src.rpm
#
#
# OpenSSL загружаю и распаковываю в директории /opt
# Для загрузки OpenSSL отдельная папка
mkdir /usr/src/OpenSSL && cd /usr/src/OpenSSL
wget https://www.openssl.org/source/openssl-1.0.2r.tar.gz
tar -xvf openssl-1.0.2r.tar.gz --directory=/opt/
#
#
# Правится spec curl'а
sed -i.bak01 's@--without-ssl@--with-ssl=/opt/openssl-1.0.2r@' ~/rpmbuild/SPECS/curl.spec
#
# Заранее устанавливаются все зависимости пакета curl
yum-builddep -y ~/rpmbuild/SPECS/curl.spec
# Собирается RPM curl'а с поддержкой SSL
rpmbuild -bb ~/rpmbuild/SPECS/curl.spec


