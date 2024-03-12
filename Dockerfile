FROM ubuntu:22.04 as builder

# install dependencies
RUN apt update && \
    apt install -y wget curl tar unzip lib32gcc-s1

# install steamcmd
WORKDIR /steamcmd
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
    until ./steamcmd.sh \
        +force_install_dir /kz16 \
        +login anonymous \
        +app_set_config 90 mod cstrike \
        +app_update 90 -beta steam_legacy validate \
        +quit; \
        do sleep 1; \
    done

# install regamedll_cs
ARG REGAMEDLL_CS_VERSION=5.26.0.668
WORKDIR /regamedll_cs
RUN wget "https://github.com/s1lentq/ReGameDLL_CS/releases/download/${REGAMEDLL_CS_VERSION}/regamedll-bin-${REGAMEDLL_CS_VERSION}.zip" && \
    unzip "regamedll-bin-${REGAMEDLL_CS_VERSION}.zip" && \
    cp -rf bin/linux32/* /kz16

# install metamod
ARG METAMOD_VERSION=1.21.1-am
WORKDIR /metamod
RUN wget "https://www.amxmodx.org/release/metamod-${METAMOD_VERSION}.zip" && \
    unzip "metamod-${METAMOD_VERSION}.zip" && \
    cp -rf addons /kz16/cstrike && \
    echo 'gamedll_linux "addons/metamod/dlls/metamod.so"' >> /kz16/cstrike/liblist.gam

# install amxmodx
ARG AMXMODX_VERSION=1.9.0-git5294
WORKDIR /amxmodx
RUN wget "https://www.amxmodx.org/amxxdrop/1.9/amxmodx-${AMXMODX_VERSION}-base-linux.tar.gz" && \
    tar -xzf amxmodx-${AMXMODX_VERSION}-base-linux.tar.gz && \
    cp -rf addons /kz16/cstrike && \
    rm -rf addons && \
    wget "https://www.amxmodx.org/amxxdrop/1.9/amxmodx-${AMXMODX_VERSION}-cstrike-linux.tar.gz" && \
    tar -xzf amxmodx-${AMXMODX_VERSION}-cstrike-linux.tar.gz && \
    cp -rf addons /kz16/cstrike && \
    echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" > /kz16/cstrike/addons/metamod/plugins.ini

# install reapi
ARG REAPI_VERSION=5.24.0.300
WORKDIR /reapi
RUN wget "https://github.com/s1lentq/reapi/releases/download/${REAPI_VERSION}/reapi-bin-${REAPI_VERSION}.zip" && \
    unzip "reapi-bin-${REAPI_VERSION}.zip" && \
    cp -rf addons /kz16/cstrike

# install amxxeasyhttp
ARG AMXXEASYHTTP_VERSION=1.3.0
WORKDIR /amxxeasyhttp
RUN wget "https://github.com/Next21Team/AmxxEasyHttp/releases/download/${AMXXEASYHTTP_VERSION}/release_linux_v${AMXXEASYHTTP_VERSION}.zip" && \
    unzip "release_linux_v${AMXXEASYHTTP_VERSION}.zip" && \
    cp -rf release_linux_v${AMXXEASYHTTP_VERSION}/addons /kz16/cstrike

# install kreedz-amxx
ARG KREEDZ_AMXX_VERSION=130
WORKDIR /kreedz-amxx
RUN wget "https://github.com/Theggv/Kreedz/releases/download/kreedz-amxx-${KREEDZ_AMXX_VERSION}/kreedz-amxx-${KREEDZ_AMXX_VERSION}-addons.zip" && \
    unzip "kreedz-amxx-${KREEDZ_AMXX_VERSION}-addons.zip" && \
    cp -rf addons /kz16/cstrike


FROM ubuntu:22.04 as runner
# install dependencies
RUN apt update && \
    apt install -y lib32gcc-s1 && \
    apt clean

RUN adduser --home /kz16 kz16
COPY --chown=kz16:kz16 --from=builder /kz16 /kz16
USER kz16
WORKDIR /kz16
COPY overrides/* /kz16
# first segfault run
RUN /kz16/hlds_run -game cstrike +map de_dust2 +maxplayers 32 -norestart || true
ENTRYPOINT ["/kz16/hlds_run", "-game", "cstrike"]
CMD ["+map", "de_dust2", "+maxplayers", "32"]
