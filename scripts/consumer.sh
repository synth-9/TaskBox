#!/bin/bash

# Function to handle errors
handle_error() {
  echo "An error occurred on line $1"
}

# Trap errors and call the handle_error function
trap 'handle_error $LINENO' ERR

QUEUE_NAME=${QUEUE_NAME:-default_queue}

echo "Listening to queue: $QUEUE_NAME"

while true
do
  task=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT rpop "$QUEUE_NAME")
  if [ "$task" ]; then
    echo "Processing task: $task"
    eval "$task"
    sleep 2
  else
    echo "No tasks in the queue, waiting..."
    sleep 5
  fi
done
