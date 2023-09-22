FROM python:3.11

EXPOSE 8888

# RUN apt-get update && apt-get install nodejs -y

RUN useradd jupyter
RUN mkdir /home/jupyter
RUN chown jupyter:jupyter /home/jupyter

RUN mkdir -p /jupyter/config
RUN mkdir -p /jupyter/data

COPY jupyter_server_config.py /jupyter/config

RUN chown jupyter:jupyter -R /jupyter

USER jupyter

COPY requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt --no-warn-script-location

COPY fix_last_modified.patch /tmp
WORKDIR /home/jupyter/.local/lib/python3.11/site-packages/jupyter_collaboration
RUN git apply /tmp/fix_last_modified.patch

ENV JUPYTER_CONFIG_DIR=/jupyter/config

ENTRYPOINT /home/jupyter/.local/bin/jupyter lab --collaborative
