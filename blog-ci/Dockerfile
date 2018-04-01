FROM nswebfrog/blog-ci-env 
EXPOSE 80

WORKDIR /opt/blog/
COPY ./build/hook /opt/blog/hook

VOLUME /root/.ssh
VOLUME /opt/blog/sites

CMD ["/opt/blog/hook"]
