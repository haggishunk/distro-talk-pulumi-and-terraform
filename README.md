# Infrastructure as Code (IaC)

## Comparing the Declarative Terraform with the more Procedural Pulumi

### Prereqs

- Terraform
- Pulumi
- python & pip

Get the repo
```
git clone https://github.com/haggishunk/distro-talk-pulumi-and-terraform
```

### Terraform Demo

Initialize

```
cd terraform
terraform init
```

Plan

```
terraform plan -var "count=3" -out plan
```

Deploy

```
terraform apply plan
```

Adjust

```
terraform plan -var "count=5" -out plan
```

Update the deployment

```
terraform apply plan
```

Notice how Terraform destroys each of the volume-instance associations upon scaling?  This is due to the way Terraform calculates count indexes during generation of the DAG.

### Pulumi Demo

Install dependencies

```
cd ../pulumi
pip install -r requirements.txt
```

Create a new stack

```
pulumi stack init pulumi-demo
pulumi config set aws:region us-west-2
```

Deploy

```
pulumi up
```

Edit `__main__.py` and change the count of instances.

```
COUNT = 5
```

Update the deployment

```
pulumi up
```

Pulumi will not touch any resource that is unchanged, including the volume-instance associations.

### Thoughts

I find the declarative approach of Terraform very liberating in that I don't have to think procedurally at all... as long as I stay away from null\_resource.  However I've been frustrated by Terraform thinking it needs to destroy and recreate resources that are unchanged.

Pulumi requires you to do a little more procedural thinking to get what you want, but still, in terms of infra, you don't need to get too fancy or comlex to stand up a service's resources.

Pulumi is new and requires you to dig through code since documentation is a bit lacking.  That being said, I was able to navigate it OK!
