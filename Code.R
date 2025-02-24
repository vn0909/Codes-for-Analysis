getwd()  
setwd("C:/Users/Desktop/")   

###Alpha diversity analysis###
install.packages("vegan")  
library("vegan")   
species<-read.table("H_sample.txt",header=TRUE,sep="\t",row.names=1)   
species<-t(species)
species  
dim(species) 
speciesR<-rrarefy(species,min(rowSums(species)))   
dim(speciesR)   
Chao1_ACE<-estimateR(speciesR)  
Chao1_ACE  
Chao1_ACE<-data.frame(Chao1_ACE)  
Chao1_ACE  
Chao1_ACE<-t(Chao1_ACE) 
Chao1_ACE 
write.table(Chao1_ACE,file="H_sample_Chao1_ACE.txt",append=FALSE,quote=TRUE,sep="\t",
            eol="\n",na="NA",dec=".",row.names=TRUE,col.names=TRUE,
            qmethod=c("escape","double"),fileEncoding="")  

Shannon_wiener<-diversity(speciesR,"shannon")  
Shannon_wiener  
Shannon_wiener<-data.frame(Shannon_wiener)  
Shannon_wiener  
write.table(Shannon_wiener,file="H_sample_Shannon_wiener.txt",append=FALSE,quote=TRUE,sep="\t",
            eol="\n",na="NA",dec=".",row.names=TRUE,col.names=TRUE,
            qmethod=c("escape","double"),fileEncoding="")  

Simpson<-diversity(speciesR,"simpson")  
Simpson  
Simpson<-data.frame(Simpson)   
Simpson  
write.table(Simpson,file="H_sample_Simpson.txt",append=FALSE,quote=TRUE,sep="\t",
            eol="\n",na="NA",dec=".",row.names=TRUE,col.names=TRUE,
            qmethod=c("escape","double"),fileEncoding="")  

install.packages("ggplot2")  
library("ggplot2")  
Chao1_ACE<-read.table("H_sample_Chao1_ACE.txt",header=TRUE,sep="\t",row.names=1)  
Chao1_ACE  
group<-read.table("H_sample_group.txt",header=TRUE,sep="\t",row.names=1)  
group  
Chao1_ACE_merged<-merge(Chao1_ACE,group,by="row.names",all=FALSE)  
Chao1_ACE_merged 
plot<-ggplot(Chao1_ACE_merged,aes(x=group,y=S.obs),colors=group)+geom_boxplot(aes(fill=group))+theme_test()+
  labs(x="",y="Observed OTUs")+geom_jitter(position=position_jitter(0),size=1.5,alpha=1,color="Black")+
  theme(axis.text.x=element_text(angle=0,hjust=0.6,vjust=0.6,size=12,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=12,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=3,size=15,face="bold",color="Black"),
        axis.line.x=element_line(color="Black",size=0.8,linetype="solid"),
        axis.line.y=element_line(color="Black",size=0.8,linetype="solid"),
        panel.grid.major=element_line(color="white"),
        plot.margin=unit(c(0.5,0.5,0.5,0.5), 'cm'))+
  theme(legend.position = "none")  
plot  
ggsave(plot=plot,'F:/R/Exp2/Observed OTUs.pdf',height=4,width=4)
ggsave(plot=plot,'F:/R/Exp2/Observed OTUs.png',height=4,width=4)

plot<-ggplot(Chao1_ACE_merged,aes(x=Groups,y=S.chao1),colors=Groups)+geom_boxplot(aes(fill=Groups))+theme_test()+
  labs(x="",y="Chao1 index")+geom_jitter(position=position_jitter(0),size=1.5,alpha=1,color="Black")+
  theme(axis.text.x=element_text(angle=30,hjust=0.6,vjust=0.6,size=12,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=12,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=3,size=15,face="bold",color="Black"),
        axis.line.x=element_line(color="Black",size=0.8,linetype="solid"),
        axis.line.y=element_line(color="Black",size=0.8,linetype="solid"),
        panel.grid.major=element_line(color="White"),
        plot.margin=unit(c(0.5,0.5,0,0.5), 'cm'))+
  theme(legend.position = "none") 
plot 
ggsave(plot=plot,'E:/R/Chao1 index.pdf',height=4,width=4)

