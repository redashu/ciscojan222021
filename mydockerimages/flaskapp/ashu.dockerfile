FROM common:flasklayer
MAINTAINER  ashutosh@linux.com
RUN apt update
RUN apt install python3 -y
RUN     apt install python3-pip -y 

EXPOSE 5000
# to install flask we need pip3 command 
RUN mkdir /webapp
# here i am creating a folder to store my Flask application 
COPY  . /webapp/
WORKDIR /webapp
# changing directory 

# install python Flask framework 
RUN pip3 install -r requirements.txt
# is optional part but you set some default port with container IP 
CMD ["python3","demo.py"]
