
```{r,echo=FALSE}
c1l0<-c("i0d0c1l0n25","i0d1c1l0n25","i1d0c1l0n25","i1d1c1l0n25","i0d0c1l0n50","i0d1c1l0n50","i1d0c1l0n50","i1d1c1l0n50","i0d0c1l0n100","i0d1c1l0n100","i1d0c1l0n100","i1d1c1l0n100")
c1l1<-c("i0d0c1l1n25","i0d1c1l1n25","i1d0c1l1n25","i1d1c1l1n25","i0d0c1l1n50","i0d1c1l1n50","i1d0c1l1n50","i1d1c1l1n50","i0d0c1l1n100","i0d1c1l1n100","i1d0c1l1n100","i1d1c1l1n100")
c2l0<-c("i0d0c2l0n25","i0d1c2l0n25","i1d0c2l0n25","i1d1c2l0n25","i0d0c2l0n50","i0d1c2l0n50","i1d0c2l0n50","i1d1c2l0n50","i0d0c2l0n100","i0d1c2l0n100","i1d0c2l0n100","i1d1c2l0n100")
c2l1<-c("i0d0c2l1n25","i0d1c2l1n25","i1d0c2l1n25","i1d1c2l1n25","i0d0c2l1n50","i0d1c2l1n50","i1d0c2l1n50","i1d1c2l1n50","i0d0c2l1n100","i0d1c2l1n100","i1d0c2l1n100","i1d1c2l1n100")
all.sets<-list(c1l0,c1l1,c2l0,c2l1)

names.c1l0<-c('ACY2','ACY3','ACY4','ACY6','ACY12','ACY14')
names.c1l1<-c('ACY1','ACY2','ACY3','ACY4','ACY5','ACY6','ACY7','ACY8','ACY9','ACY10','ACY12','ACY13','ACY14','ACY15','ACY18')
names.c2l0<-c('AMT10','AMT11','AMT12','AMT14','AMT16','AMT18')
names.c2l1<-c('AMT8','AMT9','AMT10','AMT11','AMT12','AMT13','AMT14','AMT15','AMT16','AMT17','AMT18')

all.names<-list(names.c1l0,names.c1l1,names.c2l0,names.c2l1)
full.names<-list(names.c1l1,names.c1l1,names.c2l1,names.c2l1)


library(MplusAutomation)



# Intercept-only models ---------------------------------------------------
c1.test.v.io.frat<-array(NA,dim=c(100,12,4))
c3.test.v.io.frat<-array(NA,dim=c(100,12,4))
c1.test.bch.io.frat<-array(NA,dim=c(100,12,4))
c3.test.bch.io.frat<-array(NA,dim=c(100,12,4))
c1.test.v.io.gender<-array(NA,dim=c(100,12,4))
c3.test.v.io.gender<-array(NA,dim=c(100,12,4))
c1.test.bch.io.gender<-array(NA,dim=c(100,12,4))
c3.test.bch.io.gender<-array(NA,dim=c(100,12,4))

for (i in 1:4){
  for (j in 1:12) {
    for (r in 1:100) {
      the.output.v.io.frat<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_io_r",r,"_v_frat.out"))$parameters
      #the.output.bch.io.frat<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_io_r",r,"_bch_frat.out"))$parameters
      the.output.v.io.gender<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_io_r",r,"_v_gender.out"))$parameters
      #the.output.bch.io.gender<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_io_r",r,"_bch_gender.out"))$parameters
      if (length(the.output.v.io.frat)>0) {
        c1.4.v.io.frat<-subset(the.output.v.io.frat$unstandardized$est,the.output.v.io.frat$unstandardized$paramHeader=="C#1.ON")
        c2.4.v.io.frat<-subset(the.output.v.io.frat$unstandardized$est,the.output.v.io.frat$unstandardized$paramHeader=="C#2.ON")
        c3.4.v.io.frat<-subset(the.output.v.io.frat$unstandardized$est,the.output.v.io.frat$unstandardized$paramHeader=="C#3.ON")
        c1.test.v.io.frat[r,j,i]<-c1.4.v.io.frat-c2.4.v.io.frat
        c3.test.v.io.frat[r,j,i]<-c3.4.v.io.frat
      }
      #if (length(the.output.bch.io.frat)>0) {
      #  c1.4.bch.io.frat<-subset(the.output.bch.io.frat$unstandardized$est,the.output.bch.io.frat$unstandardized$paramHeader=="C#1.ON")
      #  c2.4.bch.io.frat<-subset(the.output.bch.io.frat$unstandardized$est,the.output.bch.io.frat$unstandardized$paramHeader=="C#2.ON")
      #  c3.4.bch.io.frat<-subset(the.output.bch.io.frat$unstandardized$est,the.output.bch.io.frat$unstandardized$paramHeader=="C#3.ON")
      #  c1.test.bch.io.frat[r,j,i]<-c1.4.bch.io.frat-c2.4.bch.io.frat
      #  c3.test.bch.io.frat[r,j,i]<-c3.4.bch.io.frat
      #}
      if (length(the.output.v.io.gender)>0) {
        c1.4.v.io.gender<-subset(the.output.v.io.gender$unstandardized$est,the.output.v.io.gender$unstandardized$paramHeader=="C#1.ON")
        c2.4.v.io.gender<-subset(the.output.v.io.gender$unstandardized$est,the.output.v.io.gender$unstandardized$paramHeader=="C#2.ON")
        c3.4.v.io.gender<-subset(the.output.v.io.gender$unstandardized$est,the.output.v.io.gender$unstandardized$paramHeader=="C#3.ON")
        c1.test.v.io.gender[r,j,i]<-c1.4.v.io.gender-c2.4.v.io.gender
        c3.test.v.io.gender[r,j,i]<-c3.4.v.io.gender
      }
      #if (length(the.output.bch.io.gender)>0) {
      #  c1.4.bch.io.gender<-subset(the.output.bch.io.gender$unstandardized$est,the.output.bch.io.gender$unstandardized$paramHeader=="C#1.ON")
      #  c2.4.bch.io.gender<-subset(the.output.bch.io.gender$unstandardized$est,the.output.bch.io.gender$unstandardized$paramHeader=="C#2.ON")
      #  c3.4.bch.io.gender<-subset(the.output.bch.io.gender$unstandardized$est,the.output.bch.io.gender$unstandardized$paramHeader=="C#3.ON")
      #  c1.test.bch.io.gender[r,j,i]<-c1.4.bch.io.gender-c2.4.bch.io.gender
      #  c3.test.bch.io.gender[r,j,i]<-c3.4.bch.io.gender
      #}
    }
  }
}


c1l0<-c("i0d0c1l0n25","i0d1c1l0n25","i1d0c1l0n25","i1d1c1l0n25","i0d0c1l0n50","i0d1c1l0n50","i1d0c1l0n50","i1d1c1l0n50","i0d0c1l0n100","i0d1c1l0n100","i1d0c1l0n100","i1d1c1l0n100")
c1l1<-c("i0d0c1l1n25","i0d1c1l1n25","i1d0c1l1n25","i1d1c1l1n25","i0d0c1l1n50","i0d1c1l1n50","i1d0c1l1n50","i1d1c1l1n50","i0d0c1l1n100","i0d1c1l1n100","i1d0c1l1n100","i1d1c1l1n100")
c2l0<-c("i0d0c2l0n25","i0d1c2l0n25","i1d0c2l0n25","i1d1c2l0n25","i0d0c2l0n50","i0d1c2l0n50","i1d0c2l0n50","i1d1c2l0n50","i0d0c2l0n100","i0d1c2l0n100","i1d0c2l0n100","i1d1c2l0n100")
c2l1<-c("i0d0c2l1n25","i0d1c2l1n25","i1d0c2l1n25","i1d1c2l1n25","i0d0c2l1n50","i0d1c2l1n50","i1d0c2l1n50","i1d1c2l1n50","i0d0c2l1n100","i0d1c2l1n100","i1d0c2l1n100","i1d1c2l1n100")
all.sets<-list(c1l0,c1l1,c2l0,c2l1)

title.list<-c("Consequences, Long","Consequences, Short"," Motives, Long","Motives, Short")

#trimmed.bch.io.frat<-c3.test.bch.io.frat
#trimmed.bch.io.gender<-c3.test.bch.io.gender
trimmed.v.io.frat<-c3.test.v.io.frat
trimmed.v.io.gender<-c3.test.v.io.gender

for (a in 1:100) {
  for (b in 1:12) {
    for (d in 1:4) {
      #if ((is.na(c3.test.bch.io.frat[a,b,d])==FALSE)&(abs(c3.test.bch.io.frat[a,b,d])>10))
      #{trimmed.bch.io.frat[a,b,d]<-NA}
      #if ((is.na(c3.test.bch.io.gender[a,b,d])==FALSE)&(abs(c3.test.bch.io.gender[a,b,d])>10))
      #{trimmed.bch.io.gender[a,b,d]<-NA}
      if ((is.na(c3.test.v.io.frat[a,b,d])==FALSE)&(abs(c3.test.v.io.frat[a,b,d])>10))
      {trimmed.v.io.frat[a,b,d]<-NA}
      if ((is.na(c3.test.v.io.gender[a,b,d])==FALSE)&(abs(c3.test.v.io.gender[a,b,d])>10))
      {trimmed.v.io.gender[a,b,d]<-NA}
    }
  }
}


# Uniform DIF models ---------------------------------------------------
c1.test.v.ud.frat<-array(NA,dim=c(100,12,4))
c3.test.v.ud.frat<-array(NA,dim=c(100,12,4))
c1.test.bch.ud.frat<-array(NA,dim=c(100,12,4))
c3.test.bch.ud.frat<-array(NA,dim=c(100,12,4))
c1.test.v.ud.gender<-array(NA,dim=c(100,12,4))
c3.test.v.ud.gender<-array(NA,dim=c(100,12,4))
c1.test.bch.ud.gender<-array(NA,dim=c(100,12,4))
c3.test.bch.ud.gender<-array(NA,dim=c(100,12,4))

for (i in 1:4){
  for (j in 1:12) {
    for (r in 1:100) {
      the.output.v.ud.frat<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_ud_r",r,"_v_frat.out"))$parameters
      #the.output.bch.ud.frat<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_ud_r",r,"_bch_frat.out"))$parameters
      the.output.v.ud.gender<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_ud_r",r,"_v_gender.out"))$parameters
      #the.output.bch.ud.gender<-readModels(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/",all.sets[[i]][j],"/",all.sets[[i]][j],"_ud_r",r,"_bch_gender.out"))$parameters
      if (length(the.output.v.ud.frat)>0) {
        c1.4.v.ud.frat<-subset(the.output.v.ud.frat$unstandardized$est,the.output.v.ud.frat$unstandardized$paramHeader=="C#1.ON")
        c2.4.v.ud.frat<-subset(the.output.v.ud.frat$unstandardized$est,the.output.v.ud.frat$unstandardized$paramHeader=="C#2.ON")
        c3.4.v.ud.frat<-subset(the.output.v.ud.frat$unstandardized$est,the.output.v.ud.frat$unstandardized$paramHeader=="C#3.ON")
        c1.test.v.ud.frat[r,j,i]<-c1.4.v.ud.frat-c2.4.v.ud.frat
        c3.test.v.ud.frat[r,j,i]<-c3.4.v.ud.frat
      }
      #if (length(the.output.bch.ud.frat)>0) {
      #  c1.4.bch.ud.frat<-subset(the.output.bch.ud.frat$unstandardized$est,the.output.bch.ud.frat$unstandardized$paramHeader=="C#1.ON")
      #  c2.4.bch.ud.frat<-subset(the.output.bch.ud.frat$unstandardized$est,the.output.bch.ud.frat$unstandardized$paramHeader=="C#2.ON")
      #  c3.4.bch.ud.frat<-subset(the.output.bch.ud.frat$unstandardized$est,the.output.bch.ud.frat$unstandardized$paramHeader=="C#3.ON")
      #  c1.test.bch.ud.frat[r,j,i]<-c1.4.bch.ud.frat-c2.4.bch.ud.frat
      #  c3.test.bch.ud.frat[r,j,i]<-c3.4.bch.ud.frat
      #}
      if (length(the.output.v.ud.gender)>0) {
        c1.4.v.ud.gender<-subset(the.output.v.ud.gender$unstandardized$est,the.output.v.ud.gender$unstandardized$paramHeader=="C#1.ON")
        c2.4.v.ud.gender<-subset(the.output.v.ud.gender$unstandardized$est,the.output.v.ud.gender$unstandardized$paramHeader=="C#2.ON")
        c3.4.v.ud.gender<-subset(the.output.v.ud.gender$unstandardized$est,the.output.v.ud.gender$unstandardized$paramHeader=="C#3.ON")
        c1.test.v.ud.gender[r,j,i]<-c1.4.v.ud.gender-c2.4.v.ud.gender
        c3.test.v.ud.gender[r,j,i]<-c3.4.v.ud.gender
      }
      #if (length(the.output.bch.ud.gender)>0) {
        #c1.4.bch.ud.gender<-subset(the.output.bch.ud.gender$unstandardized$est,the.output.bch.ud.gender$unstandardized$paramHeader=="C#1.ON")
        #c2.4.bch.ud.gender<-subset(the.output.bch.ud.gender$unstandardized$est,the.output.bch.ud.gender$unstandardized$paramHeader=="C#2.ON")
        #c3.4.bch.ud.gender<-subset(the.output.bch.ud.gender$unstandardized$est,the.output.bch.ud.gender$unstandardized$paramHeader=="C#3.ON")
        #c1.test.bch.ud.gender[r,j,i]<-c1.4.bch.ud.gender-c2.4.bch.ud.gender
        #c3.test.bch.ud.gender[r,j,i]<-c3.4.bch.ud.gender
      #}
    }
  }
}


c1l0<-c("i0d0c1l0n25","i0d1c1l0n25","i1d0c1l0n25","i1d1c1l0n25","i0d0c1l0n50","i0d1c1l0n50","i1d0c1l0n50","i1d1c1l0n50","i0d0c1l0n100","i0d1c1l0n100","i1d0c1l0n100","i1d1c1l0n100")
c1l1<-c("i0d0c1l1n25","i0d1c1l1n25","i1d0c1l1n25","i1d1c1l1n25","i0d0c1l1n50","i0d1c1l1n50","i1d0c1l1n50","i1d1c1l1n50","i0d0c1l1n100","i0d1c1l1n100","i1d0c1l1n100","i1d1c1l1n100")
c2l0<-c("i0d0c2l0n25","i0d1c2l0n25","i1d0c2l0n25","i1d1c2l0n25","i0d0c2l0n50","i0d1c2l0n50","i1d0c2l0n50","i1d1c2l0n50","i0d0c2l0n100","i0d1c2l0n100","i1d0c2l0n100","i1d1c2l0n100")
c2l1<-c("i0d0c2l1n25","i0d1c2l1n25","i1d0c2l1n25","i1d1c2l1n25","i0d0c2l1n50","i0d1c2l1n50","i1d0c2l1n50","i1d1c2l1n50","i0d0c2l1n100","i0d1c2l1n100","i1d0c2l1n100","i1d1c2l1n100")
all.sets<-list(c1l0,c1l1,c2l0,c2l1)

title.list<-c("Consequences, Long","Consequences, Short"," Motives, Long","Motives, Short")

#trimmed.bch.ud.frat<-c3.test.bch.ud.frat
#trimmed.bch.ud.gender<-c3.test.bch.ud.gender
trimmed.v.ud.frat<-c3.test.v.ud.frat
trimmed.v.ud.gender<-c3.test.v.ud.gender

for (a in 1:100) {
  for (b in 1:12) {
    for (d in 1:4) {
      #if ((is.na(c3.test.bch.ud.frat[a,b,d])==FALSE)&(abs(c3.test.bch.ud.frat[a,b,d])>10))
      #{trimmed.bch.ud.frat[a,b,d]<-NA}
      #if ((is.na(c3.test.bch.ud.gender[a,b,d])==FALSE)&(abs(c3.test.bch.ud.gender[a,b,d])>10))
      #{trimmed.bch.ud.gender[a,b,d]<-NA}
      if ((is.na(c3.test.v.ud.frat[a,b,d])==FALSE)&(abs(c3.test.v.ud.frat[a,b,d])>10))
      {trimmed.v.ud.frat[a,b,d]<-NA}
      if ((is.na(c3.test.v.ud.gender[a,b,d])==FALSE)&(abs(c3.test.v.ud.gender[a,b,d])>10))
      {trimmed.v.ud.gender[a,b,d]<-NA}
    }
  }
}
```

