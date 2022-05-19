# using oficial image from docker hub https://hub.docker.com/_/python
FROM python:3.7.7-slim-buster

# Copy Python dependencies file   
COPY requirements.txt /   

# Creates a Virtual Environment and installl dependencies
RUN python3 -m venv venv \ 
&& ./venv/bin/pip install --upgrade pip \ 
&& ./venv/bin/pip install -r requirements.txt

# copy app source to folder /app inside the container
COPY main.py .  

# exposes the port of the app (as defined in the main.py)
EXPOSE 8005

# command to run the app using the virtual environment inside the container
CMD [ "./venv/bin/python", "./main.py" ]

LABEL creator="Vubble Inc."