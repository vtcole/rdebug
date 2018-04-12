
indata<-read.csv("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/acy_d0i0l0/acy_d0i0l0_r5.csv",header=FALSE) #Read in one of the data files, as currently formatted for Mplus
names(indata)<-c("Dx","ID","ACY1","ACY2","ACY3","ACY4","ACY5","ACY6","ACY7","ACY8","ACY9","ACY10","ACY12","ACY13","ACY14","ACY15","ACY18","NumberHits","study","R","T1original","T2original")

###Training data
###Note that T1original and T2original are the corresponding training values in the MIMIC solution
indata$T1<-0
indata$T2<-0
indata$T3<-0
indata$T4<-0

#Study 1, diagnosed. If you are in Study 1 and have AUD, you can only be a member of class 1, so T1=1, T2=0, T3=0, T4=0.
indata$T1[indata$study==1&indata$Dx==1]<-1
#Study 1, undiagnosed. If you are in Study 1 and do not have AUD, you can only be a member of class 2, so T1=0, T2=1, T3=0, T4=0.
indata$T2[indata$study==1&indata$Dx==0]<-1
#Study 2, diagnosed or undiagnosed. You can be in class 3, is diagnosed for Study 2, or class 4, which is undiagnosed for Study 2. So T1=0, T2=0, T3=1, and T4=1. 
indata$T3[indata$study==2]<-1
indata$T4[indata$study==2]<-1


gender.p<-c(0.4285714, 0.4871795)
frat.p<-c(0.1889401, 0.3128205)

indata$gender<-NA
indata$frat<-NA
for (a in 1:nrow(indata)) {
  if (indata$Dx[a]==0) {
    indata$gender[a]<-rbinom(1,1,gender.p[1])
    indata$frat[a]<-rbinom(1,1,frat.p[1])
  }
  if (indata$Dx[a]==1) {
    indata$gender[a]<-rbinom(1,1,gender.p[2])
    indata$frat[a]<-rbinom(1,1,frat.p[2])
  }
}

write.table(indata,"C:/Users/vcole/Dropbox/x2/MGcheck/multigroup/acy_d0i0l0_r5_multigroup.csv",sep=",",row.names=FALSE,col.names=FALSE,na=".")