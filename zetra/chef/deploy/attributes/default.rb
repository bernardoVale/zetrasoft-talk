

default['deploy']['artifact']['url'] = 'https://s3.amazonaws.com/ac-zetra-deploy'
default['deploy']['artifact']['name'] = 'zetra.war'

default['artifact_checksum'] = '0885628bfba9560288766852f26affb1bbb56ddc8c24ce0114f6d668d96e270d'

# Tomcat package name
default['deploy']['tomcat']['user'] = 'tomcat'
default['deploy']['tomcat']['group'] = 'tomcat'
default['deploy']['tomcat']['home'] = '/var/lib/tomcat/webapps'