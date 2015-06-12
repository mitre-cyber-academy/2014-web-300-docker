Name: The Virtual Tour Docker

How to Use:

Install `docker` and `docker-compose`. 

Run `docker-compose build` then `docker-compose up`. After this completes visit `localhost` or when using `boot2docker` run `boot2docker ip` and visit the returned ip.

You will need to run `docker-compose run web bundle exec rake db:create db:setup db:migrate RAILS_ENV=production` after `docker-compose up`.

How to Use Docker in Docker (dind):

About - The Docker in Docker setup is primarly used for deployment on OpenStack to gain container links while using the Docker hypervisor. 

To test:
Clone this repository and `cd dind/` then `docker build .` to build the Docker in Docker image. Tag the image, e.x. `docker tag df66ce2dac87 ctf/dind:v16.1` Then run `docker run --privileged -d -p 8080 -e PORT=8080 ctf/dind:v16.1`. Do not change the port mapping without also changing the iptables command in the start-challenge file and re-building the image.

To deploy:
Save the build Docker in Docker image to glance `docker save ctf/dind:v16.1 | glance image-create --is-public true --container-format docker --disk-format raw --name ctf/dind:v16.1`, `nova boot --image ctf/dind:v16.1`. 
