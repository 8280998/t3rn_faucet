FROM python:3.9-slim
WORKDIR /app
COPY server.py .
RUN pip install --no-cache-dir flask web3 flask-cors
RUN chmod -R 777 /app
EXPOSE 3111
CMD ["python3", "server.py"]
