FROM nixos/nix:latest

RUN echo "substituters        = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/" >> /etc/nix/nix.conf
RUN echo "trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" >> /etc/nix/nix.conf

RUN apk add git

WORKDIR /opt
RUN git clone https://github.com/input-output-hk/plutus
# Just to change something so the fetch and rebase runs
ENV WEEK=03 
RUN cd plutus && git fetch && git rebase
RUN cd plutus && git checkout 3aa86304e9bfc425667051a8a94db73fcdc38878

WORKDIR /opt/plutus


RUN nix-shell --run "exit"
WORKDIR /opt/plutus/plutus-playground-client
# TODO this should not be done on build, create scripts to launch the processes
RUN sed -i -e 's/localhost:8080/server:8080/g' default.nix 
RUN sed -i -e 's/localhost:8080/server:8080/g' webpack.config.js
RUN sed -i -e 's/--progress/--progress --host=0.0.0.0/g' package.json

WORKDIR /opt/plutus
RUN nix-shell --run "cd plutus-playground-client && npm install && plutus-playground-generate-purs && npm run purs:compile && npm run webpack"

EXPOSE 8080
EXPOSE 8009

CMD nix-shell --run "cd plutus-playground-client && plutus-playground-server"
# CMD nix-shell --run "cd plutus-playground-client && npm run start"
