# https://www.resourcespace.com/knowledge-base/plugins/clip-ai-smart-search
FROM python:3.11-slim
ARG RS_VERSION=10.6

ENV PIP_NO_CACHE_DIR=1

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y subversion && rm -rf /var/lib/apt/lists/*

RUN pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu && \
    pip install fastapi uvicorn ftfy regex tqdm mysql-connector-python python-multipart faiss-cpu requests && \
    pip install git+https://github.com/openai/CLIP.git

RUN svn co "http://svn.resourcespace.com/svn/rs/releases/${RS_VERSION}/plugins/clip" .

ENTRYPOINT ["python", "scripts/clip_service.py"]