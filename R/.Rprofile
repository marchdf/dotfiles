## .Rprofile with stuff taken from all over the web.

## Default repo
local({r <- getOption("repos")
       r["CRAN"] <- "http://cran.us.r-project.org" 
       options(repos=r)
})

## modify the prompt to show user and hostname
options(prompt = paste( paste(gsub("\\..*","",Sys.info () [c ("user", "nodename")]), collapse = "@"),"[R] > "))

## set the editor
options(editor="emacs")

## option to colorize the output
## first comment the two lines below, then install devtools: install.packages("devtools")
## then install colorout from the git repo (https://github.com/jalvesaq/colorout):
##   > library(devtools)
##   > install_github('jalvesaq/colorout')
if(Sys.getenv("TERM") == "xterm-256color")
  library("colorout")

## Create a invisible startup environment for all the functions to go in so it doesn't clutter your workspace.
## Ideas from http://stackoverflow.com/questions/1189759/expert-r-users-whats-in-your-rprofile
##            http://www.gettinggeneticsdone.com/2013/07/customize-rprofile.html
.startup <- new.env()

## Single character shortcuts for summary() and head().
assign("h", utils::head, env=.startup)
assign("s", base::summary, env=.startup)

## ht==headtail, i.e., show the first and last 10 items of an object
assign("ht", function(d) rbind(head(d,10),tail(d,19)) , env=.startup)

## Returns names(df) in single column, numbered matrix format.
assign("n", function(df) matrix(names(df)) , env=.startup)

## Show the first 5 rows and first 5 columns of a data frame or matrix
assign("hh", function(df) if(class(df)=="matrix"|class(df)=="data.frame") df[1:5,1:5] , env=.startup)

## Attach all the startup variables
attach(.startup)

## Run this on login
.First <- function(){
  # Welcome message
  message("Welcome back ", Sys.getenv("USER"),"!\n","working directory is:", getwd())

  # timestamp now so we can later easily search the RHistory file
  if(interactive()){
     library(utils)
     timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))
  }
}

## Run this on exit
.Last <- function(){

  # Save all the commands to RHistory file
  if(interactive()){
     hist_file <- Sys.getenv("R_HISTFILE")
     if(hist_file=="") hist_file <- "~/.RHistory"
     savehistory(hist_file)
  }
}

message("n*** Successfully loaded .Rprofile ***n")
