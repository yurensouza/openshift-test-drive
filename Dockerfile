FROM quay.io/system_manager_br/ruby-hello-world:v1.0-ubi8r27 
USER default
EXPOSE 8080
COPY . /opt/app-root/src/
CMD bundle exec "rackup -P /tmp/rack.pid --host 0.0.0.0 --port 8080" ; \
    bundle exec ruby app.rb
USER root
RUN chmod og+rw /opt/app-root/src/db
USER default
