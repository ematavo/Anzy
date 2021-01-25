---
rhvm_auth:
  hostname: rhvm.lab.example.com
  username: admin@internal
  password: redhat
  ca_file: /etc/pki/tls/certs/rhvm-ca.pem

rhvm_auth_dcadmin:
  hostname: rhvm.lab.example.com
  username: dcadmin@lab.example.com
  password: redhat
  ca_file: /etc/pki/tls/certs/rhvm-ca.pem

dc_default:
  - name: Default
    description: ""
    compatibility_version: 4.3

dc_ge:
  - name: development
    description: ""
    compatibility_version: 4.3

dc_lab:
  - name: production
    description: ""
    compatibility_version: 4.3

mac_pool_ge:
  - name: mac-pool-clusterone
    pool:
      - "56:6f:07:a7:0a:01,56:6f:07:a7:0a:0a"
    macs:
      mac_0a01: 172.25.10.1
      mac_0a02: 172.25.10.2
      mac_0a03: 172.25.10.3
      mac_0a04: 172.25.10.4
      mac_0a05: 172.25.10.5
      mac_0a06: 172.25.10.6
      mac_0a07: 172.25.10.7
      mac_0a08: 172.25.10.8
      mac_0a09: 172.25.10.9
      mac_0a0a: 172.25.10.10

mac_pool_lab:
  - name: mac-pool-clustertwo
    pool:
      - "56:6f:07:a7:14:01,56:6f:07:a7:14:0a"
    macs:
      mac_1401: 172.25.20.1
      mac_1402: 172.25.20.2
      mac_1403: 172.25.20.3
      mac_1404: 172.25.20.4
      mac_1405: 172.25.20.5
      mac_1406: 172.25.20.6
      mac_1407: 172.25.20.7
      mac_1408: 172.25.20.8
      mac_1409: 172.25.20.9
      mac_140a: 172.25.20.10

mac_pool_cr:
  - name: mac-pool-cluster1
    pool:
      - "56:6f:07:a7:0a:01,56:6f:07:a7:0a:0a"
    macs:
      mac_0a01: 172.25.10.1
      mac_0a02: 172.25.10.2
      mac_0a03: 172.25.10.3
      mac_0a04: 172.25.10.4
      mac_0a05: 172.25.10.5
      mac_0a06: 172.25.10.6
      mac_0a07: 172.25.10.7
      mac_0a08: 172.25.10.8
      mac_0a09: 172.25.10.9
      mac_0a0a: 172.25.10.10

cluster_ge:
  - name: clusterone
    data_center: "{{ dc_ge[0]['name'] }}"
    cpu_arch: x86_64
    cpu_type: Intel Westmere IBRS SSBD MDS Family
    compatibility_version: 4.3
    mac_pool:
      name: mac-pool-clusterone
      pool:
        - "56:6f:07:a7:0a:01,56:6f:07:a7:0a:0a"
      macs:
        mac_0a01: 172.25.10.1
        mac_0a02: 172.25.10.2
        mac_0a03: 172.25.10.3
        mac_0a04: 172.25.10.4
        mac_0a05: 172.25.10.5
        mac_0a06: 172.25.10.6
        mac_0a07: 172.25.10.7
        mac_0a08: 172.25.10.8
        mac_0a09: 172.25.10.9
        mac_0a0a: 172.25.10.10
    scheduling_policy: vm_evenly_distributed
    HighVmCount: "2"
    SpmVmGrace: "0"
    MigrationThreshold: "2"

cluster_lab:
  - name: clustertwo
    data_center: "{{ dc_lab[0]['name'] }}"
    cpu_arch: x86_64
    cpu_type: Intel Westmere IBRS SSBD MDS Family
    compatibility_version: 4.3
    mac_pool:
      name: mac-pool-clustertwo
      pool:
        - "56:6f:07:a7:14:01,56:6f:07:a7:14:0a"
      macs:
        mac_1401: 172.25.20.1
        mac_1402: 172.25.20.2
        mac_1403: 172.25.20.3
        mac_1404: 172.25.20.4
        mac_1405: 172.25.20.5
        mac_1406: 172.25.20.6
        mac_1407: 172.25.20.7
        mac_1408: 172.25.20.8
        mac_1409: 172.25.20.9
        mac_140a: 172.25.20.10