plot<-ggplot(Chao1_ACE_merged,aes(x=Groups,y=S.ACE),colors=Groups)+geom_boxplot(aes(fill=Groups))+theme_test()+
  labs(x="",y="ACE index")+geom_jitter(position=position_jitter(0),size=1.5,alpha=1,color="Black")+
  theme(axis.text.x=element_text(angle=30,hjust=0.6,vjust=0.6,size=12,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=12,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=3,size=15,face="bold",color="Black"),
        axis.line.x=element_line(color="Black",size=0.8,linetype="solid"),
        axis.line.y=element_line(color="Black",size=0.8,linetype="solid"),
        panel.grid.major=element_line(color="White"),
        plot.margin=unit(c(0.5,0.5,0,0.5), 'cm'))+
  theme(legend.position = "none")  
plot 
ggsave(plot=plot,'E:/R/ACE index.pdf',height=4,width=4)

Shannon_wiener<-read.table("Shannon_wiener.txt",header=TRUE,sep="\t",row.names=1)  
Shannon_wiener 
group<-read.table("group.txt",header=TRUE,sep="\t",row.names=1) 
group  
Shannon_wiener_merged<-merge(Shannon_wiener,group,by="row.names",all=FALSE)  
Shannon_wiener_merged  

plot<-ggplot(Shannon_wiener_merged,aes(x=Groups,y=Shannon_wiener),colors=Groups)+geom_boxplot(aes(fill=Groups))+theme_test()+
  labs(x="",y="Shannon-Wiener index")+geom_jitter(position=position_jitter(0),size=1.5,alpha=1,color="Black")+
  theme(axis.text.x=element_text(angle=30,hjust=0.6,vjust=0.6,size=12,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=12,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=3,size=15,face="bold",color="Black"),
        axis.line.x=element_line(color="Black",size=0.8,linetype="solid"),
        axis.line.y=element_line(color="Black",size=0.8,linetype="solid"),
        panel.grid.major=element_line(color="White"),
        plot.margin=unit(c(0.5,0.5,0,0.5), 'cm'))+
  theme(legend.position = "none")  
plot  
ggsave(plot=plot,'E:/R/Shannon-Wiener index.pdf',height=4,width=4)

Simpson<-read.table("Simpson.txt",header=TRUE,sep="\t",row.names=1)  
Simpson 
group<-read.table("group.txt",header=TRUE,sep="\t",row.names=1)  
group
Simpson_merged<-merge(Simpson,group,by="row.names",all=FALSE) 
Simpson_merged 
plot<-ggplot(Simpson_merged,aes(x=Groups,y=Simpson),colors=Groups)+geom_boxplot(aes(fill=Groups))+theme_test()+
  labs(x="",y="Simpson's diversity index")+geom_jitter(position=position_jitter(0),size=1.5,alpha=1,color="Black")+
  theme(axis.text.x=element_text(angle=30,hjust=0.6,vjust=0.6,size=12,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=12,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=3,size=15,face="bold",color="Black"),
        axis.line.x=element_line(color="Black",size=0.8,linetype="solid"),
        axis.line.y=element_line(color="Black",size=0.8,linetype="solid"),
        panel.grid.major=element_line(color="White"),
        plot.margin=unit(c(0.5,0.5,0,0.5), 'cm'))+
  theme(legend.position = "none") 
plot  
ggsave(plot=plot,'E:/R/Simpsons diversity index.pdf',height=4,width=4)



#PCoA
install.packages("vegan")
install.packages("ggplot2")
install.packages("ape")
library(ggplot2)
library(vegan)
library(ape)
soil_otu<-read.table("R_sample_top30.txt",header=TRUE,sep="\t",row.names=1)  
soil_otu
group<-read.table("R_sample_group.txt",header=TRUE,sep="\t",row.names=1)  
group
otu_new<-decostand(soil_otu,method="hellinger")
otu_distance<-vegdist(otu_new,method="bray")
otu_distance
res=pcoa(otu_distance, correction="none")
head(res$value)
head(res$vectors)

data=res$vectors[,1:2]
data=data.frame(data)
colnames(data)=c('x','y')
eig=as.numeric(res$value[,1])
type=group$group
type
data=cbind(data,type)

