# Docker
Here's an example of build a docker image and run a docker environment

In DockerFile, there is everything about what you want to install for your virtual environment.

First run

./docker_build.sh

Then

./docker_run.sh

If everything goes well, you are in the docker container.

You might want to change the name of the docker image.

You could change 

--tag in docker_build.sh

and

image_name in docker_run.sh
