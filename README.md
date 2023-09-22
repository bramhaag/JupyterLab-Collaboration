Docker image that launches a Jupyter Lab instance with the real-time collaboration plugin pre-installed

```sh
docker run -it --rm \
  -p 8888:8888 \
  # -v /host/configdir:/jupyter/config \ Note: Image does not automatically copy default configuration files!
  -v /host/datadir:/jupyter/data \
  bramhaag/jupyterlab-collaboration:latest jupyter
```
