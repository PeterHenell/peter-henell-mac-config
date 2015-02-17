source ~/.bash_functions

TEMPLATE='postgresql://$username:$password@$host:5432/$db_name?sslmode=prefer'

# username host db_name
s="peter.henell localhost devdb"

pg_connections[0]="postgres localhost dev_dbv"
pg_connections[1]='peter remote_host live_db"
pg_connections[2]=""


key=(${s// / })
username=${key[0]} 
host=${key[1]}
db_name=${key[2]}
password=$(get_pw $host $username)

CMD="psql $TEMPLATE"
eval $CMD