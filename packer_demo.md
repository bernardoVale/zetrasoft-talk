Create packer.json inside chef cookbook
```json
{
  "variables": {
    "aws_region"       :  "us-east-1",
    "aws_instance_type":  "t2.micro",
    "checksum":            "{{env `APP_CHECKSUM`}}",
    "dns_listen_addr":    "127.0.0.1",
    "ssh_username":       "root"
  },
  "builders": [
    {
      "name":             "aws-{{user `aws_region`}}",
      "type":             "amazon-ebs",
      "source_ami":       "ami-08a28a73",
      "region":           "{{user `aws_region`}}",
      "instance_type":    "{{user `aws_instance_type`}}",
      "ssh_username":     "{{user `ssh_username`}}",
      "ssh_timeout":      "10m",
      "ami_name":         "deploy-chef-{{timestamp}}",
      "ami_description":  "",
      "tags": {
        "Name": "deploy_ami_{{timestamp}}",
        "CreationDate": "{{timestamp}}"
      },
      "ssh_private_ip":   false,
      "associate_public_ip_address": true
    }
  ],
  "provisioners": [
    {
      "type": "chef-solo",
      "cookbook_paths": ["berks-cookbooks"],
      "run_list": ["recipe[deploy::default]"],
      "json": {
        "artifact_checksum": "{{user `checksum`}}"
      }
    }
  ]
}
```


Run
```
berks vendor
APP_CHECKSUM=1805a065dc4baac5d399307cd5b115ca362bbb1682d4cdc52e969a020ab0c698 packer build packer.json
```