plot<-ggplot(data, aes(x=x, y=y))+theme_test()+geom_point(aes(color = type,shape=type),size=5)+theme_test()+
  scale_color_manual(values = c('#CC0000', '#CC33FF', '#3300FF','#FF9900'))+
  scale_shape_manual(values=c(22,21,23,24))+
  scale_x_continuous(limits=c(-0.20,0.20))+
  scale_y_continuous(limits=c(-0.20,0.20))+
  labs(x=paste("PCoA 1 (",format(100* eig[1] / sum(eig), digits=4), "%)", sep=""),
       y=paste("PCoA 2 (", format(100*eig[2] / sum(eig), digits=4), "%)", sep=""),title="")+
  theme(axis.text.x=element_text(angle=0,hjust=0.5,vjust=0.5,size=15,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=15,face="bold",color="Black"),
        legend.text=element_text(angle=0,hjust=0,vjust=0.5,size=12,face="bold",color="Black"),
        axis.title.x=element_text(angle=0,hjust=0.5,vjust=0.5,size=17,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=2,size=17,face="bold",color="Black"),
        axis.ticks=element_line(color="Black",size=1,linetype="solid"),
        plot.margin=margin(t=0.5,r=0.5,b=0.5,l=0.5,unit="cm"),
        legend.title=element_blank())
otu <- read.delim('A_B_Top30_Genus_sample.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)
otu <- data.frame(t(otu))
otu
group <- read.delim('A_B_Top30_Genus_group_sample.txt', sep = '\t', stringsAsFactors = FALSE)
group
group_name <- unique(group$group)
group_name
dir.create('anosim_two', recursive = TRUE)
anosim_result_two <- NULL
for (i in 1:(length(group_name) - 1)) {
  for (j in (i + 1):length(group_name)) {
    group_ij <- subset(group, group %in% c(group_name[i], group_name[j]))
    otu_ij <- otu[group_ij$sample, ]
    anosim_result_otu_ij <- anosim(otu_ij, group_ij$group, permutations = 999, distance = 'bray')
    
    
    if (anosim_result_otu_ij$signif <= 0.001) Sig <- '***'
    else if (anosim_result_otu_ij$signif <= 0.01) Sig <- '**'
    else if (anosim_result_otu_ij$signif <= 0.05) Sig <- '*'
    else Sig <- NA
    anosim_result_two <- rbind(anosim_result_two, c(paste(group_name[i], group_name[j], sep = '/'), 'Bray-Curtis', anosim_result_otu_ij$statistic, anosim_result_otu_ij$signif, Sig))
    
    
    #pdf(paste('anosim_two/anosim.', group_name[i], '_', group_name[j], '.pdf', sep = ''), width = 7, height = 5)
    png(paste('anosim_two/anosim.', group_name[i], '_', group_name[j], '.png', sep = ''), width = 600, height = 400)
    plot(anosim_result_otu_ij, col = c('gray', 'red', 'blue'))
    dev.off()
  }
}


anosim_result_two <- data.frame(anosim_result_two, stringsAsFactors = FALSE)
names(anosim_result_two) <- c('group', 'distance', 'R', 'P_value', 'Sig')
write.table(anosim_result_two, 'anosim_two/ANOSIM.result_two.txt', row.names = FALSE, sep = '\t', quote = FALSE, na = '')

plot
ggsave(plot=plot,'F:/R/EXp2/R_sample_top30.pdf',height=5,width=6.5)
ggsave(plot=plot,'F:/R/EXp2/R_sample_top30.png',height=5,width=6.5)

##Random Forest

library(readxl)
env <- data.frame(read_xlsx('MY.xlsx',1))
rownames(env) <- env[,2]
env <- env[,-1:-2]
otu <- read.table('MY-featureTable.sample.total.absolute.txt',header = T,row.names = 1,sep = '\t')
otu <- otu[,rownames(env)]
library(vegan)
shannon <- diversity(t(otu),MARGIN = 1) 
SR <- specnumber(t(otu),MARGIN = 1)   
chao1 <- estimateR(t(otu))[2, ]
simpson=diversity(t(otu),"simpson")
diversity <- data.frame(shannon,SR,chao1,simpson)

library(randomForest)
library(ggplot2)
create_rfplot <- function(rf, type){
  
  imp <- importance(rf, type = type, scale = F)
  
  featureImportance <- data.frame(Feature = row.names(imp), Importance = imp[,1])
  
  p <- ggplot(featureImportance, aes(x = reorder(Feature, Importance), y = Importance)) +
    geom_bar(stat = "identity", fill = "#53cfff", width = 0.65) +
    coord_flip() + 
    theme_light(base_size = 20) +
    theme(axis.title.x = element_text(size = 15, color = "black"),
          axis.title.y = element_blank(),
          axis.text.x  = element_text(size = 15, color = "black"),
          axis.text.y  = element_text(size = 15, color = "black")) 
  return(p)
}

set.seed(123)
env1 <- data.frame(env,SR=diversity$SR)
library(rfPermute)
library(ggplot2)
rf_results<-rfPermute(SR~., data =env1, importance = TRUE, ntree = 1000)
rf_results$rf
predictor_var<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)
predictor_sig<-as.data.frame((rf_results$pval)[,,2])
colnames(predictor_sig)<-c("sig","other")



