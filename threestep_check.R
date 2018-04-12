#We simulate two external variables, "gender" and "frat membership", to have the same relationship to AUD diagnosis as they do in REAL-U
#They are simulated from a contingency table; the first probability is the endorsement probability for non-AUD people and the second is the probability for AUD people.
gender.p<-c(0.4285714, 0.4871795)
frat.p<-c(0.1889401, 0.3128205)

#Read in all of the consequences/short form (c1l0); consequences/long form (c1l1); motives/short form (c2l0); and motives/long form (c2l1). 
#d0/1 = no DIF/DIF
#i0/1 = no impact/impact
#l0/1 = shortform/longform
c1l0<-c("acy_d0i0l0","acy_d0i1l0","acy_d1i0l0","acy_d1i1l0")
c1l1<-c("acy_d0i0l1","acy_d0i1l1","acy_d1i0l1","acy_d1i1l1")
c2l0<-c("amt_d0i0l0","amt_d0i1l0","amt_d1i0l0","amt_d1i1l0")
c2l1<-c("amt_d0i0l1","amt_d0i1l1","amt_d1i0l1","amt_d1i1l1")

all.sets<-list(c1l0,c1l1,c2l0,c2l1)

#Set variable names
names.c1l0<-c('ACY2','ACY3','ACY4','ACY6','ACY12','ACY14')
names.c1l1<-c('ACY1','ACY2','ACY3','ACY4','ACY5','ACY6','ACY7','ACY8','ACY9','ACY10','ACY12','ACY13','ACY14','ACY15','ACY18')
names.c2l0<-c('AMT10','AMT11','AMT12','AMT14','AMT16','AMT18')
names.c2l1<-c('AMT8','AMT9','AMT10','AMT11','AMT12','AMT13','AMT14','AMT15','AMT16','AMT17','AMT18')

all.names<-list(names.c1l0,names.c1l1,names.c2l0,names.c2l1)

#Clunky -- loop through two sets of lists. k indexes each of the construct/length combinations in all.sets; j indexes each combination of DIF and impact within a given list (e.g., c1l0). i indexes replications.
k=1
j=1
i=2

