FROM 5494070a8c2e
MAINTAINER  ashu singh 

RUN mkdir /webapp
# here i am creating a folder to store my Flask application 
COPY  . /webapp/
WORKDIR /webapp
# changing directory 

# install python Flask framework 
RUN pip3 install -r requirements.txt
# is optional part but you set some default port with container IP 
CMD ["python3","demo.py"]