df_pre<-cbind(predictor_var,predictor_sig)
df_pre$sig[df_pre$sig<=0.05]<-"*"
df_pre$sig[df_pre$sig>=0.05]<-" "

df_pre_SR <- df_pre

set.seed(123)
env1 <- data.frame(env,simpson=diversity$simpson)
library(rfPermute)
library(ggplot2)
rf_results<-rfPermute(simpson~., data =env1, importance = TRUE, ntree = 1000)
rf_results$rf
predictor_var<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)
predictor_sig<-as.data.frame((rf_results$pval)[,,2])
colnames(predictor_sig)<-c("sig","other")



df_pre<-cbind(predictor_var,predictor_sig)
df_pre$sig[df_pre$sig<=0.05]<-"*"
df_pre$sig[df_pre$sig>=0.05]<-" "

df_pre_simpson <- df_pre

set.seed(123)
env1 <- data.frame(env,chao1=diversity$chao1)
library(rfPermute)
library(ggplot2)
rf_results<-rfPermute(chao1~., data =env1, importance = TRUE, ntree = 1000)
rf_results$rf
predictor_var<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)
predictor_sig<-as.data.frame((rf_results$pval)[,,2])
colnames(predictor_sig)<-c("sig","other")



df_pre<-cbind(predictor_var,predictor_sig)
df_pre$sig[df_pre$sig<=0.05]<-"*"
df_pre$sig[df_pre$sig>=0.05]<-" "

df_pre_chao1 <- df_pre

shannon
set.seed(123)
env1 <- data.frame(env,shannon=diversity$shannon)
library(rfPermute)
library(ggplot2)
rf_results<-rfPermute(shannon~., data =env1, importance = TRUE, ntree = 1000)
rf_results$rf
predictor_var<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)
predictor_sig<-as.data.frame((rf_results$pval)[,,2])
colnames(predictor_sig)<-c("sig","other")



df_pre<-cbind(predictor_var,predictor_sig)
df_pre$sig[df_pre$sig<=0.05]<-"*"
df_pre$sig[df_pre$sig>=0.05]<-" "

df_pre_shannon <- df_pre
df_pre_shannon$var <- 'shannon'
df_pre_SR$var <- 'SR'
df_pre_chao1$var <- 'chao1'
df_pre_simpson$var <- 'simpson'

df_pre_shannon$variable <- rownames(df_pre_shannon)
df_pre_SR$variable <- rownames(df_pre_SR)
df_pre_simpson$variable <- rownames(df_pre_simpson)
df_pre_chao1$variable <- rownames(df_pre_chao1)
df_pre <- rbind(df_pre_SR,df_pre_shannon,df_pre_simpson,df_pre_chao1)
colnames(df_pre)[1] <- 'IncMSE'
df_pre1 <- df_pre
df_pre1$IncMSE <- ifelse(df_pre1$IncMSE>0,df_pre1$IncMSE,0)


df_pre1$variable <- factor(df_pre1$variable,levels =c( "Ala" ,"Arg", "Asp", "Cys" , "Glu", "Gly" ,"His",
                                                       "Ile", "Leu", "Lys","Met", "Phe","Ser","Thr","Tyr",
                                                       "Val", "NH4", "NO3" , "TN" , "TP","TK" ,"Fe","Suc", "Fru"))

df_pre11 <- df_pre1[df_pre1$var=='chao1',]

chao1 <- ggplot(data=df_pre11,aes(x=variable,y=IncMSE,fill='#f8766d'))+
  geom_bar(position = position_dodge(0.8),stat = 'identity',width=0.7,show.legend = F)+
  theme_classic()+ labs(x='',y='Increase in MSE(%)')+
  geom_text(aes(label = sig,y= IncMSE+ 0.1, x =variable,color=var),
            vjust = -0.3,size = 6,position = position_dodge(0.8),show.legend = F)+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 26.62),color='#f8766d',
           x = 9, y = 8.5, size = 5, parse = TRUE,family='serif')+
  labs(fill='')+
  theme(text=element_text(family = 'serif'),
        axis.title = element_text(color='black',size=15),
        axis.text = element_text(color='black',size=14),
        legend.text  = element_text(size=13))+
  coord_flip()

