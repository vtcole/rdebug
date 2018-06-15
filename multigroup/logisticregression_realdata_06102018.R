c1l0<-c("p45n25d0c1l0","p45n25d1c1l0","p25n25d0c1l0","p25n25d1c1l0","p45n50d0c1l0","p45n50d1c1l0","p25n50d0c1l0","p25n50d1c1l0","p45n100d0c1l0","p45n100d1c1l0","p25n100d0c1l0","p25n100d1c1l0")
c1l1<-c("p45n25d0c1l1","p45n25d1c1l1","p25n25d0c1l1","p25n25d1c1l1","p45n50d0c1l1","p45n50d1c1l1","p25n50d0c1l1","p25n50d1c1l1","p45n100d0c1l1","p45n100d1c1l1","p25n100d0c1l1","p25n100d1c1l1")
c2l0<-c("p45n25d0c2l0","p45n25d1c2l0","p25n25d0c2l0","p25n25d1c2l0","p45n50d0c2l0","p45n50d1c2l0","p25n50d0c2l0","p25n50d1c2l0","p45n100d0c2l0","p45n100d1c2l0","p25n100d0c2l0","p25n100d1c2l0")
c2l1<-c("p45n25d0c2l1","p45n25d1c2l1","p25n25d0c2l1","p25n25d1c2l1","p45n50d0c2l1","p45n50d1c2l1","p25n50d0c2l1","p25n50d1c2l1","p45n100d0c2l1","p45n100d1c2l1","p25n100d0c2l1","p25n100d1c2l1")
all.sets<-list(c1l0,c1l1,c2l0,c2l1)

names.c1l0<-c('ACY2','ACY3','ACY4','ACY6','ACY12','ACY14')
names.c1l1<-c('ACY1','ACY2','ACY3','ACY4','ACY5','ACY6','ACY7','ACY8','ACY9','ACY10','ACY12','ACY13','ACY14','ACY15','ACY18')
names.c2l0<-c('AMT10','AMT11','AMT12','AMT14','AMT16','AMT18')
names.c2l1<-c('AMT8','AMT9','AMT10','AMT11','AMT12','AMT13','AMT14','AMT15','AMT16','AMT17','AMT18')

all.names<-list(names.c1l0,names.c1l1,names.c2l0,names.c2l1)
full.names<-list(names.c1l1,names.c1l1,names.c2l1,names.c2l1)

gender.io.intercepts<-array(NA,dim=c(100,12,4))
gender.ud.intercepts<-array(NA,dim=c(100,12,4))
frat.io.intercepts<-array(NA,dim=c(100,12,4))
frat.ud.intercepts<-array(NA,dim=c(100,12,4))
gender.io.slopes<-array(NA,dim=c(100,12,4))
gender.ud.slopes<-array(NA,dim=c(100,12,4))
frat.io.slopes<-array(NA,dim=c(100,12,4))
frat.ud.slopes<-array(NA,dim=c(100,12,4))

# Main iterative model fitting function -----------------------------------
for (i in 1:4) {
  for (j in 1:12) {
    for (r in 1:100) {
      the.filename.io<-paste0("C:/Users/vcole/Desktop/aim2/",all.sets[[i]][j],"/",all.sets[[i]][j],"_r",r,"_io_v.dat")
      the.filename.ud<-paste0("C:/Users/vcole/Desktop/aim2/",all.sets[[i]][j],"/",all.sets[[i]][j],"_r",r,"_ud_v.dat")
      if (file.exists(the.filename.io)==1&file.exists(the.filename.ud)==1) {
        indata.io<-NA
        indata.ud<-NA
        indata.io<-try(read.table(the.filename.io,header=FALSE,na="*"),silent=TRUE) #Read in one of the data files, as currently formatted for Mplus,silent=TRUE
        indata.ud<-try(read.table(the.filename.ud,header=FALSE,na="*"),silent=TRUE) #Read in one of the data files, as currently formatted for Mplus
        if (class(indata.io)!="try-error"& class(indata.ud)!="try-error") {
          names(indata.io)<-c(all.names[[i]],"t1","t2","t3","t4","id","gender","frat","dx","p1","p2","p3","p4","c")
          names(indata.ud )<-c(all.names[[i]],"t1","t2","t3","t4","id","gender","frat","dx","p1","p2","p3","p4","c")
          indata.io$estclass<-NA
          #Just doing study 2 here
          #indata.io$estclass[indata.io$c==1]<-1
          #indata.io$estclass[indata.io$c==2]<-0
          indata.io$estclass[indata.io$c==3]<-1
          indata.io$estclass[indata.io$c==4]<-0
          indata.ud$estclass<-NA
          #indata.ud$estclass[indata.ud$c==1]<-1
          #indata.ud$estclass[indata.ud$c==2]<-0
          indata.ud$estclass[indata.ud$c==3]<-1
          indata.ud$estclass[indata.ud$c==4]<-0
          
          gender.io<-glm(estclass~gender,data=indata.io,family="binomial")
          gender.ud<-glm(estclass~gender,data=indata.ud,family="binomial")      
          frat.io<-glm(estclass~frat,data=indata.io,family="binomial")
          frat.ud<-glm(estclass~frat,data=indata.ud,family="binomial")    
          
          gender.io.intercepts[r,j,i]<-gender.io$coef[1]
          gender.ud.intercepts[r,j,i]<-gender.ud$coef[1]
          frat.io.intercepts[r,j,i]<-frat.io$coef[1]
          frat.ud.intercepts[r,j,i]<-frat.ud$coef[1]
          
          gender.io.slopes[r,j,i]<-gender.io$coef[2]
          gender.ud.slopes[r,j,i]<-gender.ud$coef[2]
          frat.io.slopes[r,j,i]<-frat.io$coef[2]
          frat.ud.slopes[r,j,i]<-frat.ud$coef[2]
        }
        }
    }
  }
}