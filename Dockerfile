FROM ubuntu

ENV CONTAINER_USER="unity3d"
ENV UNITY_PACKAGE="http://beta.unity3d.com/download/b9488c3b1f9f/unity-editor_amd64-5.6.0xb10Linux.deb"

RUN groupadd -r ${CONTAINER_USER} --gid=1000 && useradd -m -g ${CONTAINER_USER} --uid=1000 ${CONTAINER_USER} && usermod -aG video ${CONTAINER_USER}

RUN apt-get update && apt-get install -y --no-install-recommends wget

RUN wget ${UNITY_PACKAGE} && dpkg -i *.deb || apt-get -f install -y && rm *.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
      xvfb \
      libgl1-mesa-dri \
      libgl1-mesa-glx \
      libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 \
      ca-certificates \
      wget

USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}

ENV DISPLAY=:0

