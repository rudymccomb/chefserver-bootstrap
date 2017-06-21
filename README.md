# chefserver_bootstrap

TODO: Enter the cookbook description here.

To run alternate kitchen

KITCHEN_YAML=".kitchen.digitalocean.yml"

or

KITCHEN_YAML=".kitchen.circle.yml"

or

export KITCHEN_YAML=.kitchen.digitalocean.yml


To support to DO Kitchen add the following ENV to your .bash_profile
export DIGITALOCEAN_ACCESS_TOKEN=""
export DIGITALOCEAN_SSH_KEY_IDS=""
