source ~/.bash_functions

alias ll='ls -la'
alias play=ansible-playbook

export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export GREP_OPTIONS='color=auto'

export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH

# Postgres 
export PGBIN=/Library/PostgreSQL/9.4/bin/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/

# Oracle instant client 
export TNS_ADMIN=~/Applications/instantclient_11_2
export ORACLE_HOME=~/Applications/instantclient_11_2 

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Library/PostgreSQL/9.4/lib
# Instead of setting this variable, which seemed to cause major issues for many other apps, some soft links were created:
# http://stackoverflow.com/questions/16407995/psycopg2-image-not-found
# With brew install postgres the locations of the dylibs seem to have ended up here
# sudo ln -s /usr/local/Cellar/openssl/1.0.1h/lib/libcrypto.1.0.0.dylib /usr/lib
# sudo ln -s /usr/local/Cellar/openssl/1.0.1h/lib/libssl.1.0.0.dylib /usr/lib

# Think of how to use keychain in osx instead


pg_connections[1]='peter_local  postgresql://peter.henell@localhost:5432/playDB?sslmode=prefer'

ora_connections[2]="peter_localdb C##peter/hemligt@localdb"


pg() {
    process_connection pg_connections "psql" "pg" $1 $2
}

ora() {
    process_connection ora_connections "$ORACLE_HOME/sqlplus" "ora" $1 $2 
}

process_connection() {
    array_name=$1[@]
    connections=("${!array_name}")
    app=$2
    shortcut=$3
    selected=$4
    parameter=$5

    echo "Usage: $shortcut connection_number"
    echo "Available connections:"
    for ((i=0; i < ${#connections[@]}; i++))
    do
        curr=${connections[$i]}
        key=(${curr// / })
        printf "\t$i: %s \n" "$key"
    done
    
    cn=$selected
    
    if [ "$selected" = "" ] ; then
	read -p "Select your connection:" cn
	
	if [ "$cn" = "" ] ; then
	        echo "aborting"
		    return
		    fi
    fi

    re='^[0-9]+$'
    if ! [[ $cn =~ $re ]] ; then
	echo "error: Not a number" >&2
	return
    fi
        
    if [ $cn -lt ${#connections[@]} ] ; then
	curr=${connections[$cn]}
        key=(${curr// / })
	constr=${key[1]} 
	
	echo "Starting $app with connection $selected"
	
	rlwrap $app $constr $parameter
	
    else
	echo "key out of bounds"
	echo ". "
    fi
    
    return
}
export PATH=/usr/local/bin:$PATH


# To add a username/password to the keychain
# security add-internet-password -a USERNAME -s SERVER_NAME -w PASSWORD
