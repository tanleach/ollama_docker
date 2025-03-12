
#!/bin/bash

CONTAINER_NAME="ollama"

if [ -z "$CONTAINER_NAME" ]; then
    echo "Usage: $0 <container_name_or_id>"
    exit 1
fi

if docker ps --filter "name=$CONTAINER_NAME" --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"; then
    echo "Container '$CONTAINER_NAME' is running."
else
    echo "Starting $CONTAINER_NAME..."
    docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
fi


echo "Adding deepseek-r1:14b..."
docker exec -it ollama ollama pull deepseek-r1:14b

echo "Adding llama3.1:8b..."
docker exec -it ollama ollama pull llama3.1:8b

echo "Adding qwen2.5-coder:7b..."
docker exec -it ollama ollama pull qwen2.5-coder:7b

echo "Adding llama3.2:3b..."
docker exec -it ollama ollama pull llama3.2:3b

echo "Adding qwq:32b..."
docker exec -it ollama ollama pull qwq:32b
