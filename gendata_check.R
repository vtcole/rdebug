#The purpose of this code is to generate synthetic data corresponding to alcohol motives and consequences.
#First, it reads in logit parameters linking each of the indicators to AUD diagnosis for:
#motives in the no-DIF scenario (amt_1.dat); motives in the DIF scenario (amt_3.dat);
#consequences in the no-DIF scenario (acy_1.dat); and consequences in the DIF scenario);
#Then it generates data for every combination of:
#Alcohol motives (amt) and consequences (acy);
#DIF (d1) and no DIF (d0);
#impact (i1) and no impact (i0); and
#longform (l1) and short form (l0).
#In the full data generation we also vary the amount of training data, but this is a subsetted version for troubleshooting.

require(sas7bdat)
require(MplusAutomation)

#AMT, 1
amt.1<-scan("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/amt_1.dat")
amt.c1.list<-seq(1,41,by=4)
amt.c2.list<-seq(45,85,by=4)

problist.amt1.1<-matrix(NA,length(amt.c1.list),5)
problist.amt1.2<-matrix(NA,length(amt.c2.list),5)

for (i in 1:length(amt.c1.list)) {
  list.1<-amt.c1.list[i]:(amt.c1.list[i]+3)
  list.2<-amt.c2.list[i]:(amt.c2.list[i]+3)
  
  a.11<-1/(1+exp(amt.1[list.1[1]]))
  a.12<-1/(1+exp(amt.1[list.1[2]]))
  a.13<-1/(1+exp(amt.1[list.1[3]]))
  a.14<-1/(1+exp(amt.1[list.1[4]]))
  
  p.11<-1-a.11
  p.12<-(1-a.12)-(1-a.11)
  p.13<-(1-a.13)-(1-a.12)
  p.14<-(1-a.14)-(1-a.13)
  p.15<-1-(p.14+p.13+p.12+p.11)
  
  
  a.21<-1/(1+exp(amt.1[list.2[1]]))
  a.22<-1/(1+exp(amt.1[list.2[2]]))
  a.23<-1/(1+exp(amt.1[list.2[3]]))
  a.24<-1/(1+exp(amt.1[list.2[4]]))
  
  p.21<-1-a.21
  p.22<-(1-a.22)-(1-a.21)
  p.23<-(1-a.23)-(1-a.22)
  p.24<-(1-a.24)-(1-a.23)
  p.25<-1-(p.24+p.23+p.22+p.21)
  
  problist.amt1.1[i,]<-c(p.11,p.12,p.13,p.14,p.15)
  problist.amt1.2[i,]<-c(p.21,p.22,p.23,p.24,p.25)
  
}

#AMT, 3
amt.3<-scan("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/amt_3.dat")
amt.c1.list<-seq(1,41,by=4)
amt.c2.list<-seq(45,85,by=4)

problist.amt3.1<-matrix(NA,length(amt.c1.list),5)
problist.amt3.2<-matrix(NA,length(amt.c2.list),5)

for (i in 1:length(amt.c1.list)) {
  list.1<-amt.c1.list[i]:(amt.c1.list[i]+3)
  list.2<-amt.c2.list[i]:(amt.c2.list[i]+3)
  
  a.11<-1/(1+exp(amt.3[list.1[1]]))
  a.12<-1/(1+exp(amt.3[list.1[2]]))
  a.13<-1/(1+exp(amt.3[list.1[3]]))
  a.14<-1/(1+exp(amt.3[list.1[4]]))
  
  p.11<-1-a.11
  p.12<-(1-a.12)-(1-a.11)
  p.13<-(1-a.13)-(1-a.12)
  p.14<-(1-a.14)-(1-a.13)
  p.15<-1-(p.14+p.13+p.12+p.11)
  
  
  a.21<-1/(1+exp(amt.3[list.2[1]]))
  a.22<-1/(1+exp(amt.3[list.2[2]]))
  a.23<-1/(1+exp(amt.3[list.2[3]]))
  a.24<-1/(1+exp(amt.3[list.2[4]]))
  
  p.21<-1-a.21
  p.22<-(1-a.22)-(1-a.21)
  p.23<-(1-a.23)-(1-a.22)
  p.24<-(1-a.24)-(1-a.23)
  p.25<-1-(p.24+p.23+p.22+p.21)
  
  problist.amt3.1[i,]<-c(p.11,p.12,p.13,p.14,p.15)
  problist.amt3.2[i,]<-c(p.21,p.22,p.23,p.24,p.25)
  
}


