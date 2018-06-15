library(sas7bdat)
library(MplusAutomation)

#test<-read.sas7bdat("M:/xstudy2/Simulation/aim02/July2017/full.sas7bdat")
#write.table(test,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/full_mplus_12112017.dat",na=".",row.names=FALSE,col.names=FALSE)

#varlist<-c("AMT1A108","AMT1A109","AMT1A110","AMT1A111","AMT1A112","AMT1A113","AMT1A115","AMT1A116","AMT1A117","AMT1A118")
#in.model<-readModels("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/amt_3.out")

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


amt.function<-function(impact,n1,DIF,longform) {
  the.dir<-(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/i",impact,"d",DIF,"c2l",longform,"n",n1))
  if(dir.exists(the.dir)==0) {dir.create(the.dir)}
  for (reps in 1:500) {
    the.name<-(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/i",impact,"d",DIF,"c2l",longform,"n",n1,"/i",impact,"d",DIF,"c2l",longform,"n",n1,"_r",reps,".csv"))
    the.mat<-matrix(NA,200+n1,11)
    study<-c(rep(1,n1),rep(2,200))
    if (impact==1) {
      dx<-c(rbinom(n1,1,.25),rbinom(200,1,.45))
    } else {dx<-c(rbinom(n1,1,.25),rbinom(200,1,.45))
    }
    t1<-c(dx[1:n1],rep(1,200))
    t2<-c(1-dx[1:n1],rep(1,200))
    if (DIF==0) {
      for (q in 1:(200+n1)) {
        if (dx[q]==0) {the.prob<-problist.amt1.1} else {the.prob<-problist.amt1.2}
        for (r in 1:11) {
          the.mat[q,r]<-c(1,2,3,4,5)%*%rmultinom(1,1,the.prob[r,])
        }
      }
    } else {
      for (p in 1:n1) {
        if (dx[p]==0) {the.prob<-problist.amt1.1} else {the.prob<-problist.amt1.2}        
        for (r in 1:11) {
          the.mat[p,r]<-c(1,2,3,4,5)%*%rmultinom(1,1,the.prob[r,])
        }
      }
      for (q in (n1+1):(200+n1)) {
        if (dx[q]==0) {the.prob<-problist.amt3.1} else {the.prob<-problist.amt3.2}
        for (s in 1:11) {
          the.mat[q,s]<-c(1,2,3,4,5)%*%rmultinom(1,1,the.prob[s,])
        }
      }
    }
    id<-1:(200+n1)
    numberhits<-rep(0,200+n1) #Null, doesn't matter, just putting it in to concord with original version
    the.reps<-rep(reps,200+n1)
    the.out<-cbind(dx,id,the.mat,numberhits,study,the.reps,t1,t2)
    write.table(the.out,the.name,sep=",",row.names=FALSE,col.names=FALSE)
  }
}


amt.function(0,25,0,0)
amt.function(0,25,0,1)
amt.function(0,25,1,0)
amt.function(0,25,1,1)
amt.function(1,25,0,0)
amt.function(1,25,0,1)
amt.function(1,25,1,0)
amt.function(1,25,1,1)
amt.function(0,50,0,0)
amt.function(0,50,0,1)
amt.function(0,50,1,0)
amt.function(0,50,1,1)
amt.function(1,50,0,0)
amt.function(1,50,0,1)
amt.function(1,50,1,0)
amt.function(1,50,1,1)
amt.function(0,100,0,0)
amt.function(0,100,0,1)
amt.function(0,100,1,0)
amt.function(0,100,1,1)
amt.function(1,100,0,0)
amt.function(1,100,0,1)
amt.function(1,100,1,0)
amt.function(1,100,1,1)

acy.function<-function(impact,n1,DIF,longform) {
  the.dir<-(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/i",impact,"d",DIF,"c1l",longform,"n",n1))
  if(dir.exists(the.dir)==0) {dir.create(the.dir)}
  for (reps in 1:500) {
    the.name<-(paste0("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/rerun/i",impact,"d",DIF,"c1l",longform,"n",n1,"/i",impact,"d",DIF,"c1l",longform,"n",n1,"_r",reps,".csv"))
    the.mat<-matrix(NA,200+n1,15)
    study<-c(rep(1,n1),rep(2,200))
    if (impact==1) {
      dx<-c(rbinom(n1,1,.25),rbinom(200,1,.45))
    } else {dx<-c(rbinom(n1,1,.25),rbinom(200,1,.45))
    }
    t1<-c(dx[1:n1],rep(1,200))
    t2<-c(1-dx[1:n1],rep(1,200))
    if (DIF==0) {
      for (q in 1:(200+n1)) {
        if (dx[q]==0) {the.prob<-problist.acy1.1} else {the.prob<-problist.acy1.2}
        for (r in 1:15) {
          the.mat[q,r]<-rbinom(1,1,the.prob[r])
        }
      }
    } else {
      for (p in 1:n1) {
        if (dx[p]==0) {the.prob<-problist.acy3.1} else {the.prob<-problist.acy3.2}        
        for (r in 1:15) {
          the.mat[p,r]<-rbinom(1,1,the.prob[r])
        }
      }
      for (q in (n1+1):(200+n1)) {
        if (dx[q]==0) {the.prob<-problist.acy3.1} else {the.prob<-problist.acy3.2}
        for (s in 1:15) {
          the.mat[q,s]<-rbinom(1,1,the.prob[s])
        }
      }
    }
    id<-1:(200+n1)
    numberhits<-rep(0,200+n1) #Null, doesn't matter, just putting it in to concord with original version
    the.reps<-rep(reps,200+n1)
    the.out<-cbind(dx,id,the.mat,numberhits,study,the.reps,t1,t2)
    write.table(the.out,the.name,sep=",",row.names=FALSE,col.names=FALSE)
  }
}

acy.function(0,25,0,0)
acy.function(0,25,0,1)
acy.function(0,25,1,0)
acy.function(0,25,1,1)
acy.function(1,25,0,0)
acy.function(1,25,0,1)
acy.function(1,25,1,0)
acy.function(1,25,1,1)
acy.function(0,50,0,0)
acy.function(0,50,0,1)
acy.function(0,50,1,0)
acy.function(0,50,1,1)
acy.function(1,50,0,0)
acy.function(1,50,0,1)
acy.function(1,50,1,0)
acy.function(1,50,1,1)
acy.function(0,100,0,0)
acy.function(0,100,0,1)
acy.function(0,100,1,0)
acy.function(0,100,1,1)
acy.function(1,100,0,0)
acy.function(1,100,0,1)
acy.function(1,100,1,0)
acy.function(1,100,1,1)


