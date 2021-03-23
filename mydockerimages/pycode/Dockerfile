FROM centos AS mybuilder 
MAINTAINER  ashutoshh
RUN mkdir /code
COPY hello.py  /code/
WORKDIR /code
RUN chmod +x hello.py
# here i am making code executable by permission 
# above process is for only copy and execute permission to code

FROM gcr.io/distroless/python3
COPY --from=mybuilder  /code   /code1
WORKDIR /code1
CMD ["./hello.py"]

