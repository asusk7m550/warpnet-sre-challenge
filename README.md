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
The machine itself is provisioned by Puppet. The application is copied to the server and installed by a shell script.
Install the correct submodules for the puppet modules by running `git submodule update --init --recursive`
Start the webserver with the command `vagrant up web`

To view the site, find the IP of the server (e.g. `vagrant ssh-config web | sed -n 's/.*HostName \(.*\)/\1/gp'`) and add in to your hostfile (e.g. `<IP> warpnet-sre-challenge.web.localdomain`).

You should be able to view the website on you browser under http://warpnet-sre-challenge.web.localdomain

## Part 2 - Look into the application code and make adjustments that you think are necessary.

Some changes are made. It is possible to use flask_sqlalchemy and flask_login to make some code cleaner.
Also an update on the password, it should not be plaintext in the database and nowhere to be seen.

## Part 3 - Deploy the app on a Kubernetes environment.

The vagrant has has also support for spinning up a kubernetes environment (is k3s, but it still works like k8s).
use the command `vagrant up k8s`
This machine is also provisioned by Puppet. The only think you need is the IP and the kubeconfig to connect to it.

Get the kubeconfig and replace the ip with the ip from the machine
```bash
vagrant ssh k8s -c 'sudo cat /etc/rancher/k3s/k3s.yaml' > kubeconfig
kubectl --kubeconfig kubeconfig config set clusters.default.server https://$(vagrant ssh-config k8s | sed -n 's/.*HostName \(.*\)/\1/gp'):6443
```

To deploy the application on top of this kubernetes environment, use the following steps:
```bash
docker build -t asusk7m550/warpnet-sre-challenge:20240327-1 -f .deploy/k8s/Dockerfile .
docker push asusk7m550/warpnet-sre-challenge:20240327-1
kubectl --kubeconfig kubeconfig apply -f .deploy/k8s/warpnet-sre-challenge.yaml
```

If needed, update the name of the image, so it will reflect the correct container repository

To view the site, find the IP of the server (e.g. `vagrant ssh-config k8s | sed -n 's/.*HostName \(.*\)/\1/gp'`) and add in to your hostfile (e.g. `<IP> warpnet-sre-challenge.k8s.localdomain`).

You should be able to view the website on you browser under http://warpnet-sre-challenge.k8s.localdomain