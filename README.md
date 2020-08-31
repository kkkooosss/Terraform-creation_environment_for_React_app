# **This is terraform repository for automate creation environment for testing Pipeline from repository [React-app-for-multi-docker-elb-ecs-service](https://github.com/kkkooosss/React-app-for-multi-docker-elb-ecs-service/blob/master/README.md)**

To create all components of the environment use the following commands.

_Note. You should have AWS admins credentials configured._ 
```
git clone https://github.com/kkkooosss/Terraform-creation_environment_for_React_app.git
```
```
cd Terraform-creation_environment_for_React_app
```
Generate ssh key pair for ECS-instances. If you want to access them.
```
ssh-keygen -f ecs-key
```
```
terraform init
```
```
terraform plan
```
You can find all resources which will be created in your AWS account.

Output.

```
...
Plan: 21 to add, 0 to change, 0 to destroy.
...
```

```
terraform apply
```

Say "yes" for create resources.

After the process will be accomplished, you have to see a similar output.

![Output terraform apply](https://github.com/kkkooosss/Terraform-creation_environment_for_React_app/tree/master/pictures)

Now you have to go to your Consul and check all resources that were created. 

For use Pipeline, we have to change security groups attached to RDS postgres instance and ElastiCash for Redis to our new security group "db-redis-sg"

Now you can go to [React-app-for-multi-docker-elb-ecs-service](https://github.com/kkkooosss/React-app-for-multi-docker-elb-ecs-service/blob/master/README.md) repository and test Pipeline.

Good Luck.
