#!/usr/bin/env Rscript
library(tcltk)

GuiOpenFile <- function (filename="") {
	print(filename)
	if (filename == '') {
		filename = tclvalue(tkgetOpenFile(
			title ='Open file ...',
			filetypes = "{{Tab Files} {.tab}}   
			             {{CSV Files} {.csv}}   
			             {{All Files} *}"))
     }
     # check and do something with filename
     return(filename)
}

GuiExit <- function (tt) {
	res <- tkmessageBox(
		title = "Question ...", 
		message = "Really close the application?", icon = "question",
		type = "yesno")
	if (tclvalue(res)== "yes") {
		tkdestroy(tt)
	}
}
GuiAbout <- function () {
	tkmessageBox(
		title = "About ...", 
		message = "TkGui by Detlef Groth\nUniversity of Potsdam\n     2020", 
		icon = "info",
		type = "ok")
}

GuiStart <- function (filename='') {
	# toplevel
	tt=tktoplevel()
	tkwm.title(tt,"Fen Viewer - D. Groth")
	# standard menues
	topMenu<-tkmenu(tt,tearoff=FALSE)
	tkconfigure(tt,menu=topMenu)
	fileMenu<-tkmenu(topMenu, tearoff=FALSE)
    tkadd(topMenu, "cascade", label="File", 
           menu=fileMenu, underline=0)
	tkadd(fileMenu,"command",label="Open file ...",
	    command=function () GuiOpenFile(),underline=0)
	tkadd(fileMenu,"separator")    
    tkadd(fileMenu,"command",label="Exit",
		command=function() GuiExit(tt),     
		  underline=1)
    helpMenu<-tkmenu(topMenu, tearoff=FALSE)
    		  
    tkadd(topMenu, "cascade", label="Help", 
           menu=helpMenu, underline=0)
	tkadd(helpMenu,"command",label="About",
	    command=GuiAbout,underline=0)
	# mainframe with panedwindow
	mf=ttkframe(tt) # main application frame
	pw=ttkpanedwindow(mf,orient='horizontal')
	lw=ttktreeview(pw,columns=c('A','B'))
	rw=ttktreeview(pw,columns=c('C','D'))
	tkadd(pw,lw)
	tkadd(pw,rw)
	tkpack(pw,side='top',fill='both',expand=TRUE)
	tkpack(mf,side='top',fill='both',expand=TRUE)
	if (filename != '') {
		GuiOpenFile(filename)
	}    
	return(tt)
}
usage <- function () {
	cat("Applicationname by Detlef Groth, University of Potsdam\n")
	cat("Usage: ./tkgui.R [filename]\n")
}
main <- function () {
	args=commandArgs(trailingOnly=TRUE)
	if (length(args) == 0) {
		win=GuiStart()
		# mainloop, otherwise from Rscript app would close
		tkwait.window(win)
	} else {
		if (args[1] %in% c("-h","--help")) {
			usage()
		} else if (!file.exists(args[1])) {
			stop(paste("Error: file",args[1],"does not exists!"))
		} else {
			win=GuiStart(args[1])
			tkwait.window(win)
		}

	}
}
if (sys.nframe() == 0 & !interactive()) {
	main()
}
