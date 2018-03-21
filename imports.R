options(stringsAsFactors = FALSE)
options(digits = 20)

libs = c('tidyr','hash','SDMTools','dplyr')
len = length
uni = unique
sorted = sort
cd = setwd


endsWith = function(x, suffix) {
  if (!is.character(x) || !is.character(suffix))
    stop("non-character object(s)")
  n = nchar(x)
  suppressWarnings(substr(x, n - nchar(suffix) + 1L, n) == suffix)
}

luni = function(x){
	return (len(uni(x)))
}

.range = function(x){
	return(range(x,na.rm=TRUE))
}

.mean = function(x){
	return(mean(x,na.rm=TRUE))
}

.sd = function(x){
	return(sd(x,na.rm=TRUE))
}

.median = function(x){
	return(median(x,na.rm=TRUE))
}

.max = function(x){
	return(max(x,na.rm=TRUE))
}

.min = function(x){
	return(min(x,na.rm=TRUE))
}

install = function(x){
	install.packages(as.character(x),dependencies=TRUE, repos='http://cran.rstudio.com/',quiet=TRUE)
	library(x,character.only=TRUE)
	cat(sprintf("Installed and loaded %s library", x))
}

findsep <- function(f){
	if (endsWith(f,"/")){
		sep = ""
	} else {
		sep = "/"
	}
	return(sep)
}

fs <- function(dir){
	files = list.files(dir)

	sep = findsep(dir)
	
	lst = c()
	for (f in files){
		lst = c(lst,paste(dir,f,sep=sep))
	}

	return(lst)
}

fname <- function(dir=NULL,f){
	if (class(dir)=='NULL'){
		dir = getwd()
	}
	sep = findsep(dir)

	return(paste(dir,f,sep=sep))
}

rds = function(DIR=getwd(),erase=FALSE){
	if (erase == TRUE){
		cat(sprintf("Are you sure you want to delete all files in %s\n",DIR))
		rdsfiles = list.files(DIR,pattern='.RDS')
		allfiles = list.files(DIR)
		cat(sprintf("There are %s RDS files out of %s total files",len(rdsfiles),len(allfiles)))
		cat(sprintf("Planning on saving %s RDS files from environment",len(ls(envir=.GlobalEnv))))
		choice <- menu(c("yes","no"))
		if (choice == 1){
			newdir = fname('~/.Trash',gsub(" ","_",Sys.time())) # so we don't overwrite in trash which could be bad
			newdir = gsub(":","-",newdir)
			if (!file.exists(newdir)){
				dir.create(newdir)
			}
			star = gsub(" ","\\\\ ",fname(DIR,'*RDS'))
			system(sprintf("mv %s %s",star,newdir))
			saveRDS(DIR,fname(newdir,'0source_DIR.RDS'))
		}
	}
	for (obj in ls(envir=.GlobalEnv)){
    	saveRDS(get(obj),fname(DIR,sprintf("%s.RDS",obj)))
	}
}


getrds = function(DIR=getwd()){
	for (f in list.files(DIR)){
	    if (endsWith(f,'RDS'))
	    {
	        cat(sprintf ("loading %s file\n",f))
	        F = fname(DIR,f)
	        obj = strsplit(f,split='.RDS')[[1]]
	        assign(obj,readRDS(F),envir=.GlobalEnv)    
	    }
	}
}

#for (lib in libs){
#	if(lib %in% rownames(installed.packages()) == FALSE){
#		install(lib)
#	}
#	else {
#		library(lib,character.only=TRUE)
#		cat(sprintf("Loaded %s library\n",lib))
#	}
#}
