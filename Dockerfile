FROM ubuntu:latest
RUN apt-get update && apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

RUN cd \
  && git clone https://github.com/excid3/asdf.git ~/.asdf \
  && echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc \
  && echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc \
  && echo 'legacy_version_file = yes' >> ~/.asdfrc \
  && echo 'export EDITOR="code --wait"' >> ~/.bashrc \
  && exec $SHELL

RUN asdf plugin add ruby && asdf plugin add nodejs

RUN asdf install ruby 3.3.0 \
  && asdf global ruby 3.3.0 \
  && gem update --system

RUN which ruby
RUN ruby -v

RUN asdf install nodejs 20.11.0 \
  && asdf global nodejs 20.11.0

RUN which node
RUN node -v

RUN npm install -g yarn

RUN gem install rails -v 7.1.3


WORKDIR /app
COPY . .

CMD ["myapp"]

