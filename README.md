Poll Desk API for current queue stats, and write 'em to a CSV file.

To install and run:
- From a terminal, run `git clone https://github.com/Cb-James/queue_monitor.git`
- then run `./desk_queue_monitor start &`

Requires the following environment variables to work:

- DESK_KEY
- DESK_SECRET
- DESK_TOKEN
- DESK_TOKEN_SECRET
- DESK_EMAIL
- DESK_SUBDOMAIN
- DESK_INBOX_ID
- DESK_24_ID
- QUEUE_STATS_FILE

to stop it, run `./desk_queue_monitor stop`
to check status: `./desk_queue_monitor status`
