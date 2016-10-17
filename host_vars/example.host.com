---
# The variables file used by the playbooks
# These don't have to be explicitly imported by vars_files: they are autopopulated
# NOTE: Copy the "example.host.com" file and replace values with real values.
#       Do not commit the production file to the repository!!!

host_ip: __HOST_IP__
host_admin: __HOST_ADMIN_EMAIL__
host_name:  __HOST_FQDN__

db_name: __DB_NAME__
db_user: __DB_USER__
db_host: __DB_HOST__
db_port: __DB_PORT__
