FROM openjdk 
# official java image 
MAINTAINER ashutoshh@linux.com
RUN mkdir /mydata
COPY hello.java /mydata/hello.java
WORKDIR  /mydata
# changing directory during image build time
# its like cd command in linux / mac
RUN javac hello.java
# to compile java code
# will be triggered only image building time
CMD ["java","myclass"]
# so default parent process is to run java code as className
# CMD will be triggered during container creation time only persistently 
# CMD will tested during build time but it will not in further running state