summary(combined_df)
boxplot(combined_df$tRNA ~ combined_df$taxonomic_level)
boxplot(combined_df$Coding_Density ~ combined_df$taxonomic_level)
boxplot(combined_df$GC_Content ~ combined_df$taxonomic_level)
boxplot(combined_df$Genome_Size[combined_df$Genome_Size < 1e+07] ~ combined_df$taxonomic_level[combined_df$Genome_Size < 1e+07])
boxplot(combined_df$Average_Gene_Length ~ combined_df$taxonomic_level)

barplot(table(combined_df$taxonomic_level),
        xlab = "Taxonomic Levels", ylab = "Count",
        main = "Distribution of Taxonomic Levels", col = colours)
