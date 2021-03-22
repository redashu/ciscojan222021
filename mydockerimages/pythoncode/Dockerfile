FROM centos
# using centos as base docker image where python is not installed
# centos docker image will be download from DockerHUb automatically
MAINTAINER  ashutoshh@linux.com , 9509957594
# is for just help whosoever gonna face any problem in this image
# they can contact me 
RUN yum  install python3  -y
# Installing python3  in centos docker image 
RUN mkdir /mycode 
# creating a directory during image build time
COPY  cisco.py  /mycode/cisco.py
# copy instruction will be used to copy data from 
# docker client to docker engine during image build process 
CMD ["python3","/mycode/cisco.py"]

# IT is default process of contaier from this image
#  is user is not defining any process then it will be the default one 