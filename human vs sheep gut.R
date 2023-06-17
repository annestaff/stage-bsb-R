summary(human_gut)

boxplot(human_gut$tRNA, sheep_gut$tRNA)
boxplot(human_gut$GC_Content, sheep_gut$GC_Content)
boxplot(human_gut$Completeness, sheep_gut$Completeness)
boxplot(human_gut$Contamination, sheep_gut$Contamination)
boxplot(human_gut$Genome_Size, sheep_gut$Genome_Size[sheep_gut$Genome_Size < 1e+07])

# Create an empty plot
plot(NULL, xlim = c(0, max(human_gut$GC_Content)), ylim = c(0, max(human_gut$tRNA)), xlab = "GC content", ylab = "tRNA", main = "Scatterplot of [] vs [] \n in human and sheep gut")
points(human_gut$GC_Content, human_gut$tRNA, col = colours[1], pch = 16)
points(sheep_gut$GC_Content, sheep_gut$tRNA, col = colours[2], pch = 16)

barplot(rbind(table(human_gut$taxonomic_level)/nrow(human_gut), table(sheep_gut$taxonomic_level)/nrow(sheep_gut)), beside = T,
        main = "Relative proportion of each taxonomic level identified\n in gut samples", xlab = "Proportion of identified genomes",
        ylab = "Taxonomic level", col = colours[1:2], legend.text = c("Human gut", "Sheep gut"))