chao1

df_pre11 <- df_pre1[df_pre1$var=='shannon',]

shannon <- ggplot(data=df_pre11,aes(x=variable,y=IncMSE))+
  geom_bar(position = position_dodge(0.8),stat = 'identity',fill='#7cae00',width=0.7,show.legend = F)+
  theme_classic()+ labs(x='',y='Increase in MSE(%)')+
  geom_text(aes(label = sig,y= IncMSE+ 0.1, x =variable),color='#7cae00',
            vjust = -0.3,size = 6,position = position_dodge(0.8),show.legend = F)+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 33.6),color='#7cae00',
           x = 9, y = 9.5, size = 5, parse = TRUE,family='serif')+
  labs(fill='')+
  theme(text=element_text(family = 'serif'),
        axis.title = element_text(color='black',size=15),
        axis.text = element_text(color='black',size=14),
        legend.text  = element_text(size=13))+
  coord_flip()

shannon



df_pre11 <- df_pre1[df_pre1$var=='simpson',]
sim <- ggplot(data=df_pre11,aes(x=variable,y=IncMSE))+
  geom_bar(position = position_dodge(0.8),stat = 'identity',fill='#00bfc4',width=0.7,show.legend = F)+
  theme_classic()+ labs(x='',y='Increase in MSE(%)')+
  geom_text(aes(label = sig,y= IncMSE+ 0.1, x =variable),color='#00bfc4',
            vjust = -0.3,size = 6,position = position_dodge(0.8),show.legend = F)+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 23.26),color='#00bfc4',
           x = 9, y = 9, size = 5, parse = TRUE,family='serif')+
  labs(fill='')+
  theme(text=element_text(family = 'serif'),
        axis.title = element_text(color='black',size=15),
        axis.text = element_text(color='black',size=14),
        legend.text  = element_text(size=13))+
  coord_flip()

sim

df_pre11 <- df_pre1[df_pre1$var=='SR',]

SR <- ggplot(data=df_pre11,aes(x=variable,y=IncMSE))+
  geom_bar(position = position_dodge(0.8),stat = 'identity',fill='#c77cff',width=0.7,show.legend = F)+
  theme_classic()+ labs(x='',y='Increase in MSE(%)')+
  geom_text(aes(label = sig,y= IncMSE+ 0.1, x =variable),color='#c77cff',
            vjust = -0.3,size = 6,position = position_dodge(0.8),show.legend = F)+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 23.26),color='#c77cff',
           x = 7.5, y = 5.5, size = 5, parse = TRUE,family='serif')+
  labs(fill='')+
  theme(text=element_text(family = 'serif'),
        axis.title = element_text(color='black',size=15),
        axis.text = element_text(color='black',size=14),
        legend.text  = element_text(size=13))+
  coord_flip()
SR


write.csv(df_pre1,file = 'randomtree.csv')

ggplot(data=df_pre1,aes(x=variable,y=IncMSE,fill=var))+
  geom_bar(position = position_dodge(0.8),stat = 'identity',width=0.7)+
  theme_classic()+ labs(x='',y='Increase in MSE(%)')+
  geom_text(aes(label = df_pre$sig,y= IncMSE+ 0.1, x =variable,color=var),
            vjust = -0.3,size = 6,position = position_dodge(0.8),show.legend = F)+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 29.19),color='#c77cff',
           x = 9, y = 10, size = 5, parse = TRUE,family='serif')+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 33.6),color='#7cae00',
           x = 9, y = 9.5, size = 5, parse = TRUE,family='serif')+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 23.26),color='#00bfc4',
           x = 9, y = 9, size = 5, parse = TRUE,family='serif')+
  annotate('text', label = sprintf('italic(R^2) == %.2f', 26.62),color='#f8766d',
           x = 9, y = 8.5, size = 5, parse = TRUE,family='serif')+
  labs(fill='')+
  theme(text=element_text(family = 'serif'),
        axis.title = element_text(color='black',size=15),
        axis.text = element_text(color='black',size=14),
        legend.text  = element_text(size=13))





