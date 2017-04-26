FROM ruby:2.3.3
#RUN apt-get update -qq \
#    && apt-get install -y build-essential libpq-dev nodejs vim zsh \
#    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# optmize
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev nodejs vim zsh \
    git-core && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY ./.vimrc-sample ~/.vimrc
ADD . /myapp
