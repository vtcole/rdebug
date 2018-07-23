# c1l0<-c("p45n25d0c1l0","p45n25d1c1l0","p25n25d0c1l0","p25n25d1c1l0","p45n50d0c1l0","p45n50d1c1l0","p25n50d0c1l0","p25n50d1c1l0","p45n100d0c1l0","p45n100d1c1l0","p25n100d0c1l0","p25n100d1c1l0")
# c1l1<-c("p45n25d0c1l1","p45n25d1c1l1","p25n25d0c1l1","p25n25d1c1l1","p45n50d0c1l1","p45n50d1c1l1","p25n50d0c1l1","p25n50d1c1l1","p45n100d0c1l1","p45n100d1c1l1","p25n100d0c1l1","p25n100d1c1l1")
# c2l0<-c("p45n25d0c2l0","p45n25d1c2l0","p25n25d0c2l0","p25n25d1c2l0","p45n50d0c2l0","p45n50d1c2l0","p25n50d0c2l0","p25n50d1c2l0","p45n100d0c2l0","p45n100d1c2l0","p25n100d0c2l0","p25n100d1c2l0")
# c2l1<-c("p45n25d0c2l1","p45n25d1c2l1","p25n25d0c2l1","p25n25d1c2l1","p45n50d0c2l1","p45n50d1c2l1","p25n50d0c2l1","p25n50d1c2l1","p45n100d0c2l1","p45n100d1c2l1","p25n100d0c2l1","p25n100d1c2l1")
# all.sets<-list(c1l0,c1l1,c2l0,c2l1)
# 
# c1l0.v.io.gender<-cbind(1,trimmed.v.io.gender[,,1])
# c1l1.v.io.gender<-cbind(2,trimmed.v.io.gender[,,2])
# c2l0.v.io.gender<-cbind(3,trimmed.v.io.gender[,,3])
# c2l1.v.io.gender<-cbind(4,trimmed.v.io.gender[,,4])
# c1l0.v.io.frat<-cbind(1,trimmed.v.io.frat[,,1])
# c1l1.v.io.frat<-cbind(2,trimmed.v.io.frat[,,2])
# c2l0.v.io.frat<-cbind(3,trimmed.v.io.frat[,,3])
# c2l1.v.io.frat<-cbind(4,trimmed.v.io.frat[,,4])
# 
# v.io.gender<-rbind(c1l0.v.io.gender,c1l1.v.io.gender,c2l0.v.io.gender,c2l1.v.io.gender)
# v.io.frat<-rbind(c1l0.v.io.frat,c1l1.v.io.frat,c2l0.v.io.frat,c2l1.v.io.frat)
# 
# c1l0.v.ud.gender<-cbind(1,trimmed.v.ud.gender[,,1])
# c1l1.v.ud.gender<-cbind(2,trimmed.v.ud.gender[,,2])
# c2l0.v.ud.gender<-cbind(3,trimmed.v.ud.gender[,,3])
# c2l1.v.ud.gender<-cbind(4,trimmed.v.ud.gender[,,4])
# c1l0.v.ud.frat<-cbind(1,trimmed.v.ud.frat[,,1])
# c1l1.v.ud.frat<-cbind(2,trimmed.v.ud.frat[,,2])
# c2l0.v.ud.frat<-cbind(3,trimmed.v.ud.frat[,,3])
# c2l1.v.ud.frat<-cbind(4,trimmed.v.ud.frat[,,4])
# 
# v.ud.gender<-rbind(c1l0.v.ud.gender,c1l1.v.ud.gender,c2l0.v.ud.gender,c2l1.v.ud.gender)
# v.ud.frat<-rbind(c1l0.v.ud.frat,c1l1.v.ud.frat,c2l0.v.ud.frat,c2l1.v.ud.frat)
# 
# 
# write.table(v.io.gender,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_io_real_gender.dat",na=".",row.names=FALSE,col.names=TRUE)
# write.table(v.io.frat,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_io_real_frat.dat",na=".",row.names=FALSE,col.names=TRUE)
# write.table(v.ud.gender,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_ud_real_gender.dat",na=".",row.names=FALSE,col.names=TRUE)
# write.table(v.ud.frat,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_ud_real_frat.dat",na=".",row.names=FALSE,col.names=TRUE)
# 
# 
# 
# c1l0.v.io.gender<-cbind(1,gender.io.slopes[,,1])
# c1l1.v.io.gender<-cbind(2,gender.io.slopes[,,2])
# c2l0.v.io.gender<-cbind(3,gender.io.slopes[,,3])
# c2l1.v.io.gender<-cbind(4,gender.io.slopes[,,4])
# c1l0.v.io.frat<-cbind(1,frat.io.slopes[,,1])
# c1l1.v.io.frat<-cbind(2,frat.io.slopes[,,2])
# c2l0.v.io.frat<-cbind(3,frat.io.slopes[,,3])
# c2l1.v.io.frat<-cbind(4,frat.io.slopes[,,4])
# 
# v.io.gender<-rbind(c1l0.v.io.gender,c1l1.v.io.gender,c2l0.v.io.gender,c2l1.v.io.gender)
# v.io.frat<-rbind(c1l0.v.io.frat,c1l1.v.io.frat,c2l0.v.io.frat,c2l1.v.io.frat)
# 
# c1l0.v.ud.gender<-cbind(1,gender.ud.slopes[,,1])
# c1l1.v.ud.gender<-cbind(2,gender.ud.slopes[,,2])
# c2l0.v.ud.gender<-cbind(3,gender.ud.slopes[,,3])
# c2l1.v.ud.gender<-cbind(4,gender.ud.slopes[,,4])
# c1l0.v.ud.frat<-cbind(1,frat.ud.slopes[,,1])
# c1l1.v.ud.frat<-cbind(2,frat.ud.slopes[,,2])
# c2l0.v.ud.frat<-cbind(3,frat.ud.slopes[,,3])
# c2l1.v.ud.frat<-cbind(4,frat.ud.slopes[,,4])
# 
# v.ud.gender<-rbind(c1l0.v.ud.gender,c1l1.v.ud.gender,c2l0.v.ud.gender,c2l1.v.ud.gender)
# v.ud.frat<-rbind(c1l0.v.ud.frat,c1l1.v.ud.frat,c2l0.v.ud.frat,c2l1.v.ud.frat)
# 
# 
# write.table(v.io.gender,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_io_gender.dat",na=".",row.names=FALSE,col.names=TRUE)
# write.table(v.io.frat,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_io_frat.dat",na=".",row.names=FALSE,col.names=TRUE)
# write.table(v.ud.gender,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_ud_gender.dat",na=".",row.names=FALSE,col.names=TRUE)
# write.table(v.ud.frat,"M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_ud_frat.dat",na=".",row.names=FALSE,col.names=TRUE)