library(ggplot2)  
library(vegan)
library(randomForest)
library(reshape2)
library(psych)
library(dplyr)
library(rfPermute)
library(corrplot)
env1 <- data.frame(env,diversity)
df <- env1
spearman_df <- corr.test(env1, method = 'pearson', adjust = 'none')
spearman_df<- data.frame(spearman_df$r) 
spearman_df1 <- corr.test(env1, method = 'pearson', adjust = 'none')
spearman_df1 <- data.frame(spearman_df1$p)
spearman_df<-spearman_df[1:24,25:28]
spearman_df1<-spearman_df1[1:24,25:28]



set.seed(1234)

rf_results<-rfPermute(df$shannon~., data =df[,c(1:24,25)], importance = TRUE, ntree = 1000,  num.cores = 15)
predictor_1<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)

set.seed(1234)
rf_results<-rfPermute(df$SR~., data =df[,c(1:24,26)], importance = TRUE, ntree = 1000,  num.cores = 15)
predictor_2<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)

set.seed(1234)
rf_results<-rfPermute(df$chao1~., data =df[,c(1:24,27)], importance = TRUE, ntree = 1000,  num.cores = 15)
predictor_3<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)
set.seed(1234)
rf_results<-rfPermute(df$simpson~., data =df[,c(1:24,28)], importance = TRUE, ntree = 1000,  num.cores = 15)
predictor_4<- data.frame(importance(rf_results, scale = TRUE), check.names = FALSE)


randomForest_df<-data.frame(predictor_1[,1],predictor_2[,1],predictor_3[,1],predictor_4[,1])
rownames(randomForest_df)<-rownames(predictor_1)
colnames(randomForest_df)<-colnames(spearman_df)

rownames(randomForest_df)<-rownames(predictor_1)
colnames(randomForest_df)<-colnames(spearman_df1)

randomForest_io<-randomForest_df%>% mutate(randomForest_df=row.names(.))%>%melt()
spearman_io<-spearman_df%>% mutate(spearman_df=row.names(.))%>%melt()
spearman_io1<-spearman_df1%>% mutate(spearman_df1=row.names(.))%>%melt()

spearman_io1$p <- ifelse(spearman_io1$value<0.001,'***',
                         ifelse(spearman_io1$value<0.001,'**',
                                ifelse(spearman_io1$value<0.05,'*',' ')))
colnames(spearman_io1)[1:2] <- colnames(spearman_io)[1:2]
spearman_io <- merge(spearman_io,spearman_io1,by = c('spearman_df','variable'))

spearman_io$variable <- factor(spearman_io$variable,levels = c('chao1','shannon','simpson','SR'))


spearman_io$spearman_df <- factor(spearman_io$spearman_df,levels =c( "Ala" ,"Arg", "Asp", "Cys" , "Glu", "Gly" ,"His",
                                                                     "Ile", "Leu", "Lys","Met", "Phe","Ser","Thr","Tyr",
                                                                     "Val", "NH4", "NO3" , "TN" , "TP","TK" ,"Fe","Suc", "Fru"))
ggplot(spearman_io[spearman_io$variable=='chao1',])+
  geom_tile(data = spearman_io,aes(x =spearman_df, y = variable, fill = value.x)) +
  scale_fill_gradientn(colors = c('#2D6DB1', 'white', '#DC1623'), limit = c(-1, 1)) +
  scale_size_continuous(range = c(0,12)) +labs(size = 'MSE (%)')+
  geom_text(data =spearman_io, aes(x =spearman_df, y = variable,label=p))+
  theme_minimal()+scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  theme(axis.text=element_text(colour='black',size=9))+
  labs(y = '', x = '', fill = 'pearson r')


write.csv(diversity,file = 'diversity.csv')


