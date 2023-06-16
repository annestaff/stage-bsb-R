summary(combined_df)
boxplot(combined_gunc$tRNA ~ combined_gunc$taxonomic_level)
boxplot(combined_gunc$Coding_Density ~ combined_gunc$taxonomic_level)
boxplot(combined_gunc$GC_Content ~ combined_gunc$taxonomic_level)
boxplot(combined_gunc$Genome_Size[combined_gunc$Genome_Size < 1e+07] ~ combined_gunc$taxonomic_level[combined_gunc$Genome_Size < 1e+07])
boxplot(combined_gunc$Average_Gene_Length ~ combined_gunc$taxonomic_level)

barplot(table(combined_gunc$taxonomic_level),
        xlab = "Taxonomic Levels", ylab = "Count",
        main = "Distribution of Taxonomic Levels", col = colours)
