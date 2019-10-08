import boto3
import os

def lambda_handler(event, context):
 
    # Get the event details
    resources=', '.join(event["resources"])
    stop=resources.find("stop")
    start=resources.find("start")
    
    ec2 = boto3.client('ec2',region_name=os.environ['REGION'])
    client = boto3.client('ses',region_name=os.environ['SESREGION'])
    
    try:
        # Checks if trigger/event is start or shutdown
        if stop >= 0:
            ec2.stop_instances(InstanceIds=[os.environ['INSTANCEID']],DryRun=False)
            print('[INFO] Stopped your instances: ' + str(os.environ['INSTANCEID']))
        elif start >0:
            ec2.start_instances(InstanceIds=[os.environ['INSTANCEID']],DryRun=False)
            print('[INFO] Started your instances: ' + str(os.environ['INSTANCEID']))
            
            instance = ec2.describe_instances(InstanceIds=[os.environ['INSTANCEID']])
            public_ip = instance['Reservations'][0]['Instances'][0]['PublicIpAddress']
            
            # Email settings
            subject = "New Proxy IP Generated"
            body = ("This is an auto-generated message. Do not reply. \r\n"
                    "You may connect to your whimstay proxy server with the following IP: " 
                    + public_ip)
            charset = "utf8"
    
            response = client.send_email(
                                Destination={
                                    'ToAddresses': [os.environ['RECIPIENT']]
                                },
                                Message={
                                    'Body': {
                                        'Text': {
                                            'Charset': charset,
                                            'Data': body,
                                        },
                                    },
                                    'Subject': {
                                        'Charset': charset,
                                        'Data': subject,
                                    },
                                },
                                Source=os.environ['SENDER']
                            )
            
    except Exception as e:
        raise e