psql --no-align -t -f write_synch.sql -h 127.0.0.1 -p 63336 cfdm $RDS_OWNER_USERNAME > synch.sql
