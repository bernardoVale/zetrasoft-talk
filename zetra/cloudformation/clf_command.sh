aws cloudformation create-stack --stack-name zetra-example \
--template-body file://cloudformation.json \
--parameters ParameterKey=Ami,ParameterValue=ami-9b86fe8d

aws cloudformation update-stack --stack-name zetra-example \
--template-body file://cloudformation.json \
--parameters ParameterKey=Ami,ParameterValue=ami-99134c8f