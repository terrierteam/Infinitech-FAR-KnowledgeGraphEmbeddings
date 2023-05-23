FROM python:3.8-slim-buster

EXPOSE 8888

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

ENV JUPYTER_RUNTIME_DIR='/tmp/'
ENV JUPYTER_DATA_DIR=$PYTHONUSERBASE

# Install pip requirements
COPY requirements.txt .
RUN python -m pip install -r requirements.txt
RUN python -m pip install jupyter

COPY iPythonNotebooks/ProfitabilityPredictionWithKnowledgeGraphEmbeddings.ipynb /tmp/iPythonNotebooks/

# Copy the data
COPY data/stocks /tmp/data/stocks
COPY data/kg/entities.txt /tmp/data/kg/
COPY data/kg/values.txt /tmp/data/kg/
COPY data/kg/properties.txt /tmp/data/kg/
COPY data/kg/relations.txt /tmp/data/kg/
COPY data/kg/value_relations.txt /tmp/data/kg/
COPY data/kg/mapping.txt /tmp/data/kg/

WORKDIR /tmp/iPythonNotebooks

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--notebook-dir='/tmp/iPythonNotebooks/'"]

