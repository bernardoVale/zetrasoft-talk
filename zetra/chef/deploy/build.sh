#!/bin/bash
rm -rf berks-cookbooks
berks vendor
APP_CHECKSUM=409b59a8b275f57eb8f7eb7c12e293eefd1f8e64e165a25b3d8501c1b870378f packer build packer.json