#ACY, 1
acy.1<-scan("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/acy_1.dat")
problist.acy1.1<-1/(1+exp(acy.1[1:15]))
problist.acy1.2<-1/(1+exp(acy.1[16:30]))

#ACY, 3
acy.3<-scan("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/acy_3.dat")
problist.acy3.1<-1/(1+exp(acy.3[1:15]))
problist.acy3.2<-1/(1+exp(acy.3[16:30]))


amt.function<-function(impact,DIF,longform) {
  for (reps in 1:100) {
    the.mat<-matrix(NA,250,11)
    study<-c(rep(1,50),rep(2,200))
    if (impact==1) {
      dx<-c(rbinom(50,1,.25),rbinom(200,1,.45))
    } else {dx<-c(rbinom(50,1,.25),rbinom(200,1,.45))
    }
    t1<-c(dx[1:50],rep(1,200))
    t2<-c(1-dx[1:50],rep(1,200))
    if (DIF==0) {
      for (q in 1:250) {
        if (dx[q]==0) {the.prob<-problist.amt1.1} else {the.prob<-problist.amt1.2}
        for (r in 1:11) {
          the.mat[q,r]<-c(1,2,3,4,5)%*%rmultinom(1,1,the.prob[r,])
        }
      }
    } else {
      for (q in 1:250) {
        if (dx[q]==0) {the.prob<-problist.amt3.1}
        else {the.prob<-problist.amt3.2}
        for (r in 1:11) {
          the.mat[q,r]<-c(1,2,3,4,5)%*%rmultinom(1,1,the.prob[r,])
        }
      }
    }
    id<-1:250
    numberhits<-rep(0,250) #Null, doesn't matter, just putting it in to concord with original version
    the.reps<-rep(reps,250)
    the.out<-cbind(dx,id,the.mat,numberhits,study,the.reps,t1,t2)
    write.table(the.out,paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/amt_d",DIF,"i",impact,"l",longform,"/amt_d",DIF,"i",impact,"l",longform,"_r",reps,".csv"),sep=",",row.names=FALSE,col.names=FALSE)
  }
}

amt.function(0,0,0)
amt.function(0,0,1)
amt.function(0,1,0)
amt.function(0,1,1)
amt.function(1,0,0)
amt.function(1,0,1)
amt.function(1,1,0)
amt.function(1,1,1)

acy.function<-function(impact,DIF,longform) {
  for (reps in 1:100) {
    the.mat<-matrix(NA,250,15)
    study<-c(rep(1,50),rep(2,200))
    if (impact==1) {
      dx<-c(rbinom(50,1,.25),rbinom(200,1,.45))
    } else {dx<-c(rbinom(50,1,.25),rbinom(200,1,.45))
    }
    t1<-c(dx[1:50],rep(1,200))
    t2<-c(1-dx[1:50],rep(1,200))
    if (DIF==0) {
      for (q in 1:250) {
        if (dx[q]==0) {the.prob<-problist.acy1.1} else {the.prob<-problist.acy1.2}
        for (r in 1:15) {
          the.mat[q,r]<-rbinom(1,1,the.prob[r])
        }
      }
    } else {
      for (q in 1:250) {
        if (dx[q]==0) {the.prob<-problist.acy3.1} else {the.prob<-problist.acy3.2}
        for (r in 1:15) {
          the.mat[q,r]<-rbinom(1,1,the.prob[r])
        }
      }
    }
    id<-1:250
    numberhits<-rep(0,250) #Null, doesn't matter, just putting it in to concord with original version
    the.reps<-rep(reps,250)
    the.out<-cbind(dx,id,the.mat,numberhits,study,the.reps,t1,t2)
    write.table(the.out,paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/acy_d",DIF,"i",impact,"l",longform,"/acy_d",DIF,"i",impact,"l",longform,"_r",reps,".csv"),sep=",",row.names=FALSE,col.names=FALSE)
  }
}


acy.function(0,0,0)
acy.function(0,0,1)
acy.function(0,1,0)
acy.function(0,1,1)
acy.function(1,0,0)
acy.function(1,0,1)
acy.function(1,1,0)
acy.function(1,1,1)

