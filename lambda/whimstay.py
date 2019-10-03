import boto3
import os

def lambda_handler(event, context):
 
    # Get the event details
    resources=', '.join(event["resources"])
    stop=resources.find("stop")
    start=resources.find("start")
    
    ec2 = boto3.client('ec2',region_name=os.environ['REGION'])
    
    try:
        # Checks if trigger/event is start or shutdown
        if stop >= 0:
            ec2.stop_instances(InstanceIds=[os.environ['INSTANCEID']],DryRun=False)
            print('[INFO] Stopped your instances: ' + str(os.environ['INSTANCEID']))
        elif start >0:
            ec2.start_instances(InstanceIds=[os.environ['INSTANCEID']],DryRun=False)
            print('[INFO] Started your instances: ' + str(os.environ['INSTANCEID']))
    except Exception as e:
        raise e