#RDA
species<-read.table("H_sample_top30.txt",header=TRUE,sep="\t",row.names=1)
species<-decostand(species,method="hellinger")
species
environment<-read.table("H_sample_env.txt",header=TRUE,sep="\t",row.names=1)
environment
group<-read.table("H_sample_group.txt",header=TRUE,sep="\t",row.names=1)
group
decorana(species)
result<-rda(species,environment)
result
permutest(result,permutations=999)
ef<-envfit(result,environment,permutations=999)
ef
plot(result)
new<-result$CCA
new
samples<-data.frame(sample=row.names(new$u),RDA1=new$u[,1],RDA2=new$u[,2])
samples
samples_new<-merge(group,samples,by="row.names",all=F)
samples_new
species_new<-data.frame(spece=row.names(new$v),RDA1=new$v[,1],RDA2=new$v[,2])
species_new
envi<-data.frame(en=row.names(new$biplot),RDA1=new$biplot[,1],RDA2=new$biplot[,2])
envi
line_x = c(0,envi[1,2],0,envi[2,2],0,envi[3,2],0,envi[4,2],0,envi[5,2],0,envi[6,2],0,envi[7,2],0,envi[8,2],0,envi[9,2],0,envi[10,2])
line_x
line_y = c(0,envi[1,3],0,envi[2,3],0,envi[3,3],0,envi[4,3],0,envi[5,3],0,envi[6,3],0,envi[7,3],0,envi[8,3],0,envi[9,3],0,envi[10,3])
line_y
line_g = c("NP","NP","ALP","ALP","ACP","ACP","TP","TP","AP","AP","AL_P","AL_P","Fe_P","Fe_P","Ca_P","Ca_P","O_P","O_P","HLD","HLD")
line_g
line_data = data.frame(x=line_x,y=line_y,group=line_g)
line_data
plot<-ggplot(data=samples_new,aes(RDA1,RDA2)) +labs(x="RDA1 (78.56%)",y="RDA2 (10.43%)")+
  geom_point(aes(color = group,shape=group),size=7)+theme_test()+
  scale_color_manual(values = c('#33FF00', '#33CCFF', '#FFCC00','#996600'))+
  scale_shape_manual(values=c(15,19,18,17))+
  scale_x_continuous(limits=c(-0.8,1.0))+
  scale_y_continuous(limits=c(-0.8,0.8))+
  geom_text(data=samples_new,aes(label=group),color="red",size=5) +
  geom_point(data=species_new,colour="#99FF33",alpha=0.5,size=10) +
  geom_text(data=species_new,aes(label=spece),color="red",size=3) +
  geom_text(data=envi,aes(label=en),color="#000099",size=5)+
  geom_hline(yintercept=0) + geom_vline(xintercept=0)+
  geom_line(data=line_data,aes(x=x,y=y,group=group),color="#000099",size=1)+
  theme_test(base_size =20) +
  theme(axis.text.x=element_text(angle=0,hjust=0.5,vjust=0.5,size=20,face="bold",color="Black"),
        axis.text.y=element_text(angle=0,hjust=0.5,vjust=0.5,size=20,face="bold",color="Black"),
        title=element_text(angle=0,hjust=0.5,vjust=0.5,size=20,face="bold",color="Black"), 
        axis.title.x=element_text(angle=0,hjust=0.5,vjust=0.5,size=25,face="bold",color="Black"),
        axis.title.y=element_text(angle=90,hjust=0.5,vjust=0.5,size=25,face="bold",color="Black"),
        plot.margin=margin(t=0.5,r=0.5,b=0.5,l=0.5,unit="cm"),
        panel.grid=element_blank(),
        legend.title=element_blank())
plot
ggsave(plot=plot,'F:/R/Exp2/H_sample_top30_RDA.pdf',height=10,width=15)
ggsave(plot=plot,'F:/R/Exp2/H_sample_top30_RDA.png',height=10,width=15)

#Network analysis
otu2 <- read.table('sample.total.absolute.txt',row.names = 1,header = T,sep='\t')
otu1 <- subset(otu2,select = -Taxonomy)
otu1<-t(otu1)
otu1<-otu1/rowSums(otu1)
otu1<-data.frame(t(otu1))
otu <- otu1
library(readxl)
library(dplyr)

data2 <- read.table('sample.txt',sep='\t')
otu <- otu[rownames(data2),]
otu50 <- otu
otu50[otu50>0] <- 1
otu50 <- otu50[rowSums(otu50)>=4,]
otu <- otu[rownames(otu50),]
library(igraph)
library(WGCNA)
CorrDF <- function(cormat, pmat) {
  ut <- upper.tri(cormat) # 
  data.frame(
    from = rownames(cormat)[col(cormat)[ut]],
    to = rownames(cormat)[row(cormat)[ut]],
    cor = (cormat)[ut],
    p = pmat[ut]
  )
}

occor <- corAndPvalue(t(otu),use = 'pairwise', method='spearman')
cor_df <- CorrDF(occor$cor,occor$p) 
cor_df <- cor_df[which(abs(cor_df$cor) >= 0.6),]
cor_df <- cor_df[which(cor_df$p < 0.05),] 
cor_df$PN <- ifelse(cor_df$cor<0,-1,1)

data3 <- subset(data2,select=c(g,Phylum,Class,Order,Family,Genus))

igraph <- graph_from_data_frame(cor_df, direct=F) 


