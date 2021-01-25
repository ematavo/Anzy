---
iso_file:
    path: http://content.example.com/rhel7.3/x86_64/isos/rhel-server-7.3-x86_64-dvd.iso 
    dest: /rhel7.iso
    upload_command: engine-iso-uploader --iso-domain isodomain upload /rhel7.iso -u admin@internal -p redhat -f

idm_config_files:
  - /etc/ovirt-engine/aaa/lab.example.com.jks
  - /etc/ovirt-engine/aaa/lab.example.com.properties 
  - /etc/ovirt-engine/extensions.d/lab.example.com-authz.properties
  - /etc/ovirt-engine/extensions.d/lab.example.com-authn.properties
