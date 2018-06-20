# Instructions on using ansible recipes for the PRIMAVERA DMT

## Overview

The PRIMAVERA DMT application is deployable ons servers using this ansible playbook [Ansible](http://www.ansible.com) as the deployment tool. Note that Ansible version 2.0 or greater is required.

Ansible "recipes", or playbooks, are defined in deploy-dmt.yml and setup-server.yml.

The typical usage for updating the service is:

1. Set up the ssh-agent:

    `exec ssh-agent $SHELL`

2. Add my ssh key (to login to the servers as ROOT):

    `ssh-add ~/.ssh/id_rsa_jasmin`

3. Activate a virtual environment where Ansible is installed:

    `source myvenv/bin/activate`

4. Set your target server using host files in the inventory (test or deployment):

    `export ANSIBLE_HOSTS=$PWD/inventories/deployment-hosts`

5. Run the primary playbook:

    `ansible-playbook deploy-dmt.yml --ask-vault-pass`

If you do not wish to set an environment variable, the inventory file can be specified dynamically:

    ansible-playbook -i inventories/deployment-hosts deploy-dmt.yml

Note that, by default, on the production server this playbook will fetch the latest tagged version
of the tool. It is possible to manually specify a version of the git repository to deploy from.
The command below will download and install the most up to date version from master (default for the test host):

    ansible-playbook deploy-dmt.yml --extra-vars version=HEAD

This parameter will also accept tag and branch names.

    ansible-playbook deploy-dmt.yml --extra-vars version=mybranch

Any variables specified within extra-vars will have precedence over variables found elsewhere in the playbooks.

## Sensitive information - not in GIT

I couldn't get Git to work with a username and password. Instead I've created an extra SSH key
and uploaded the public key to Github. I have then added the private key to `ansible vault`:

    ansible-vault encrypt /path/to/local/private_key

## Important - you can wipe out the production service!

The production service can be overwritten by these recipes. Please make sure you know what you are doing before running it. 

## Structure of playbooks

Refer to the [Ansible Best Practice Guide](http://docs.ansible.com/ansible/playbooks_best_practices.html)
and Ansible documentation for more a detailed explanation of the structure of Ansible projects.

## Installing Ansible

Ansible was easy to install in a python virtualenv. I just did:

    virtualenv-2.7 venv
    . venv/bin/activate
    pip install ansible
 
