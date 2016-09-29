#!/bin/bash

DIRETORIO_DADOS="./dados"

CMD_ENVIAR_DADOS="python3 ./enviarDados.py"
CMD_COLETAR_MCP3008="sudo python3 ./adafruit_mcp3008.py"
CMD_COLETAR_DHT22="sudo ./dht22"
CMD_EXTRAIR_DHT22="python3 ./extrairDHT22.py"


echo " "
echo " "


DHT22_TEMPERATURA_AR_ARQUIVO="$DIRETORIO_DADOS/TemperaturaAr"
DHT22_UMIDADE_AR_ARQUIVO="$DIRETORIO_DADOS/UmidadeAr"

echo "Lendo DHT22 temperatura e umidade ar"
DHT22_LER=$($CMD_COLETAR_DHT22)
echo "Sensor = $DHT22_LER"

DHT22_TEMPERATURA_AR_VALOR=$(echo $DHT22_LER | $CMD_EXTRAIR_DHT22 1)
echo $DHT22_TEMPERATURA_AR_VALOR > $DHT22_TEMPERATURA_AR_ARQUIVO
echo "Temperatura = $DHT22_TEMPERATURA_AR_VALOR"

DHT22_UMIDADE_AR_VALOR=$(echo $DHT22_LER | $CMD_EXTRAIR_DHT22 2)
echo $DHT22_UMIDADE_AR_VALOR > $DHT22_UMIDADE_AR_ARQUIVO
echo "Umidade = $DHT22_UMIDADE_AR_VALOR"


echo " "
echo " "


YL38_CHUVA_CHANNEL=0
YL38_CHUVA_ARQUIVO="$DIRETORIO_DADOS/Chuva"

echo "Lendo YL38 chuva"
YL38_CHUVA_LER=$(echo $YL38_CHUVA_CHANNEL | $CMD_COLETAR_MCP3008)
echo "Sensor = $YL38_CHUVA_LER"

YL38_CHUVA_VALOR=$(echo "scale=2; 100 - ($YL38_CHUVA_LER / 1024 * 100)" | bc)
echo $YL38_CHUVA_VALOR > $YL38_CHUVA_ARQUIVO
echo "Convertido = $YL38_CHUVA_VALOR"


echo " "
echo " "


FC28_UMIDADE_SOLO_CHANNEL=2
FC28_UMIDADE_SOLO_ARQUIVO="$DIRETORIO_DADOS/UmidadeSolo"

echo "Lendo FC28 umidade solo"
FC28_UMIDADE_SOLO_LER=$(echo $FC28_UMIDADE_SOLO_CHANNEL | $CMD_COLETAR_MCP3008)
echo "Sensor = $FC28_UMIDADE_SOLO_LER"

FC28_UMIDADE_SOLO_VALOR=$(echo "scale=2; 100 - ($FC28_UMIDADE_SOLO_LER / 1024 * 100)" | bc)
echo $FC28_UMIDADE_SOLO_VALOR > $FC28_UMIDADE_SOLO_ARQUIVO
echo "Convertido = $FC28_UMIDADE_SOLO_VALOR"


echo " "
echo " "


LM35_TEMPERATURA_SOLO_CHANNEL=4
LM35_TEMPERATURA_SOLO_ARQUIVO="$DIRETORIO_DADOS/TemperaturaSolo"

echo "Lendo LM35 temperatura solo"
LM35_TEMPERATURA_SOLO_LER=$(echo $LM35_TEMPERATURA_SOLO_CHANNEL | $CMD_COLETAR_MCP3008)
echo "Sensor = $LM35_TEMPERATURA_SOLO_LER"

LM35_TEMPERATURA_SOLO_VALOR=$(echo "scale=2; ($LM35_TEMPERATURA_SOLO_LER * 3.3 / 1024 * 100)" | bc)
echo $LM35_TEMPERATURA_SOLO_VALOR > $LM35_TEMPERATURA_SOLO_ARQUIVO
echo "Convertido = $LM35_TEMPERATURA_SOLO_VALOR"


echo " "
echo " "


echo "Enviando dados ao servidor"
$CMD_ENVIAR_DADOS



echo "FIM COLETA DE DADOS "