for (k in 1:4){
  for (j in 1:4){ 
    for (i in 1:100) {
      the.name<-paste('M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/',all.sets[[k]][j],'/',all.sets[[k]][j],'_cp_ud_r',i,'.dat',sep="")
      df <- try(read.table(the.name,header=FALSE,na="*"),silent = TRUE)
      if (class(df) != "try-error") {
        names(df)<-c(all.names[[k]],
                     'study','t1','t2','id','p1','p2','c')
        
        #Sometimes Mplus switches class labels -- i.e., calls class 2 the low-symptoms class and class 1 the high-symptoms class in one replication, and calls class 1 the low-symptoms class and class 2 the high-symptoms class in the next.
        #To rectify this, we redefine the classes by defining class 2 as the high-symptoms class across replications.
        #This is where problems have happened before.
        
        df$estclass<-NA
        df$estp1<-NA
        df$estp2<-NA
        
        df.1<-subset(df,df$c==1)
        df.2<-subset(df,df$c==2)
        # very minor edit in that we don't need 1:length
        if (mean(colMeans(df.1[,all.names[[k]]],na.rm=TRUE)) > mean(colMeans(df.2[,all.names[[k]]],na.rm=TRUE))) {
          df$estclass<-3-df$c
          df$estp1<-df$p2
          df$estp2<-df$p1
        } else {df$estclass<-df$c
                df$estp1<-df$p1
                df$estp2<-df$p2}
        
        #Note that you redefine df.1 and df.2 here according to the new, redefined class membership. You also subset it exclusively to members of study 2, because we will be looking exclusively at misclassification in study 2. (Recall that study 1 is the people who have true classifications.)
        df.1<-subset(df,df$estclass==1&study==2)
        df.2<-subset(df,df$estclass==2&study==2)
        
        #Create the misclassification probability matrix as defined in Asparouhov and Muthen (2014).
        #First, we create the class probability membership matrix (Pmat), and then we use this to create the class probability membership matrix (Qmat).
        #If you have made it this far without finding the code problem, it might be worth it to look at Asparouhov and Muthen, 2014. I'll send this. 
        Pmat<-matrix(NA,ncol=2,nrow=2)
        Qmat<-matrix(NA,ncol=2,nrow=2)
        

        N1.2<-length(subset(df.1$study,df.1$study==2))
        N2.2<-length(subset(df.2$study,df.2$study==2))
        # could the above be simplified to the below?
        # since df.1 and df.2 are already subsets?
        # N1.2 <- nrow(df.1)
        # N2.2 <- nrow(df.2)
        
        ns<-c(N1.2,N2.2)
        cs<-df$estclass
        cprobs<-df[,c("estp1","estp2")]
        studies<-df$study
        # for (p in 1:2) {
        #   for (q in 1:2) {
        #     Pmat[q,p]<-mean(subset(cprobs[,p],(cs==q&studies==2)))
        #   }
        # }
        # ---------------------------------------------------------------------
        # I wanted to confirm the pmat matrix by computing each entry by hand
        # to be sure, I am using the equations from the bottom of page 3 on Asparouhov&Muthen
        # based on this, *I think* the above computation might have the diagonals switched
        #pmat[1, 1]
        Pmat[1,1] <- sum(df.1$estp1)/nrow(df.1)
        # pmat[2, 1]
        Pmat[2,1] <- sum(df.1$estp2)/nrow(df.1)
        # pmat[1, 2]
        Pmat[1,2] <- sum(df.2$estp1)/nrow(df.2)
        # pmat[2, 2]
        Pmat[2,2] <- sum(df.2$estp2)/nrow(df.2)
        # ---------------------------------------------------------------------

        
        # Qmat<-matrix(NA,ncol=2,nrow=2)
        # for (p in 1:2) {
        #   for (q in 1:2) {
        #     Qmat[p,q]<-(Pmat[q,p]*ns[q])/sum(Pmat[,p]*ns)
        #   }
        # }
        
        # ---------------------------------------------------------------------
        # so again my my computation, this matrix has the diagonals switched
        # basically writing a small function to compute each entry 
        # then checking each entry one at a time
        solve.qmat <- function(c1, c2) {
          (Pmat[c1, c2]*ns[c1])/((Pmat[1,c2]*ns[1])+(Pmat[2,c2]*ns[2]))
        }
        # q[1, 1]
        Qmat[1, 1] <- solve.qmat(1,1)
        # q[2, 1]
        Qmat[2, 1] <- solve.qmat(2,1)
        # q[1, 2]
        Qmat[1, 2] <- solve.qmat(1,2)
        # q[2, 2]
        Qmat[2, 2] <- solve.qmat(2,2)
        # ---------------------------------------------------------------------
        
        # For some reason, it appears there are some cases where there aren't any cases in class 1 in Study 2 
        if (nrow(df.1)==0|nrow(df.2)==0) {
          Pmat<-diag(2)
          Qmat<-diag(2)
        }
        
        Qprime <- solve(Qmat)
        ###BCH. YOU CAN PROBABLY SKIP TO VERMUNT.
        ###Create output datafiles for BCH. Recall that BCH involves weighting each observation's likelihood by the probability that that observation is misclassified.
        ###That weight, w_it, will be a function of the Q matrix.
        ###Note that we don't include gender and frat membership for these ones; those are manually merged into the SAS file later on.
        df$Class1<-0
        df$Class1[df$estclass==1]<-1
        df$Class2<-0
        df$Class2[df$estclass==2]<-1
        df$id_new<-1:length(df[,1])
        
        df.c1<-df
        df.c1$class_new <- 1
        df.c1$class_new1 <- 1
        df.c1$class_new2 <- 0
        df.c1$wstar_it <- df$Class1
        for (g in 1:length(df.c1[,1])) {
          if (df.c1$study[g]==2) {
            df.c1$wstar_it[g]<- df.c1$Class1[g]*Qprime[1,1] + df.c1$Class2[g]*Qprime[1,2]
          }
        }
        
        df.c2<-df
        df.c2$class_new <- 2
        df.c2$class_new1 <- 0
        df.c2$class_new2 <- 1
        df.c2$wstar_it <- df$Class2
        for (f in 1:length(df.c2[,1])) {
          if (df.c2$study[f]==2) {
            df.c2$wstar_it[f]<- df.c2$Class1[f]*Qprime[2,1] + df.c2$Class2[f]*Qprime[2,2]
          }
        }
        
        longmodal<-rbind(df.c1,df.c2)
        longmodal <- subset(longmodal, select = c(id,study,class_new,wstar_it,c,id_new) )
        longmodal<-longmodal[order(longmodal$id) , ]
        
        the.datafile.bch<-paste0(all.sets[[k]][j],'r',i,'_BCH_ud.dat')
        
        
        #I'm commenting the next line out so that you can run the code without overwriting the data.
        #write.table(longmodal,paste0('M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/bch/',all.sets[[k]][j],'/',the.datafile.bch),na='.',col.names=FALSE,row.names=FALSE)        
        
        
        ###VERMUNT
        ###Generate frat membership and gender for each observation
        
        justclasses<-df[,c("id","estclass","study","t1","t2")]
        names(justclasses)<-c("id","N","study","t1","t2")
        alltogether<-justclasses
        
        alltogether$gender<-NA
        alltogether$frat<-NA
        for (a in 1:length(alltogether[,1])) {
          if (alltogether$N[a]==1) {
            alltogether$gender[a]<-rbinom(1,1,gender.p[1])
            alltogether$frat[a]<-rbinom(1,1,frat.p[1])
          }
          if (alltogether$N[a]==2) {
            alltogether$gender[a]<-rbinom(1,1,gender.p[2])
            alltogether$frat[a]<-rbinom(1,1,frat.p[2])
          }
        }
        
        #alltogether$N[alltogether$study==1]<-NA
        the.datafile.vermunt<-paste0(all.sets[[k]][j],'r',i,'_V_ud.dat')
        # MG got rid of this
        # write.table(alltogether,paste0('M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/vermuntnew/',all.sets[[k]][j],'/',the.datafile.vermunt,na="."),na='.',col.names=FALSE,row.names=FALSE)
        # VTC added in a new test directory
        write.table(alltogether,paste0('M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/codetest_0409/',all.sets[[k]][j],'/',the.datafile.vermunt,na="."),na='.',col.names=FALSE,row.names=FALSE)
        
        #Get logits corresponding to a misclassifications
        l11<-log(Qmat[1,1]/(1-Qmat[1,1]))
        l12<-log(Qmat[1,2]/(1-Qmat[1,2]))
        l21<-log(Qmat[2,1]/(1-Qmat[2,1]))
        l22<-log(Qmat[2,2]/(1-Qmat[2,2]))
        
        
        #This is R jargon for pasting together strings to put in the Mplus files
        validity.vars<-c("gender","frat")
        NS1<-length(subset(df$study,df$study==1))
        NS2<-length(subset(df$study,df$study==2))
        thenames<-paste0(paste(names(alltogether),collapse="\n"),";")
        the.l11<-paste0("[N#1@",l11,"];")
        # VTC change: now that Q matrix is transposed from before, need element [2,1] rather than element [1,2]
        # should definitely check this, though
        the.l12<-paste0("[N#1@",l12,"];")
        
        
        #Write an Mplus input file for the Vermunt regression for each of the validity variables
        for (h in 1:length(validity.vars)) {
          the.s1int<-paste0("s1_int = (s1)*",validity.vars[h],";")
          c_on<-paste0("c ON ", validity.vars[h],"(gamma2);")
          
          the.usevars<-paste0("USEVARIABLES ARE ",validity.vars[h]," N t1 t2;")
          the.input.text<-paste(
            "TITLE:  Test run to get D matrix;",
            "DATA:  FILE IS",paste0(the.datafile.vermunt,";"),
            "FORMAT=FREE;",
            "VARIABLE:",
            "    NAMES ARE",thenames,the.usevars,
            "    NOMINAL = N;",
            "    CLASSES = C(2);",
            "    TRAINING = T1 T2;",
            "    MISSING are all .;",
            "    IDVARIABLE = ID;",
            "    USEOBSERVATIONS ARE (STUDY==2)",
            " DEFINE:",
            "  s1 = 1-(study-1);",
            "  s2 = study-1;",
            "ANALYSIS:",
            "  TYPE = MIXTURE;",
            "  STARTS = 0;",
            "  MODEL:",
            "  %OVERALL%",
            c_on,
            "  %C#1%",
            the.l11,
            "    %C#2%",
            the.l12,sep="\n")
          
          the.input.name<-paste('M:/xstudy2/Simulation/aim02/July2017/sim/knownclass/codetest_0409/',all.sets[[k]][j],'/',all.sets[[k]][j],'r',i,'_V_ud_',validity.vars[h],'.inp',sep="")          
          the.input<-file(the.input.name)
          # MG got rid of this
          # VTC put back for testing purposes
          writeLines(the.input.text, the.input)
          close(the.input)
        }
      }
    }
  }
}
