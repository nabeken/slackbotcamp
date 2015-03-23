# slackbotcamp

slackbotcamp is a boilerplate for slackbot execution environment.
It consists of CircleCI, Digital Ocean, Terraform and Chef.

## Setup

### Create DNS zone on digital ocean

Setup DNS zone with reading [How To Set Up a Host Name with DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-host-name-with-digitalocean).

### Setup circle.yml

```
$ cp circle.yml{.sample,}
$ $EDITOR circle.yml
```

Fill `DO_DOMAIN`, `DO_SSH_KEY` and `DO_TOKEN`.
`DO_TOKEN` can be issued from Control Panel.
`DO_SSH_KEY` can be found at `view-source:https://cloud.digitalocean.com/ssh_keys` or API response :(
