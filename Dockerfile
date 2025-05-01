FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget

COPY search_path.sh extract_path_value.py config.txt /tmp/

RUN chmod +x /tmp/search_path.sh /tmp/extract_path_value.py