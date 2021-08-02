FROM databricksruntime/standard:8.x 

#Install sbt
RUN apt-get update
RUN apt-get install -y curl gnupg2
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
RUN apt-get update
RUN apt-get install -y sbt


#Install git
RUN apt-get update && \        
  apt-get install -y git

RUN mkdir /git

ARG BRANCH_NAME
ARG GITHUB_PAT

RUN cd /git && git clone -b $BRANCH_NAME https://$GITHUB_PAT:x-oauth-basic@github.com/Iterable/data-science.git


#RUN /databricks/conda/envs/dcs-minimal/bin/pip install beautifulsoup4
#RUN mkdir /databricks/jars                                                      


#RUN /databricks/python/bin/pip install selenium
