# Create an empty plot
plot(NULL, xlim = c(0, 100), ylim = c(0, 25), xlab = "Completeness", ylab = "tRNA", main = "Scatterplot of Completeness vs tRNA Values \n based on sample")

# Define a color palette for different samples
colors <- rainbow(length(data_frames))

# Iterate through the samples
for (i in 1:length(data_frames)) {
  sample_name <- names(data_frames)[i]
  sample_data <- data_frames[[sample_name]]
  
  # Plot the scatterplot for the current sample
  points(sample_data$Completeness, sample_data$tRNA, col = colors[i], pch = 16)
}

# Create an empty plot
plot(NULL, xlim = c(0, 100), ylim = c(0, 25), xlab = "Completeness", ylab = "tRNA", main = "Scatterplot of Completeness vs tRNA Values \n based on taxonomy level")

for (t in levels(combined_df$taxonomic_level)) {
  dat <- combined_df[combined_df$taxonomic_level == t,]
  points(dat$Completeness, dat$tRNA, col = colours, pch = 16)
}
