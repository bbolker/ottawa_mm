dd <- read.csv("topic_choices.csv")
vals <- c("definitely skip","maybe skip","neutral","maybe cover","definitely cover")
nn <- names(dd)
names(dd) <- gsub("(^.*\\.{2}|\\.$)","",nn)
dd <- dd[,-1] ## drop timestamp
dd[] <- lapply(dd,factor,levels=vals)
topic_order <- names(sort(sapply(dd,function(x) mean(as.numeric(x)))))

library("reshape2")
mm <- melt(dd,id.vars=NULL)
mm$variable <- factor(mm$variable,levels=topic_order)
mm$value <- factor(mm$value,levels=vals) ## reset order ..
library("ggplot2"); theme_set(theme_bw())
ggplot(na.omit(mm),aes(x=variable,fill=value))+geom_bar()+
    coord_flip()+labs(x="")+
    scale_x_discrete(expand=c(0,0))+
    scale_y_continuous(expand=c(0,0),breaks=seq(0,12,by=2))
ggsave("topic_choices.png",width=12,height=5,dpi=100)
