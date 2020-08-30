# **This is terraform repository for automate creation environment for testing Pipeline from repository [React-app-for-multi-docker-elb-ecs-service](https://github.com/kkkooosss/React-app-for-multi-docker-elb-ecs-service/blob/master/README.md)**

To create all components of invironment use following commands.
```
git clone https://github.com/kkkooosss/Terraform-creation_environment_for_React_app.git
```
```
cd Terraform-creation_environment_for_React_app
```
```
terraform init
```
```
terraform plan
```
You can find all resources which will be created in your AWS account.
```
terraform apply
```

Say "yes" for create resources.

After the proccess acomplesht you have to see similar output.

![Output terraform apply]()  

Now you have to go to your Consul and check all resources were created. 

For use Pipeline we have to change securytu groups attached to RDS postgres instance and ElastiCash for Redis to our new security group "db-redis-sg"

Now you can go to [React-app-for-multi-docker-elb-ecs-service](https://github.com/kkkooosss/React-app-for-multi-docker-elb-ecs-service/blob/master/README.md) and test Pipeline.

Good Luck.