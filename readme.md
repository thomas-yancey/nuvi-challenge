##Nuvi Coding Challenge

This application downloads all zip files from the specified HTTP folder. It then unzips each file and publishes the contents of each xml file to a redis channel named "NEWS_XML" if it has not previously been published. To accomplish this I made the assumption that the xml filenames are unique and therefore set them as the key for the redis hash. Prior to publishing, the application checks the existence of that key in the redis list and only publishes if it does not exist. The application downloads all files to a directory named tmp which is emptied after the program has run.

###setup instructions

First clone the repo and cd into it. If you do not have bundler already installed run gem install bundler. Once you have bundler installed go ahead and run bundle to install all of the dependencies. Make sure that you have redis installed on your local machine, you can follow this guide [Redis quick start]("http://redis.io/topics/quickstart"). Once you have redis installed start up a redis server with the command redis-server. I like to also have the redis-cli monitor running in another terminal window to see the publishing occur. Now you are ready to run the app, cd into lib and run ruby runner.rb
