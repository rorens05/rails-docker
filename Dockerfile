FROM ubuntu:latest
RUN apt-get update && apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev -y

RUN apt-get install -y zsh
RUN apt-get install wget
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Set zsh as default shell
RUN chsh -s $(which zsh)

RUN apt-get update && apt-get install -y curl git
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc
RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
RUN exec bash
RUN exec zsh

ENV PATH="$PATH:/root/.asdf/bin"
ENV PATH="$PATH:/root/.asdf/shims"

RUN asdf plugin add ruby && asdf plugin add nodejs

RUN asdf install ruby 3.3.0 \
  && asdf global ruby 3.3.0

RUN asdf install nodejs 20.11.0 \
  && asdf global nodejs 20.11.0

RUN npm install -g yarn

RUN gem update --system

RUN gem install rails -v 7.1.3


WORKDIR /app
COPY . .

CMD ["myapp"]