io.gender.lr<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_io_gender.dat",header=TRUE,na=".")
io.frat.lr<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_io_frat.dat",header=TRUE,na=".")
ud.gender.lr<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_ud_gender.dat",header=TRUE,na=".")
ud.frat.lr<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/LR_real_ud_frat.dat",header=TRUE,na=".")


io.gender.v<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_io_real_gender.dat",header=TRUE,na=".")
io.frat.v<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_io_real_frat.dat",header=TRUE,na=".")
ud.gender.v<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_ud_real_gender.dat",header=TRUE,na=".")
ud.frat.v<-read.table("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/v_ud_reafrat.dat",header=TRUE,na=".")


title.list<-c("Consequences, Long","Consequences, Short"," Motives, Long","Motives, Short")


nodif.noimpact.lr<-list(subset(io.frat.lr[,10],io.frat.lr[,1]==1),subset(io.frat.lr[,10],io.frat.lr[,1]==2),subset(io.frat.lr[,10],io.frat.lr[,1]==3),subset(io.frat.lr[,10],io.frat.lr[,1]==4))
unmodeleddif.noimpact.lr<-list(subset(io.frat.lr[,11],io.frat.lr[,1]==1),subset(io.frat.lr[,11],io.frat.lr[,1]==2),subset(io.frat.lr[,11],io.frat.lr[,1]==3),subset(io.frat.lr[,11],io.frat.lr[,1]==4))
modeleddif.noimpact.lr<-list(subset(ud.frat.lr[,11],ud.frat.lr[,1]==1),subset(ud.frat.lr[,11],ud.frat.lr[,1]==2),subset(ud.frat.lr[,11],ud.frat.lr[,1]==3),subset(ud.frat.lr[,11],ud.frat.lr[,1]==4))


nodif.noimpact.v<-list(subset(io.frat.v[,10],io.frat.v[,1]==1),subset(io.frat.v[,10],io.frat.v[,1]==2),subset(io.frat.v[,10],io.frat.v[,1]==3),subset(io.frat.v[,10],io.frat.v[,1]==4))
unmodeleddif.noimpact.v<-list(subset(io.frat.v[,11],io.frat.v[,1]==1),subset(io.frat.v[,11],io.frat.v[,1]==2),subset(io.frat.v[,11],io.frat.v[,1]==3),subset(io.frat.v[,11],io.frat.v[,1]==4))
modeleddif.noimpact.v<-list(subset(ud.frat.v[,11],ud.frat.v[,1]==1),subset(ud.frat.v[,11],ud.frat.v[,1]==2),subset(ud.frat.v[,11],ud.frat.v[,1]==3),subset(ud.frat.v[,11],ud.frat.v[,1]==4))


