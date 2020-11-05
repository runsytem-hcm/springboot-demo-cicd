echo "===== Starting Service ====="
java -jar -Doracle.jdbc.fanEnabled=false -Xmx512m ./service.jar
