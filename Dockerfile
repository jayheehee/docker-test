FROM databricksruntime/standard:8.x 

RUN mkdir /databricks/jars                                                      

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

#Cloning DS repo in container
RUN mkdir /git
ARG GITHUB_BRANCH_NAME
ARG GITHUB_PAT

RUN cd /git && git clone -b $GITHUB_BRANCH_NAME https://$GITHUB_PAT:x-oauth-basic@github.com/Iterable/data-science.git

#Parsing branch name
RUN IFS='/'; \                                                                  
  i=1; \                                                                        
  words='github.com/jayheehee/Testing-GH-Actions'; \                            
  len=$(echo $words | wc -w); \                                                 
                                                                                
  repo_name=$(for word in $words; \                                             
  do                                                                            
  if [ $i -eq $len ]; \                                                         
  then                                                                          
    echo $word; \                                                               
  fi; \                                                                         
                                                                                
  i=$(($i + 1)); \                                                              
  done); \                                                                      
                                                                                
  echo $repo_name; 

#Build jar with sbt
#RUN cd /git/data-science && sbt "project databricksCommon" assembly
#RUN cp /git/data-science/databricks-common/target/scala-2.12/databricks-common.jar /databricks/jars

#RUN /databricks/conda/envs/dcs-minimal/bin/pip install beautifulsoup4


#RUN /databricks/python/bin/pip install selenium
