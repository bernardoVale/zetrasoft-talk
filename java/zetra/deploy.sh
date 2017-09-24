mvn clean package
aws s3 cp target/zetra.war s3://ac-zetra-deploy
./checksum.sh target/zetra.war