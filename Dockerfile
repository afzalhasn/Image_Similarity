FROM python:3.7-slim-buster

# Install opencv dependencies
# RUN apt-get update
# RUN apt-get install libglib2.0-0 -y
# RUN apt-get install libgtk2.0-dev -y
# RUN apt-get clean

# Install tesseract dependencies
# RUN apt update && apt install -y libsm6 libxext6
# RUN apt-get -y install tesseract-ocr

# Copy files
COPY requirements.txt /app/
COPY ./src/start_api.py /app/src/
COPY ./src/wsgi.py /app/src/
COPY ./lib/__init__.py /app/lib/
COPY ./lib/neighbor_list_recom_new.pickle /app/lib/neighbor_list_recom_new.pickle
COPY ./lib/search.py /app/lib/search.py
COPY ./lib/saved_features_recom_new.txt /app/lib/saved_features_recom_new.txt

# Copy directories
COPY src/imagenet /app/src/imagenet
COPY src/static /app/src/static
COPY src/templates /app/src/templates
COPY src/uploads/ /app/src/uploads

# Install python dependencies
RUN python3 -m pip install --upgrade pip
RUN pip3 install -r /app/requirements.txt
RUN pip3 install gunicorn

WORKDIR /app/src/

ENV PYTHONIOENCODING UTF-8
CMD ["gunicorn", "-w", "4", "wsgi:app"]
