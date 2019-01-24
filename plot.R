plot_arh <- function(c,t,sp,symbol){

par(mar=c(5,4,4,5)+.1)
barplot(sp,col="grey",main=paste("Expression et probabilité d'épissage: ",symbol),xlab="",ylab="",las=2,ylim=c(0,max(sp)+0.1))
legend("topleft",col=c("red","blue"),lty=1,legend=c("C","T"))
par(new=TRUE)
plot(c,type="b",col="red",xaxt="n",yaxt="n",xlab="",ylab="")
par(new=TRUE)
plot(t,type="b",col="blue",xaxt="n",yaxt="n",xlab="",ylab="")
mtext("barplot : splicing probability",side=2,line=3)
axis(4)
mtext("lines : exon expression",side=4,line=3)
}