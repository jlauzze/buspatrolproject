FROM python:3.8-alpine
RUN pip install --upgrade pip && \
    pip install boto3
COPY main.py ./main.py
CMD ["python", "./main.py","joelauzzebucket"]