FROM ruby:2.3.8-jessie
MAINTAINER SHUBHAM GORLEWAR
RUN apt-get update && apt install -y unzip xvfb libxi6 libgconf-2-4  &&  apt-get install bsdtar -y \
&& gem install selenium-webdriver && gem install cucumber && gem install rspec ;



RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list

RUN  apt-get update

RUN apt-get install google-chrome-stable -y
RUN  apt-get install chromedriver -y

#RUN PLATFORM=linux64
#RUN  mkdir  ~/bin/

#RUN  export PATH="$INSTALLATION_DIRECTORY:$PATH"
#RUN  echo 'export PATH="$INSTALLATION_DIRECTORY:$PATH"' >> ~/.bashrc 
#RUN VERSION = $(curl http://chromedriver.storage.googleapis.com/LATEST_RELEASE) 
#RUN curl http://chromedriver.storage.googleapis.com/2.46/chromedriver_linux64.zip 
#RUN bsdtar -xvf - ~/bin/ 

RUN  ln -s /usr/lib/chromium-browser/chromedriver /usr/bin/chromedriver
