FROM python:3.12.6-slim-bookworm

COPY . .

RUN apt-get update
RUN apt-get upgrade --yes

RUN pip install --no-cache-dir --upgrade -r requirements.txt

RUN apt-get clean
RUN pip cache purge

EXPOSE 80

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]