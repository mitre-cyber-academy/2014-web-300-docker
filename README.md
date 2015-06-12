Name: The Virtual Tour Docker

How to Use:

Install `docker` and `fig` or `docker-compose`. 

Run `fig build` then `fig up`. After this completes visit `localhost` or when using `boot2docker` run `boot2docker ip` and visit the returned ip.

You may need to run `fig run web bundle exec rake db:create db:setup` and `fig run web bundle exec rake db:migrate` after `fig up`.
