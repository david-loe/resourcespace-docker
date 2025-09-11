# https://www.resourcespace.com/knowledge-base/plugins/clip-ai-smart-search
FROM python:3.13
ARG RS_VERSION=10.6

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y subversion && rm -rf /var/lib/apt/lists/*

RUN pip install fastapi uvicorn torch torchvision ftfy regex tqdm mysql-connector-python python-multipart faiss-cpu requests

RUN pip install git+https://github.com/openai/CLIP.git

RUN svn co "http://svn.resourcespace.com/svn/rs/releases/${RS_VERSION}/plugins/clip" .

ENTRYPOINT ["python", "scripts/clip_service.py"]