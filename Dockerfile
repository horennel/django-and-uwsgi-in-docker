FROM centos:7

WORKDIR /usr/local

RUN yum -y groupinstall "Development tools" && \
    yum install -y zlib-devel \
        bzip2-devel \
        openssl-devel \
        ncurses-devel \
        sqlite-devel \
        readline-devel \
        tk-devel \
        gdbm-devel \
        db4-devel \
        libpcap-devel \
        mysql-devel \
        gcc gcc-devel \
        python-devel \
        mariadb-devel \
        xz-devel && \
    yum install libffi-devel -y && \
    yum -y install wget && \
    yum clean all && \
    wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz && \
    tar -xvJf  Python-3.8.2.tar.xz && \
    rm -rf Python-3.8.2.tar.xz

WORKDIR /usr/local/Python-3.8.2

RUN ./configure --prefix=/usr/local/python3 && \
    make && make install && \
	rm -rf /usr/local/Python-3.8.2

ENV PATH $PATH:/usr/local/python3/bin

RUN pip3 install django==2.1 && \
    pip3 install mysqlclient && \
    pip3 install uwsgi

WORKDIR /usr/local/django_test

RUN django-admin startproject django_test . && \
    python3 manage.py startapp mytest

ADD start-project.ini /usr/local/start-project.ini

CMD ["uwsgi", "--ini", "/usr/local/start-project.ini"]