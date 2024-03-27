# warpnet-sre-challenge

## Objectives

- Functionality
- Simplicity
- Readability
- Extensibility
- Maintainability
- Observability
- Security

## Part 1 - Deploy the app on a traditional VM.

There is a vagrant file which is able to spin up a virtual machine with nginx.
Use the command `vagrant up web`
The machine itself is provisioned by Puppet. The application is copied to the server and installed by a shell script.

To view the site, find the IP of the server (e.g. `vagrant ssh-config web | sed -n 's/.*HostName \(.*\)/\1/gp'`) and add in to your hostfile (e.g. `<IP> warpnet-sre-challenge.web.localdomain`).

You should be able to view the website on you browser under http://warpnet-sre-challenge.web.localdomain

## Part 2 - Look into the application code and make adjustments that you think are necessary.

TODO

## Part 3 - Deploy the app on a Kubernetes environment.

TODO