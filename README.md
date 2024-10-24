# Taskbox - Simple Queue System with Redis and Docker

Taskbox is a simple queue system built using Redis, Bash, and Docker. It allows you to create tasks and manage their execution using different priority levels. The system supports multiple consumers listening to separate queues, such as high and low priority, to process tasks accordingly.

## Features

- Uses Redis as a message broker to manage task queues.
- Supports dynamic queue names and multiple consumers for different priority levels.
- Can process tasks written in Bash, Python, or any other command-line based scripts.
- Uses Docker Compose to easily set up and run the system.

## Project Structure

```
taskbox/
├── docker-compose.yml       # Docker Compose configuration file
├── Dockerfile               # Dockerfile for building the consumer image
├── scripts/
│   └── consumer.sh          # Consumer script that processes tasks from the queue
└── README.md                # Project documentation
```

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Docker
- Docker Compose

### Setup

1. **Clone the repository:**

   ```bash
   git clone git@github.com:synth-9/TaskBox.git
   cd TaskBox
   ```

2. **Build and start the Docker containers:**

   ```bash
   docker-compose up --build -d
   ```

   This command will start the Redis container (`taskbox_redis`) and two consumer containers (`taskbox_high_priority_consumer` and `taskbox_low_priority_consumer`).

### Adding Tasks to the Queue

You can push tasks to different queues based on their priority level:

1. **Push a High Priority Task:**

   ```bash
   docker exec -it taskbox_redis redis-cli lpush high_priority_queue "echo 'Processing high priority task!'"
   ```

2. **Push a Low Priority Task:**

   ```bash
   docker exec -it taskbox_redis redis-cli lpush low_priority_queue "echo 'Processing low priority task!'"
   ```

### Checking the Consumer Logs

To verify that tasks are being processed, you can view the logs of the consumer containers:

1. **High Priority Consumer Logs:**

   ```bash
   docker logs -f taskbox_high_priority_consumer
   ```

2. **Low Priority Consumer Logs:**

   ```bash
   docker logs -f taskbox_low_priority_consumer
   ```

### Stopping the System

To stop all the running containers:

```bash
docker-compose down
```

## Customizing the Setup

### Dynamic Queue Names

The consumer script supports dynamic queue names by reading the `QUEUE_NAME` environment variable. You can adjust the `docker-compose.yml` file to add more consumers for additional queues.

### Error Handling

The consumer script includes basic error handling to handle issues gracefully and continue processing tasks.

## Running Scripts from a GitHub Repository

You can also add tasks that fetch and execute scripts from a public GitHub repository using commands like `curl` or `wget` inside the task.

Example:

```bash
docker exec -it taskbox_redis redis-cli lpush high_priority_queue "curl -O https://raw.github.com/your-username/your-repo/main/script.sh && bash script.sh"
```

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you would like to improve the project.

## Contact

For any questions, feel free to reach out or open an issue in the [GitHub repository](https://github.com/your-username/taskbox).
