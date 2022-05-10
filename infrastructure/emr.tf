resource "aws_emr_cluster" "cluster" {
  name          = "emr-rb-rais"
  release_label = "emr-4.6.0"
  applications  = ["Spark", "Hive", "Pig", "Hue", "JupyterHub", "JupyterEnterpriseGateway", "Livy"]

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    instance_profile                  = aws_iam_instance_profile.emr_profile.arn
  }

  master_instance_group {
    instance_type = "m4.large"
  }

  core_instance_group {
    instance_type  = "c4.large"
    instance_count = 1

    ebs_config {
      size                 = "40"
      type                 = "gp2"
      volumes_per_instance = 1
    }

    bid_price = "0.30"
  }

  ebs_root_volume_size = 100

  tags = local.common_tags

  bootstrap_action {
    path = "s3://rb-desafio-prod-logs/bootstrap-actions/run-if"
    name = "runif"
    args = ["instance.isMaster=true", "echo running on master node"]
  }

  configurations_json = <<EOF
  [
    {
        "Classification": "spark-env",
        "Properties": {},
        "Configurations": [{
            "Classification": "export",
            "Properties": {
                "PYSPARK_PYTHON": "/usr/bin/python3",
                "PYSPARK_DRIVER_PYTHON": "/usr/bin/python3"
            }
        }]
    },
        {
            "Classification": "spark-hive-site",
            "Properties": {
                "hive.metastore.client.factory.class": "com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"
            }
        },
        {
            "Classification": "spark-defaults",
            "Properties": {
                "spark.submit.deployMode": "cluster",
                "spark.speculation": "false",
                "spark.sql.adaptive.enabled": "true",
                "spark.serializer": "org.apache.spark.serializer.KryoSerializer"
            }
        },
        {
            "Classification": "spark",
            "Properties": {
                "maximizeResourceAllocation": "true"
            }
        }
  ]
EOF

  service_role = aws_iam_role.iam_emr_service_role.arn
}

resource "aws_iam_instance_profile" "emr_profile" {
  name = "emr_profile"
  role = aws_iam_role.iam_emr_service_role.id
}

resource "aws_iam_role" "iam_emr_service_role" {
  name = "emr_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}