#For columns: Do 1, 5, and 9 to get at no DIF no impact condition with N=25, N=50, and N=100, respectively
#For u indices: 1 through 4, 9 through 12 will be frat; 5 through 9, 13 through 16 will be gender
#Do we want to use u indices?

plot(-100,xlim=c(0,7.5),ylim=c(-2,2.25),xlab="",ylab="Bias",xaxt="n",main="Alcohol Consequences")
boxplot(trimmed.bch.frat[,1,1]-.6642,at=.25,col="white",add=TRUE)
boxplot(trimmed.bch.frat[,5,1]-.6642,at=.75,col="gray88",add=TRUE)
boxplot(trimmed.bch.frat[,9,1]-.6642,at=1.25,col="gray44",add=TRUE)
boxplot(trimmed.bch.frat[,1,2]-.6642,at=2.25,col="white",add=TRUE)
boxplot(trimmed.bch.frat[,5,2]-.6642,at=2.75,col="gray88",add=TRUE)
boxplot(trimmed.bch.frat[,9,2]-.6642,at=3.25,col="gray44",add=TRUE)
boxplot(trimmed.v.frat[,1,1]-.6642,at=4.25,col="white",add=TRUE)
boxplot(trimmed.v.frat[,5,1]-.6642,at=4.75,col="gray88",add=TRUE)
boxplot(trimmed.v.frat[,9,1]-.6642,at=5.25,col="gray44",add=TRUE)
boxplot(trimmed.v.frat[,1,2]-.6642,at=6.25,col="white",add=TRUE)
boxplot(trimmed.v.frat[,5,2]-.6642,at=6.75,col="gray88",add=TRUE)
boxplot(trimmed.v.frat[,9,2]-.6642,at=7.25,col="gray44",add=TRUE)
text(.75,-2,"BCH, Short",cex=.75)
text(2.75,-2,"BCH, Long",cex=.75)
text(4.75,-2,"Vermunt, Short",cex=.75)
text(6.75,-2,"Vermunt, Long",cex=.75)
abline(h=0,lwd=1.5)
abline(h=.066,lty=3)
abline(h=-.066,lty=3)
legend("top",legend=c("N=25","N=50","N=100"),fill=c("white","gray88","gray44"),horiz=TRUE,cex=.75,bty="n")