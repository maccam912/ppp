FROM nixos/nix:latest

RUN echo "substituters        = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/" >> /etc/nix/nix.conf
RUN echo "trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" >> /etc/nix/nix.conf

RUN apk add git

WORKDIR /opt
RUN git clone https://github.com/input-output-hk/plutus
RUN cd plutus && git checkout 3aa86304e9bfc425667051a8a94db73fcdc38878

WORKDIR /opt/plutus

EXPOSE 8080

RUN nix-shell --run "exit"

CMD nix-shell --run "cd plutus-playground-client && plutus-playground-server"