managed_users_ge:
  - rhvadmin
  - normaluser
  - poweruser
  - dcadmin

managed_users_roles_ge:
  - user_name: rhvadmin
    object_type: system
    role: SuperUser
  - user_name: normaluser
    object_type: system
    role: UserRole
  - user_name: poweruser
    object_type: system
    role: PowerUserRole

managed_users_dcadmin_role_ge:
  - user_name: dcadmin
    object_type: data_center
    object_name: "{{ dc_ge[0]['name'] }}"
    role: DataCenterAdmin

managed_users_lab:
  - user_name: labadmin
    object_type: system
    object_name: ""
    role: SuperUser
  - user_name: labdcadmin
    object_type: data_center
    object_name: "Default"
    role: DataCenterAdmin
  - user_name: labpoweruser
    object_type: data_center
    object_name: "Default"
    role: PowerUserRole
  - user_name: labnormaluser
    object_type: data_center
    object_name: "Default"
    role: UserRole

iso_ge:
    name: isodomain
    data_center: default
    domain_function: iso
    host: serverb.lab.example.com
    nfs_address: 172.25.250.8
    nfs_path: /exports/iso

vm_ge:
  - name: rhel-vm1
    nw_name: rhel-vm1-nic

ovirt_user:
  - rhvadmin

managed_user_rhvadmin:
  - user_name: rhvadmin
    object_type: system
    object_name: ""
    role: SuperUser

install_storage_ge:
  - name: rhel-8.0-x86_64-boot.iso
    description: rhel-8.0-x86_64-boot.iso
    content_url: http://materials.example.com/rhel-8.0-x86_64-boot.iso
    upload_image_path: /home/student/Downloads/rhel-8.0-x86_64-boot.iso
    storage_domain: hosted_storage
    wait_boolean: "{{ item.wait_boolean | default('true') }}"
    bootable: "{{ item.bootable | default('true') }}"
    format: raw
    size: 1GiB
    content_type: iso

rhel7_boot_iso:
  - name: rhel-server-7.6-x86_64-boot.iso
    description: rhel-server-7.6-x86_64-boot.iso
    content_url: http://materials.example.com/rhel-server-7.6-x86_64-boot.iso
    upload_image_path: /home/student/Downloads/rhel-server-7.6-x86_64-boot.iso
    wait_boolean: "{{ item.wait_boolean | default('true') }}"
    bootable: "{{ item.bootable | default('true') }}"
    format: raw
    size: 1GiB
    content_type: iso

rhel8_disk:
  url: http://materials.example.com/rhel-8.0-lab.qcow2 
  dest: /home/student/Downloads/rhel-8.0-lab.qcow2 
  name: rhel8-lab

dc_edit_ge:
  name: development
  description: dcadmin example
  compatibility_version: 4.3

idm_users_lab:
  - username: labadmin
    givenname: labadmin
    sn: user
    mail: labadmin@example.net
    password: redhat
  - username: labnormaluser
    givenname: LabNormal
    sn: user
    mail: labnormaluser@example.net
    password: redhat
  - username: labpoweruser
    givenname: LabPower
    sn: user
    mail: labpoweruser@example.net
    password: redhat
  - username: labdcadmin
    givenname: LabDcAdmin
    sn: user
    mail: dcadmin@example.net
    password: redhat

rhel8_qcow:
  - name: rhel8-lab
    description: rhel8-lab
    content_url: http://materials.example.com/rhel-8.0-lab.qcow2
    upload_image_path: /home/student/Downloads/rhel-8.0-lab.qcow2
    storage_domain: hosted_storage
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 10GiB
    content_type: data

rhel8_sealed_qcow:
  - name: rhel8-sealed
    description: rhel8-sealed
    content_url: http://materials.example.com/rhel8-minimal-sealed.qcow2
    upload_image_path: /home/student/Downloads/rhel8-minimal-sealed.qcow2
    #storage_domain: iscsi-data
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 3GiB
    content_type: data

rhel7_sealed_qcow:
  - name: rhel7-sealed
    description: rhel7-sealed
    content_url: http://materials.example.com/rhel7-minimal-sealed.qcow2
    upload_image_path: /home/student/Downloads/rhel7-minimal-sealed.qcow2
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 3GiB
    content_type: data

