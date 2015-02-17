source ~/.bash_functions

TEMPLATE='postgresql://$username:$password@$host:5432/$db_name?sslmode=prefer'

# username host db_name
s="peter.henell localhost bix_dev"

pg_connections[0]="postgres localhost db_dev"
pg_connections[1]="peter.henell test-server db_live"
pg_connections[2]="peter.henell localhost db_dev"


key=(${s// / })
username=${key[0]} 
host=${key[1]}
db_name=${key[2]}
password=$(get_pw $host $username)

CMD="psql $TEMPLATE"
eval $CMD