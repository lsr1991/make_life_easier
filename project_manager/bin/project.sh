#!/bin/sh
usage="
Usage: action [args...]
    action:
        create,c [project name] [template]
        template,t
"
if [ $# -lt 1 ]; then
    echo "$usage"
    exit 1
fi

template_home=$(cd `dirname $0`/../templates;pwd)

fmt_proj_name () {
    proj_name=$1
    echo $proj_name | sed -E 's/[[:space:]]+/_/g'
}

create () {
    proj_name=$(fmt_proj_name $1)
    template=$2
    if [ -d $proj_name ]; then
        echo "project $proj_name already exists"
        exit 0
    fi
    if ! [ -d $template_home/$template ]; then
        echo "template $template does not exists"
        exit 1
    fi
    cp -r $template_home/$template $proj_name
}


action=$1

case $action in
    create|c)
        [ $# -lt 2 ] && echo "$usage" && exit 1
        proj_name=$2
        template=default
        if [ $# == 3 ]; then
            template=$3
        fi
        create $proj_name $template
        ;;
    template|t)
        ls $template_home | egrep -v '^default$'
        echo "default -> $(readlink $template_home/default)"
        ;;
    *)
        echo "$usage"
        exit 1
        ;;
esac
