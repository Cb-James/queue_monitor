#!/bin/bash

start () 
{
    if pgrep -f $0; then
        echo '^^^^^ Already running.';
    else
        while true; do
            ./_get_queue_stats.rb
            sleep 3580 # 1 hour minus avg. execution time (20s)
        done
    fi
}

stop ()
{
    pkill -f $0
}

case "$1" in
    start)
        start
        ;; 

    stop)
        stop
        ;;

    status)
        if pgrep -f $0; then
            echo 'Running.';
        else
            echo 'Not running.'
        fi
        ;;
        
    *)
        echo $"Usage: $0 {start|stop|status}"
        exit 1 
esac
