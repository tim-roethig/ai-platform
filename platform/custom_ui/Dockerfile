FROM python:3.13.7-slim-trixie

COPY . .
RUN pip install -r requirements.txt

ENTRYPOINT [ "streamlit", "run", "app.py", "--server.port=8080"]