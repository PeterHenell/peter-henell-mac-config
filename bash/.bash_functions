get_pw () {
    if [ "$1" = "" ] ; then
        echo "Usage:"
        echo "get_pw servername username"
        return
    fi
    security 2>&1 >/dev/null find-internet-password -gs $1 -a $2 \
        |ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

put_pw () {
    if [ "$1" = "" ] ; then
        echo "Usage:"
	echo "put_pw username server_name password"
        return
    fi
    # $1 = username
    # $2 = server name
    # $3 = password to add
    security add-internet-password -a $1 -s $2 -w $3
}

