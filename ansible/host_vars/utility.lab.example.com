---
exports:
    iso_path: /exports/iso 
    iso_content: '/exports/iso *.lab.example.com(rw)'
    iso_exports_file: /etc/exports.d/iso.exports
    command: exportfs -r

ipa_admin:
    name: admin
    verify_command: ipa user-show admin
    kinit_command: echo redhat321 | kinit admin
    kinit_destroy_command: kdestroy -A
    password: redhat321

ipa_server:
    name: utility.lab.example.com
    ip: 172.25.250.8
    domain: lab.example.com
    realm: LAB.EXAMPLE.COM

ipa_rhvadmin:
    name: rhvadmin
    givenname: rhvadmin
    sn: user
    mail: rhvadmin@example.net
    password: redhat

idm_users:
  - username: normaluser
    givenname: Normal
    sn: user
    mail: normaluser@example.net
    password: redhat
  - username: poweruser
    givenname: Power
    sn: user
    mail: poweruser@example.net
    password: redhat
  - username: dcadmin 
    givenname: DcAdmin
    sn: user
    mail: dcadmin@example.net
    password: redhat

nfs_storage_lab:
  - device: /dev/vde
    label: msdos
    fstype: xfs
    fs_device: /dev/vde1
    path: /exports/data
    export_content: '/exports/data 172.24.0.0/24(rw)'
    exports_file: /etc/exports.d/data.exports
    command: exportfs -r
