pacman::p_load(readxl,ggplot2,showtext,grid,ggpubr,extrafont,ggrepel)
## Add font
font_add(
  family = "times",
  regular = here::here(
    "figs","Times New Roman.ttf"
  )
)
showtext_auto()
## data
data <- read_excel(here::here("data","WIF-tis4d-cleaned.xlsx"))
data$cell_line <- factor(data$cell_line, levels = c("Wild-Type","Cell-Type 101"))
data$name[which(data$name == "Gl-Xib")] <- "XIb"
data$name[which(data$name == "Gl-Cdz")] <- "cDZ"
data$name[which(data$name == "Gl-Rjs")] <- "rjS"
data$name[which(data$name == "Gl-Xik")] <- "Xik"
data$name[which(data$name == "Gl-Cwn")] <- "cwN"
data$name[which(data$name == "Gl-Kyh")] <- "kYH"
data$name[which(data$name == "Gl-Zhw")] <- "ZHw"
data$name[which(data$name == "Gl-Mfa")] <- "MFA"

Wild_type = data[which(data$cell_line == "Wild-Type"),]
Cell_type = data[which(data$cell_line == "Cell-Type 101"),]

# ggplot(data, aes(conc, gene_expression, fill = treatment)) +
#   geom_point(color='black', shape=21, size=2, aes(fill=treatment)) + 
#   scale_fill_manual(values=c('pink', 'lightgreen')) +  
#   ylab("Gene Expression  Gene Expression") +
#   facet_wrap(~ cell_line, ncol = 2, scales = "free") +
#   theme_bw()+
#   theme(strip.background = element_blank(),
#         strip.text = element_text(hjust = -0.01),
#         legend.position="bottom",
#         text = element_text(family = "times")) +
#   scale_x_continuous(breaks = seq(0, 10, by = 1))

## Plot
P_w = ggplot(Wild_type, aes(conc, gene_expression)) +
  geom_label_repel(data=subset(Wild_type, conc > 9),
                   aes(label=name,fill = treatment),
                   xlim=c(10,12),
                   show.legend = FALSE)+
  geom_point(color='black', shape=21, size=3, aes(fill=treatment)) +
  scale_fill_manual(values=c('#78a8d1', '#d5bf98')) +
  ylab("Gene Expression") +
  xlab("μg/ml") + 
  labs(title = "Wild-type", tag = "A", fill = "Treatment") +
  theme_bw()+
  scale_x_continuous(breaks = seq(0, 10, by = 1),limits = c(-0,11))+ 
  theme(
    text = element_text(family = "times",size = 18),
    axis.title = element_text(family = "times",size = 15)
  )
show(P_w)
P_c = ggplot(Cell_type, aes(conc, gene_expression)) +
  geom_label_repel(data=subset(Cell_type, conc > 9),
                   aes(label=name,fill = treatment),
                   xlim=c(10,12),
                   show.legend = FALSE)+
  geom_point(color='black', shape=21, size=3, aes(fill=treatment)) + 
  scale_fill_manual(values=c('#78a8d1', '#d5bf98')) +
  ylab("Gene Expression") +
  xlab("μg/ml") + 
  labs(title = "Cell-type 101", tag = "B", fill = "Treatment") +
  theme_bw()+
  scale_x_continuous(breaks = seq(0, 10, by = 1),limits = c(-0,11))+ 
  theme(
    text = element_text(family = "times",size = 18),
    axis.title = element_text(family = "times",size = 15)
  )


p = ggarrange(P_w, P_c, ncol=2, common.legend = TRUE, legend="bottom")



show(p)
ggsave(
  filename = here::here("figs", "gene_plot.pdf"), 
  plot = p, 
  width = 9, 
  height = 6,
  units = "in",
  dpi = 500
)
