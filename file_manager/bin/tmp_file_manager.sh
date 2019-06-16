#!/bin/sh
usage="
Usage: action [args...]
    action:
        init
        clean
"
if [ $# -lt 1 ]; then
    echo "$usage"
    exit 1
fi

action=$1
tmp_dir=~/Temperary

init () {
    mkdir -p $tmp_dir/{1d,1w,1m,1y}
}

clean () {
    echo "---------- Date: $date -----------"
    # log
    find $tmp_dir/1d -depth 1 -maxdepth 1 -mtime +0 -exec echo rm -rf {} \;
    find $tmp_dir/1w -depth 1 -maxdepth 1 -mtime +6 -exec echo rm -rf {} \;
    find $tmp_dir/1m -depth 1 -maxdepth 1 -mtime +30 -exec echo rm -rf {} \;
    find $tmp_dir/1y -depth 1 -maxdepth 1 -mtime +365 -exec echo rm -rf {} \;
    # take action
    find $tmp_dir/1d -depth 1 -maxdepth 1 -mtime +0 -exec rm -rf {} \;
    find $tmp_dir/1w -depth 1 -maxdepth 1 -mtime +6 -exec rm -rf {} \;
    find $tmp_dir/1m -depth 1 -maxdepth 1 -mtime +30 -exec rm -rf {} \;
    find $tmp_dir/1y -depth 1 -maxdepth 1 -mtime +365 -exec rm -rf {} \;
}

case $action in
    init|clean)
        eval $action
        ;;
    *)
        echo "$usage"
        exit 1
        ;;
esac
