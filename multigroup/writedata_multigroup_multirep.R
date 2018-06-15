
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
the.datafile.vermunt<-("C:/Users/vcole/Dropbox/x2/MGcheck/multigroup/cprobs_04122018.dat")


qlogit<-MplusAutomation::readModels("C:/Users/vcole/Dropbox/x2/MGcheck/multigroup/multigroup_04122018.out")$class_counts$logitProbs.mostLikely

the.l33<-paste0("   [N#3@",qlogit[3,3],"];")
the.l43<-paste0("   [N#3@",qlogit[4,3],"];")

the.usevars<-paste0("USEVARIABLES ARE GENDER T1 T2 T3 T4 N;")
the.input.text<-paste(
  "TITLE:  Test run to get D matrix;",
  "DATA:  FILE IS",paste0(the.datafile.vermunt,";"),
  "FORMAT=FREE;",
  "VARIABLE:",
  "    NAMES ARE ACY2 ACY3 ACY4 ACY6 ACY12 ACY14 T1 T2 T3 T4 ID",
  "    GENDER CPROB1 CPROB2 CPROB3 CPROB4 N;",
  "    USEVARIABLES ARE N GENDER;",
  "    NOMINAL = N;",
  "    CLASSES = C(4);",
  "    MISSING are all .;",
  "    IDVARIABLE = ID;",
  "ANALYSIS:",
  "    TYPE = MIXTURE;",
  "    STARTS = 0;",
  "MODEL:",
  "    %OVERALL%",
  "    c ON gender;",
  "    %C#1%",
  "    [N#1@15];",
  "    [N#2@-15];",
  "    [N#3@-15];",
  "    %C#2%",
  "    [N#1@-15];",
  "    [N#2@15];",
  "    [N#3@-15];",
  "    %C#3%",
  "    [N#1@-15];",
  "    [N#2@-15];",
  the.l33,
  "    %C#4%",
  "    [N#1@-15];",
  "    [N#2@-15];",
  the.l43,
  sep="\n")  

the.input.name<-paste('C:/Users/vcole/Dropbox/x2/MGcheck/multigroup/mg_test.inp',sep="")
the.input<-file(the.input.name)
writeLines(the.input.text, the.input)
close(the.input)


cprobs<-read.table("C:/Users/vcole/Dropbox/x2/MGcheck/multigroup/cprobs_04122018_dx.dat",header=FALSE)
names(cprobs)<-c("ACY2","ACY3","ACY4","ACY6","ACY12","ACY14", "T1","T2","T3","T4","DX","CPROB1","CPROB2","CPROB3","CPROB4","N")

#Create the misclassification probability matrix as defined in Asparouhov and Muthen (2014).
#First, we create the class probability membership matrix (Pmat), and then we use this to create the class probability membership matrix (Qmat).
#If you have made it this far without finding the code problem, it might be worth it to look at Asparouhov and Muthen, 2014. I'll send this. 
Pmat<-diag(4)
Qmat<-diag(4)

Ns<-table(cprobs$N)

df.1<-subset(cprobs,cprobs$N==1)
df.2<-subset(cprobs,cprobs$N==2)
df.3<-subset(cprobs,cprobs$N==3)
df.4<-subset(cprobs,cprobs$N==4)

justclasses<-cprobs[c("N")]
justprobs<-cprobs[,c("CPROB1","CPROB2","CPROB3","CPROB4")]

#We know that Class 1 is AUD, so Class 3 is AUD
#We know that Class 2 is non-AUD, so Class 4 is non-AUD

for (p in 1:4) {
  for (q in 1:4) {
    Pmat[q,p]<-mean(subset(justprobs[,p],justclasses==q))
  }
}

Qmat<-matrix(NA,ncol=4,nrow=4)
for (p in 1:4) {
   for (q in 1:4) {
     Qmat[p,q]<-(Pmat[q,p]*Ns[q])/sum(Pmat[,p]*Ns)
   }
 }

logitmat<-matrix(-15,4,3)
logitmat[1,1]<-15
logitmat[2,2]<-15
logitmat[3,3]<-log(Qmat[3,3]/(1-Qmat[3,3]))
logitmat[4,3]<-log(Qmat[4,3]/(1-Qmat[4,3]))