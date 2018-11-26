import pulumi
from pulumi_aws import ec2, ebs

COUNT = 4
AZONE = "us-west-2c"
# difficulty trying to automate an AMI selection
AMI = "ami-7172b611"

sg_web = ec2.SecurityGroup(
    "web-in",
    ingress=[{
        'protocol': 'tcp', 
        'from_port': 80, 
        'to_port': 80, 
        'cidr_blocks': ["0.0.0.0/0"]
        }]
)

instances_web = []
for i in range(COUNT):
    inst = ec2.Instance(
        'Terraform Demo {}'.format(i), 
        ami=AMI, 
        availability_zone=AZONE,
        instance_type="t2.micro", 
        vpc_security_group_ids=[sg_web.id])
    instances_web.append(inst)

volumes_web = []
for i in range(COUNT):
    vol = ebs.Volume(
        'Terraform Demo {}'.format(i),
        # strange that you can set the azone for instances with pulumi config
        # but it doesn't take for volumes
        availability_zone=AZONE,
        size=10
    )
    volumes_web.append(vol)

volumes_attach = []
for i in range(COUNT):
    vol_attach = ec2.VolumeAttachment(
        'Terraform Demo {}'.format(i),
        device_name="/dev/sdh",
        instance_id=instances_web[i].id,
        volume_id=volumes_web[i].id
    )
    volumes_attach.append(vol_attach)
