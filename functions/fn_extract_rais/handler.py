import boto3
from datetime import datetime

sageclient = boto3.client('sagemaker', region_name='us-east-2')
sagemaker_role='arn:aws:iam::774178677404:role/service-role/AmazonSageMaker-ExecutionRole-20210509D1'

def handler(event, context):
    
    process_job_arn = sageclient.create_processing_job(
        ProcessingJobName= f"rais2020-extraction-{datetime.now().strftime('%Y-%m-%d-%H-%M-%S')}",
        ProcessingOutputConfig={
            'Outputs': [
                {
                    'OutputName': 'rais',
                    'S3Output': {
                        'S3Uri': 's3://rb-desafio-prod-raw-zone/rais',
                        'LocalPath': '/opt/ml/processing/output/rais',
                        'S3UploadMode': 'EndOfJob'
                    }
                },
            ]
        },
        ProcessingResources={
            'ClusterConfig': {
                'InstanceCount': 1,
                'InstanceType': 'ml.m5.xlarge',
                'VolumeSizeInGB': 50,

            }
        },
        AppSpecification={
            'ImageUri': '774178677404.dkr.ecr.us-east-2.amazonaws.com/rb-desafio-prod-extract-rais:latest'
        },
        RoleArn=sagemaker_role,
        
    )

    return {
        'statusCode': 200,
        'body': f"Started job {process_job_arn['ProcessingJobArn']}"
    }