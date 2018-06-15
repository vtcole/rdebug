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