rhel7_sealed_qcow_lab:
  - name: rhel7-sealed-lab
    description: rhel7-sealed
    content_url: http://materials.example.com/rhel7-minimal-sealed.qcow2
    upload_image_path: /home/student/Downloads/rhel7-minimal-sealed.qcow2
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 3GiB
    content_type: data

rhel7_sealed_qcow_cr:
  - name: rhel7-sealed-cr
    description: rhel7-sealed
    content_url: http://materials.example.com/rhel7-minimal-sealed.qcow2
    upload_image_path: /home/student/Downloads/rhel7-minimal-sealed.qcow2
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 3GiB
    content_type: data

rhel_lab_test:
  - cluster: Default
    vm_name: rhel-lab-test
    vm_description: ""
    vm_comment: ""
    vm_disks:
      - name: "{{ rhel8_qcow[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: ovirtmgmt
    vm_operating_system: rhel_8x64
    vm_type: server

class_temp_vm:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: class-temp-vm
    vm_description: "Temporary VM for creating a Template"
    vm_comment: ""
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    vm_disks:
      - name: "{{ rhel7_sealed_qcow[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

class_temp_vm_lab:
  - cluster: "{{ cluster_lab[0]['name'] }}"
    vm_name: class-temp-vm
    vm_description: "Temporary VM for creating a Template"
    vm_comment: ""
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    vm_disks:
      - name: "{{ rhel7_sealed_qcow_lab[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_lab[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel_cloud_vm:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-cloud-vm

