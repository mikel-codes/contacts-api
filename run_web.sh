#!/bin/sh

#remove any background rails server processes running|active
su -m smeez -c "rm -f tmp/pids/server.pid"

# run the server
su -m smeez -c "rails server -p 3000 -b 0.0.0.0"