igraph <- delete_vertices(igraph, which(degree(igraph, mode = "in") == 0 &
                                          degree(igraph, mode = "out") == 0))

data3 <- data3[as.character(V(igraph)$name), ]
table(data3$g)
V(igraph)$Phylum <- data3$Phylum
V(igraph)$Class <- data3$Class
V(igraph)$Order <- data3$Order
V(igraph)$Family <- data3$Family
V(igraph)$Genus <- data3$Genus
V(igraph)$group <- data3$g
V(igraph)$degree <- degree(igraph)
E(igraph)$width <- abs(E(igraph)$cor)
V(igraph)$closeness_centrality <- closeness(igraph)#closeness_centrality
V(igraph)$betweenness_centrality <- betweenness(igraph)#Betweenness centrality
V(igraph)$eigenvector_centrality <- eigen_centrality(igraph)$vector#Eigenvector centrality

node.pa <- data.frame(V(igraph)$eigenvector_centrality,V(igraph)$betweenness_centrality,V(igraph)$degree,
                      V(igraph)$closeness_centrality)
rownames(node.pa) <- V(igraph)$name
node.pa$g <- data3$g
write.csv(node.pa,file = 'figure3E.csv',row.names = F)
write.csv(node.pa,file = 'figure3E.csv')

nodes_num = length(V(igraph))                   
nodes_num

edges_num = length(E(igraph))                   
edges_num

positive.cor_num = sum(E(igraph)$cor>0)      
positive.cor_num

negative.cor_num = sum(E(igraph)$cor<0)        
negative.cor_num

average_degree = mean(degree(igraph))           
average_degree

average_path_length = average.path.length(igraph, directed = FALSE) 
average_path_length

network_diameter = diameter(igraph, directed = FALSE)                  
network_diameter

network_density = graph.density(igraph)                                
network_density

clustering_coefficient = transitivity(igraph)                          
clustering_coefficient
network_parameter = data.frame(nodes_num, 
                               edges_num, 
                               positive.cor_num, 
                               negative.cor_num, 
                               average_degree,
                               average_path_length,
                               network_diameter, 
                               network_density,
                               clustering_coefficient)
write.csv(network_parameter, 'igraph.csv')
###SEM

library(vegan)
library(ape)
library(ggplot2)
library(lavaan)
library(haven)
library(Hmisc)
library(semPlot)

data<-read.csv("C:/Users/sample.csv",row.names = 1)

data1<- vegdist(data[,1:2], method = "bray")
pcoa<- pcoa(data1, correction = "none", rn = NULL)

PC1soil = pcoa$vectors[,1]
PC2soil = pcoa$vectors[,2]

index1<- data.frame(PC1soil)
#write.csv(index1,"index1.csv")
data2<- vegdist(data[,3:10], method = "bray")
pcoa<- pcoa(data2, correction = "none", rn = NULL)
PC1weather = pcoa$vectors[,1]
PC2weather = pcoa$vectors[,2]
index2<- data.frame(index1,PC1weather)
write.csv(index2,"index2.csv")
data3<- vegdist(data[,11:26], method = "bray")
pcoa<- pcoa(data3, correction = "none", rn = NULL)
PC1root = pcoa$vectors[,1]
PC2root = pcoa$vectors[,2]
index3<- data.frame(index2,PC1root)
index3<- data.frame(index2,PC1root)
#write.csv(index1,"index1.csv")
write.csv(index3,"JYindex3.csv")
index<-read.csv("C:/Users/sample.csv",row.names = 1)
index
colnames(index)<-c("climate","unamino","amino","shannon","richness","chao1","simpson")
df=scale(index,center=TRUE,scale=TRUE)
df
model <- '
shannon~climate+unamino+amino
richness~climate+unamino+amino
chao1~climate+unamino+amino
simpson~climate+unamino+amino
amino~climate
unamino~climate
fit_model<-sem(model,data=df)
resid(fit_model, type = "cor")


summary(fit_model,standardized=T)

modindices(fit_model,sort.=TRUE)
inspect(fit_model,what="std")

fitMeasures(fit_model,c("chisq","df","pvalue","cfi","gfi","ifi","rmsea","EVCI","srmr"))

semPaths(fit_model,"std",edge.label.cex=1,
         rotation = 1,
         fade=FALSE, layout = "spring",
         nCharNodes=15, what = "paths",
         optimizeLatRes = FALSE, residuals = FALSE)
