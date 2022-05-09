## Conexão com o RDS do servidor AWS e upload do arquivo

from operator import concat
import boto3

# Criar um cliente para interagir com o AWS S3
s3_client = boto3.client('s3')


files = ["RAIS_VINC_PUB_CENTRO_OESTE.7z", "RAIS_VINC_PUB_MG_ES_RJ.7z", "RAIS_VINC_PUB_NORDESTE.7z", "RAIS_VINC_PUB_NORTE.7z",
          "RAIS_VINC_PUB_SP.7z","RAIS_VINC_PUB_SUL.7z"]


for i in range(len(files)):
    s3_client.upload_file(concat('.../data/2020/enem2020/DADOS/', files[i]),
                          'rb-desafio-prod-raw-zone',
                          concat('rais/', files[i]))