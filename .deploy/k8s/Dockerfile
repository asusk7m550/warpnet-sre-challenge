# pull the official docker image
FROM python:3-slim

# set work directory
WORKDIR /app

# copy application code
COPY .code/app .

# install dependencies
RUN pip install -r requirements.txt gunicorn

# Expose port 8000, so we can connect to it
EXPOSE 8000

# run the application
CMD /usr/local/bin/gunicorn -w4 -b 0.0.0.0:8000 application:app