rhel_lab_vm:
  - cluster: "{{ cluster_lab[0]['name'] }}"
    vm_name: rhel-lab-vm
    vm_fqdn: rhel-lab-vm
    vm_description: ""
    vm_comment: ""
    memory: 1GiB
    test_memory: 1.00 GB
    vm_disks:
      - name: rhel7-cloud-lab
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_lab[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server
    ssh_user: labuser
    ssh_pass: redhat

motd_ch08:
  file: /etc/motd
  file_content: This VM has been provisioned using cloud-init.

motd_ch10:
  file: /etc/motd
  file_content: ""

class_template:
  - name: class-template
    cluster: "{{ cluster_ge[0]['name'] }}"
    description: RHEL 7.6 Template Used by lab scripts
    seal: false
    vm: "{{ class_temp_vm[0]['vm_name'] }}"

class_template_lab:
  - name: class-template-lab
    cluster: "{{ cluster_lab[0]['name'] }}"
    description: RHEL 7.6 Template Used by lab scripts
    seal: false
    vm: "{{ class_temp_vm_lab[0]['vm_name'] }}"

rhel_template:
  - name: rhel-template
    cluster: "{{ cluster_ge[0]['name'] }}"

cloud_lab_template:
  - name: cloud-lab-template
    cluster: "{{ cluster_lab[0]['name'] }}"
    description: cloud-init based template

cloud_template:
  - name: rhel-cloud-template
    cluster: "{{ cluster_ge[0]['name'] }}"
    description: cloud-init based template
    seal: true
    vm: "{{ class_temp_vm[0]['vm_name'] }}"

rhel_vm1:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm1
    vm_description: "RHEL Guest using {{ dc_ge[0]['name'] }} data center"
    vm_comment: ""
    template: class_template
    memory: 2GiB
    test_memory: 2.00 GB
    clone: true
    vm_disks:
      - name: rhel-vm1_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 2
    ballooning_enabled: true
    vm_type: server

rhel_vm1_modified:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm1
    vm_description: "RHEL Guest using {{ dc_ge[0]['name'] }} data center"
    vm_comment: ""
    template: class_template
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    clone: true
    vm_disks:
      - name: rhel-vm1_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel_vm1_lab:
  - cluster: "{{ cluster_lab[0]['name'] }}"
    vm_name: rhel-vm1
    vm_description: "RHEL Guest using {{ dc_lab[0]['name'] }} data center"
    vm_comment: ""
    template: class_template_lab
    memory: 1GiB
    test_memory: 1.00 GB
    clone: true
    vm_disks:
      - name: rhel-vm1_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_lab[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel_vm2:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm2
    vm_description: "RHEL Guest from a template"
    vm_comment: ""
    template: class_template
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    clone: true
    vm_disks:
      - name: rhel-vm2_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel_vm3:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm3
    vm_description: "RHEL Guest from a template"
    vm_comment: ""
    template: class_template
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    clone: true
    vm_disks:
      - name: rhel-vm3_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel_vm4:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm4
    vm_description: "RHEL Guest from a template"
    vm_comment: ""
    template: class_template
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    clone: true
    vm_disks:
      - name: rhel-vm4_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel_test:
  - cluster: Default
    vm_name: rhel-test

logical_network_ge:
  - name: vm-net
    data_center: "{{ dc_ge[0]['name'] }}"
    description: VM Network
    comment: Network for VM Traffic
    vlan_tag: 10
    vm_network: true
    clusters:
      - name: "{{ cluster_ge[0]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false
  - name: storage-net
    data_center: "{{ dc_ge[0]['name'] }}"
    description: Storage Network
    comment: Network for storage traffic
    vm_network: false
    clusters:
      - name: "{{ cluster_ge[0]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false

logical_network_lab:
  - name: prod-vm-net
    data_center: "{{ dc_lab[0]['name'] }}"
    description: VM LAB Network
    comment: Network for VM LAB Traffic
    vlan_tag: 20
    vm_network: true
    clusters:
      - name: "{{ cluster_lab[0]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false
  - name: prod-storage
    data_center: "{{ dc_lab[0]['name'] }}"
    description: Storage Network LAB
    comment: Network for LAB storage traffic
    vm_network: false
    clusters:
      - name: "{{ cluster_lab[0]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false

hostb_default:
  - name: hostb.lab.example.com
    shortname: hostb
    cluster: Default
    address: hostb.lab.example.com

hostb_ge:
  - name: hostb.lab.example.com
    shortname: hostb
    cluster: "{{ cluster_ge[0]['name'] }}"
    address: hostb.lab.example.com
    initial_version: 4.30
    updated_version: 4.31
    initial_vdsm_version: vdsm-4.30.13-4.el7ev
    updated_vdsm_version: vdsm-4.31.13-4.el7ev

hostc_default:
  - name: hostc.lab.example.com
    shortname: hostc
    cluster: Default
    address: hostc.lab.example.com

hostc_lab:
  - name: hostc.lab.example.com
    shortname: hostc
    cluster: "{{ cluster_lab[0]['name'] }}"
    address: hostc.lab.example.com
    initial_vdsm_version: vdsm-4.30.13-4.el7ev
    upgraded_vdsm_version: vdsm-4.30.24-2.el7ev

hostb_nics_ge:
  - name: hostb.lab.example.com
    interface: eth0
    networks:
      - name: "{{ logical_network_ge[0]['name'] }}"
        boot_protocol: dhcp
        version: v4
    sync_networks: true
    check: true
  - name: hostb.lab.example.com
    interface: eth1
    networks:
      - name: "{{ logical_network_ge[1]['name'] }}"
        boot_protocol: static
        address: 172.24.0.11
        netmask: 255.255.255.0
    sync_networks: true
    check: true

hostc_nics_lab:
  - name: hostc.lab.example.com
    interface: eth0
    networks:
      - name: "{{ logical_network_lab[0]['name'] }}"
        boot_protocol: dhcp
        version: v4
    sync_networks: true
    check: true
  - name: hostc.lab.example.com
    interface: eth1
    networks:
      - name: "{{ logical_network_lab[1]['name'] }}"
        boot_protocol: static
        address: 172.24.0.12
        netmask: 255.255.255.0
    sync_networks: true
    check: true

iscsi_storage_add:
  - name: "iscsi-data"
    host: "hostb.lab.example.com"
    data_center: "{{ dc_ge[0]['name'] }}"
    iscsi_lun:
      target: "iqn.2019-07.com.example.lab:utility"
      lun_id:
       - "{{ my_iscsi_lun_id_register.my_iscsi_lun_id.msg }}"
      address: "172.24.0.8"

iscsi_storage_remove:
  - name: "iscsi-data"
    data_center: "{{ dc_ge[0]['name'] }}"

nfs_storage_lab:
  - name: nfs-data
    data_center: "{{ dc_lab[0]['name'] }}"
    host: hostc.lab.example.com
    description: ""
    domain_function: data
    domain_type: nfs
    nfs:
      address: 172.24.0.8
      path: /exports/data

nfs_storage_ge:
  - name: nfs-move
    data_center: "{{ dc_ge[0]['name'] }}"
    host: hostb.lab.example.com
    description: ""
    nfs:
      address: 172.24.0.8
      path: /exports/data2

nfs_storage_move:
  - name: nfs-move
    data_center: "{{ dc_default[0]['name'] }}"
    host: hostd.lab.example.com
    description: ""
    nfs:
      address: 172.24.0.8
      path: /exports/data2

nfs_storage_extra:
  - name: nfs-move
    data_center: "{{ dc_lab[0]['name'] }}"
    host: hostc.lab.example.com
    description: ""
    nfs:
      address: 172.24.0.8
      path: /exports/data2

rhel_test_ch04s06:
  - cluster: Default
    name: rhel-test
    nw_name: rhel-vm1-nic

rhel_vm1_modified_ch09S02:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm1
    vm_description: "RHEL Guest using {{ dc_ge[0]['name'] }} data center"
    vm_comment: ""
    #template: class_template
    template: Blank
    memory: 1GiB
    test_memory: 512MiB
    clone: true
    vm_disks:
      - name: "{{ rhel7_sealed_qcow_vm1[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

hostd_default:
  - name: hostd.lab.example.com
    shortname: hostd
    cluster: Default
    address: hostd.lab.example.com

hostd_ge:
  - name: hostd.lab.example.com
    shortname: hostd
    cluster: "{{ cluster_ge[0]['name'] }}"
    address: hostd.lab.example.com
    initial_vdsm_version: vdsm-4.30.13-4.el7ev
    upgraded_vdsm_version: vdsm-4.30.24-2.el7ev

hostd_default_nics_ge:
  - name: hostd.lab.example.com
    interface: eth0
    networks:
      - name: ovirtmgmt 
        boot_protocol: dhcp
        version: v4
    sync_networks: true
    check: true

hostd_nics_ge:
  - name: hostd.lab.example.com
    interface: eth0
    networks:
      - name: "{{ logical_network_ge[0]['name'] }}"
        boot_protocol: dhcp
        version: v4
    sync_networks: true
    check: true
  - name: hostd.lab.example.com
    interface: eth1
    networks:
      - name: "{{ logical_network_ge[1]['name'] }}"
        boot_protocol: static
        address: 172.24.0.13
        netmask: 255.255.255.0
    sync_networks: true
    check: true

rhel_vm2_modified_ch09S04:
  - cluster: "{{ cluster_ge[0]['name'] }}"
    vm_name: rhel-vm2
    vm_description: "RHEL Guest using {{ dc_ge[0]['name'] }} data center"
    vm_comment: ""
    #template: class_template
    template: Blank
    memory: 1GiB
    test_memory: 512MiB
    clone: true
    vm_disks:
      - name: "{{ rhel7_sealed_qcow_vm2[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rhel7_sealed_qcow_vm1:
  - name: rhel7-sealed-vm1
    description: rhel7-sealed
    content_url: http://materials.example.com/rhel7-minimal-sealed.qcow2
    upload_image_path: /home/student/Downloads/rhel7-minimal-sealed.qcow2
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 3GiB
    content_type: data

rhel7_sealed_qcow_vm2:
  - name: rhel7-sealed-vm2
    description: rhel7-sealed
    content_url: http://materials.example.com/rhel7-minimal-sealed.qcow2
    upload_image_path: /home/student/Downloads/rhel7-minimal-sealed.qcow2
    wait_boolean: "true"
    bootable: "false"
    format: cow
    size: 3GiB
    content_type: data

cluster_lab_ch09S05:
  - name: clusterone
    data_center: "{{ dc_ge[0]['name'] }}"
    cpu_arch: x86_64
    cpu_type: Intel Westmere IBRS SSBD MDS Family
    compatibility_version: 4.3
    #scheduling_policy: none
    scheduling_policy: vm_evenly_distributed
    scheduling_policy_properties:
      - name: HighVmCount
        value: 2
      - name: SpmVmGrace
        value: 0
      - name: MigrationThreshold
        value: 2

dc_cr:
  - name: datacenter1
    description: ""
    compatibility_version: 4.3
  - name: datacenter2
    description: ""
    compatibility_version: 4.3

cluster_cr:
  - name: cluster1
    data_center: "{{ dc_cr[0]['name'] }}"
    cpu_arch: x86_64
    cpu_type: Intel Westmere IBRS SSBD MDS Family
    compatibility_version: 4.3
    #mac_pool: 
    #  name: mac-pool-cluster1
    #  pool:
    #    - "56:6f:07:a7:0a:01,56:6f:07:a7:0a:0a"
    #  macs:
    #    mac_0a01: 172.25.10.1
    #    mac_0a02: 172.25.10.2
    #    mac_0a03: 172.25.10.3
    #    mac_0a04: 172.25.10.4
    #    mac_0a05: 172.25.10.5
    #    mac_0a06: 172.25.10.6
    #    mac_0a07: 172.25.10.7
    #    mac_0a08: 172.25.10.8
    #    mac_0a09: 172.25.10.9
    #    mac_0a0a: 172.25.10.10
  - name: cluster2
    data_center: "{{ dc_cr[1]['name'] }}"
    cpu_arch: x86_64
    cpu_type: Intel Westmere IBRS SSBD MDS Family
    compatibility_version: 4.3

hostb_cr:
  - name: hostb.lab.example.com
    shortname: hostb
    cluster: "{{ cluster_cr[0]['name'] }}"
    address: hostb.lab.example.com
    initial_vdsm_version: vdsm-4.30.13-4.el7ev
    upgraded_vdsm_version: vdsm-4.30.24-2.el7ev

hostc_cr:
  - name: hostc.lab.example.com
    shortname: hostc
    cluster: "{{ cluster_cr[0]['name'] }}"
    address: hostc.lab.example.com
    initial_vdsm_version: vdsm-4.30.13-4.el7ev
    upgraded_vdsm_version: vdsm-4.30.24-2.el7ev

hostd_cr:
  - name: hostd.lab.example.com
    shortname: hostd
    cluster: "{{ cluster_cr[1]['name'] }}"
    address: hostd.lab.example.com
    initial_vdsm_version: vdsm-4.30.13-4.el7ev
    upgraded_vdsm_version: vdsm-4.30.24-2.el7ev

logical_network_cr:
  - name: virtual
    data_center: "{{ dc_cr[0]['name'] }}"
    description: ""
    comment: ""
    vlan_tag: 10
    vm_network: true
    clusters:
      - name: "{{ cluster_cr[0]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false
  - name: storage
    data_center: "{{ dc_cr[0]['name'] }}"
    description: ""
    comment: ""
    vm_network: false
    clusters:
      - name: "{{ cluster_cr[0]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false
  - name: storage
    data_center: "{{ dc_cr[1]['name'] }}"
    description: ""
    comment: ""
    vm_network: false
    clusters:
      - name: "{{ cluster_cr[1]['name'] }}"
        assigned: true
        required: true
        migration: false
        display: false

host_nics_cr:
  - name: hostb.lab.example.com
    interface: eth0
    networks:
      - name: "{{ logical_network_cr[0]['name'] }}"
        boot_protocol: dhcp
        version: v4
    sync_networks: true
    check: true
  - name: hostb.lab.example.com
    interface: eth1
    networks:
      - name: "{{ logical_network_cr[1]['name'] }}"
        boot_protocol: static
        address: 172.24.0.11
        netmask: 255.255.255.0
    sync_networks: true
    check: true
  - name: hostc.lab.example.com
    interface: eth0
    networks:
      - name: "{{ logical_network_cr[0]['name'] }}"
        boot_protocol: dhcp
        version: v4
    sync_networks: true
    check: true
  - name: hostc.lab.example.com
    interface: eth1
    networks:
      - name: "{{ logical_network_cr[1]['name'] }}"
        boot_protocol: static
        address: 172.24.0.12
        netmask: 255.255.255.0
    sync_networks: true
    check: true
  - name: hostd.lab.example.com
    interface: eth1
    networks:
      - name: "{{ logical_network_cr[2]['name'] }}"
        boot_protocol: static
        address: 172.24.0.13
        netmask: 255.255.255.0
    sync_networks: true
    check: true

nfs_storage_cr:
  - name: datastorage1
    data_center: "{{ dc_cr[0]['name'] }}"
    host: hostb.lab.example.com
    description: ""
    domain_function: data
    domain_type: nfs
    nfs:
      address: 172.24.0.8
      path: /exports/data

iscsi_cr:
  - name: datastorage2
    data_center: "{{ dc_cr[1]['name'] }}"
    host: hostd.lab.example.com
    description: ""
    domain_function: data
    domain_type: iscsi
    iscsi_lun:
      target: "iqn.2019-07.com.example.lab:utility"
      address: 172.24.0.8

nfs_export_cr:
  - name: movestorage
    data_center: "{{ dc_cr[0]['name'] }}"
    host: hostb.lab.example.com
    description: ""
    domain_function: export
    domain_type: nfs
    nfs:
      address: 172.24.0.8
      path: /exports/data2

class_temp_vm_cr:
  - cluster: "{{ cluster_cr[0]['name'] }}"
    vm_name: class-temp-vm-cr
    vm_description: "Temporary VM for creating a Template"
    vm_comment: ""
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    vm_disks:
      - name: "{{ rhel7_sealed_qcow_cr[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_cr[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

class_template_cr:
  - name: class-template-cr
    cluster: "{{ cluster_cr[0]['name'] }}"
    description: ""
    seal: false
    vm: "{{ class_temp_vm_cr[0]['vm_name'] }}"

vm_rh1_cr:
  - cluster: "{{ cluster_cr[0]['name'] }}"
    vm_name: rh1
    vm_description: ""
    vm_comment: ""
    template: class_template_cr
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 512Mib
    test_memory_max: 0.50 GB
    clone: true
    vm_disks:
      - name: rh1_Disk1
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_cr[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

vm_rh2_cr:
  - cluster: "{{ cluster_cr[0]['name'] }}"
    vm_name: rh2
    vm_description: ""
    vm_comment: ""
    template: class_template_cr
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 512Mib
    test_memory_max: 0.50 GB
    clone: true
    vm_disks:
      - name: rhel-cr
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_cr[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

rh_template:
  - name: rh-template
    cluster: "{{ cluster_cr[0]['name'] }}"
    description: ""

managed_users_roles_cr:
  - user_name: rhvadmin
    object_type: system
    role: SuperUser

rhel_vm1_modified_ch04S06:
  - cluster: Default
    vm_name: rhel-vm1
    vm_description: "RHEL Guest using Default data center"
    vm_comment: ""
    #template: class_template
    template: Blank
    memory: 1GiB
    test_memory: 512MiB
    clone: true
    vm_disks:
      - name: "{{ rhel7_sealed_qcow_vm1[0]['name'] }}"
        activate: true
        bootable: true
        interface: virtio
    #vm_nics:
    #  - name: nic1
    #    interface: virtio
    #    profile_name: "{{ logical_network_ge[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server

cluster_lab_ch09S05_restore:
  - name: clusterone
    data_center: "{{ dc_ge[0]['name'] }}"
    cpu_arch: x86_64
    cpu_type: Intel Westmere IBRS SSBD MDS Family
    compatibility_version: 4.3
    scheduling_policy: vm_evenly_distributed
    scheduling_policy_properties:
      - name: HighVmCount
        value: 10
      - name: SpmVmGrace
        value: 5
      - name: MigrationThreshold
        value: 5

movestorage_remove:
  - name: "movestorage"
    data_center: "{{ dc_cr[1]['name'] }}"

vm_rh2_dc2_cr:
  - cluster: "{{ cluster_cr[0]['name'] }}"
    vm_name: rh2-dc2
    vm_description: ""
    vm_comment: ""
    template: class_template_cr
    memory: 512MiB
    test_memory: 0.50 GB
    memory_max: 1024Mib
    test_memory_max: 1.00 GB
    clone: true
    vm_disks:
      - name: rhel-cr
        activate: true
        bootable: true
        interface: virtio
    vm_nics:
      - name: nic1
        interface: virtio
        profile_name: "{{ logical_network_cr[0]['name'] }}"
    vm_operating_system: rhel_7x64
    cpu_cores: 1
    ballooning_enabled: true
    vm_type: server