pdf("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/multigroup_noimpact_realdata_n100_05162018.pdf",width=14,height=10)
par(mfrow=c(2,2))
par(mar=c(1,4.5,3.5,3.5))
for (e in 1:4) {
  plot(-100,xlim=c(0,4),ylim=c(-2.5,2.5),xlab="",ylab="Bias",xaxt="n",main=title.list[[e]])
  abline(h=0,lwd=1)
  abline(h=.066,lty=2)
  abline(h=-.066,lty=2)
  abline(h=.6642,lty=3)
  abline(h=-.6642,lty=3)
  boxplot(nodif.noimpact.lr[[e]]-.6642,at=.5,add=TRUE,col="white")
  boxplot(unmodeleddif.noimpact.lr[[e]]-.6642,at=1,add=TRUE,col="gray88")
  boxplot(modeleddif.noimpact.lr[[e]]-.6642,at=1.5,add=TRUE,col="gray44")
  boxplot(nodif.noimpact.v[[e]]-.6642,at=2.5,add=TRUE,col="white")
  boxplot(unmodeleddif.noimpact.v[[e]]-.6642,at=3,add=TRUE,col="gray88")
  boxplot(modeleddif.noimpact.v[[e]]-.6642,at=3.5,add=TRUE,col="gray44")
  legend("bottom",legend=c("No DIF","DIF excluded","DIF included"),fill=c("white","gray88","gray44"),bty="n",horiz=TRUE)
  text(1,3,"Logistic")
  text(3,3,"Vermunt")
}
dev.off()



nodif.impact.lr<-list(subset(io.frat.lr[,12],io.frat.lr[,1]==1),subset(io.frat.lr[,12],io.frat.lr[,1]==2),subset(io.frat.lr[,12],io.frat.lr[,1]==3),subset(io.frat.lr[,12],io.frat.lr[,1]==4))
unmodeleddif.impact.lr<-list(subset(io.frat.lr[,13],io.frat.lr[,1]==1),subset(io.frat.lr[,13],io.frat.lr[,1]==2),subset(io.frat.lr[,13],io.frat.lr[,1]==3),subset(io.frat.lr[,13],io.frat.lr[,1]==4))
modeleddif.impact.lr<-list(subset(ud.frat.lr[,13],ud.frat.lr[,1]==1),subset(ud.frat.lr[,13],ud.frat.lr[,1]==2),subset(ud.frat.lr[,13],ud.frat.lr[,1]==3),subset(ud.frat.lr[,13],ud.frat.lr[,1]==4))

nodif.impact.v<-list(subset(io.frat.v[,12],io.frat.v[,1]==1),subset(io.frat.v[,12],io.frat.v[,1]==2),subset(io.frat.v[,12],io.frat.v[,1]==3),subset(io.frat.v[,12],io.frat.v[,1]==4))
unmodeleddif.impact.v<-list(subset(io.frat.v[,13],io.frat.v[,1]==1),subset(io.frat.v[,13],io.frat.v[,1]==2),subset(io.frat.v[,13],io.frat.v[,1]==3),subset(io.frat.v[,13],io.frat.v[,1]==4))
modeleddif.impact.v<-list(subset(ud.frat.v[,13],ud.frat.v[,1]==1),subset(ud.frat.v[,13],ud.frat.v[,1]==2),subset(ud.frat.v[,13],ud.frat.v[,1]==3),subset(ud.frat.v[,13],ud.frat.v[,1]==4))


pdf("M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/multigroup_impact_realdata_n100_05162018.pdf",width=14,height=10)
par(mfrow=c(2,2))
par(mar=c(1,4.5,3.5,3.5))
for (e in 1:4) {
  plot(-100,xlim=c(0,4),ylim=c(-2.5,2.5),xlab="",ylab="Bias",xaxt="n",main=title.list[[e]])
  abline(h=0,lwd=1)
  abline(h=.066,lty=2)
  abline(h=-.066,lty=2)
  abline(h=.6642,lty=3)
  abline(h=-.6642,lty=3)
  boxplot(nodif.impact.lr[[e]]-.6642,at=.5,add=TRUE,col="white")
  boxplot(unmodeleddif.impact.lr[[e]]-.6642,at=1,add=TRUE,col="gray88")
  boxplot(modeleddif.impact.lr[[e]]-.6642,at=1.5,add=TRUE,col="gray44")
  boxplot(nodif.impact.v[[e]]-.6642,at=2.5,add=TRUE,col="white")
  boxplot(unmodeleddif.impact.v[[e]]-.6642,at=3,add=TRUE,col="gray88")
  boxplot(modeleddif.impact.v[[e]]-.6642,at=3.5,add=TRUE,col="gray44")
  legend("bottom",legend=c("No DIF","DIF excluded","DIF included"),fill=c("white","gray88","gray44"),bty="n",horiz=TRUE)
  text(1,3,"Logistic")
  text(3,3,"Vermunt")
}
dev.off()