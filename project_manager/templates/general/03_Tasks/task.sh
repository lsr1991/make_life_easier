#!/bin/sh
usage="
Usage: action [args...]
    action:
        create [task name]
        archive [task name]
"
if [ $# -lt 1 ]; then
    echo "$usage"
    exit 1
fi

tasks_home=$(cd `dirname $0`;pwd)
archive_home=$(ls -d ${tasks_home}/../*Archive)/${tasks_home##*/}
mkdir -p $archive_home

fmt_task_name () {
    task_name=$1
    echo $task_name | sed -E 's/[[:space:]]+/_/g'
}

create () {
    task_name=$(fmt_task_name $1)
    if [ -d $tasks_home/$task_name ]; then
        echo "task $task_name already exists"
        exit 0
    fi
    mkdir -p $tasks_home/$task_name
}

archive () {
    task_name=$(fmt_task_name $1)
    if ! [ -d $tasks_home/$task_name ]; then
        echo "task $task_name does not exists"
        exit 0
    fi
    mv $tasks_home/$task_name $archive_home/$(date +"%Y%m%d_%H%M%S_")$task_name
}


action=$1

case $action in
    create|c)
        [ $# != 2 ] && echo "$usage" && exit 1
        task_name=$2
        create $task_name
        ;;
    archive|a)
        [ $# != 2 ] && echo "$usage" && exit 1
        task_name=$2
        archive $task_name
        ;;
    *)
        echo "$usage"
        exit 1
        ;;
esac
