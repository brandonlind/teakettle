libs = c('tidyr','hash','SDMTools','dplyr')

len = length
uni = unique
sorted = sort

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

for (lib in libs){
	if(lib %in% rownames(installed.packages()) == FALSE){
		install(lib)
	}
	else {
		library(lib,character.only=TRUE)
		cat(sprintf("Loaded %s library\n",lib))
	}
}
