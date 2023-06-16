plot(combined_gunc$Genome_Size[combined_gunc$Genome_Size < 1e+07] ~ combined_gunc$Average_Gene_Length[combined_gunc$Genome_Size < 1e+07])

output_file <- "correlation_heatmap.svg"

# Create the PNG device with the desired dimensions and resolution
svg(output_file)

# Select columns with numerical values
numerical_columns <- sapply(combined_df, is.numeric)

# Filter out N/A values
filtered_df <- combined_df[, numerical_columns]
filtered_df <- filtered_df[complete.cases(filtered_df), ]

# Calculate the correlation matrix
correlation_matrix <- cor(filtered_df)

# Create a heatmap of the correlation matrix
heatmap(correlation_matrix, 
        col = colorRampPalette(c("#64B5F6", "white", "#EF5350"))(100),
        main = "Correlation Matrix of Bin Characteristics")
dev.off()

# Iterate through the list of data frames
for (sample_name in names(data_frames)) {
  # Filter out N/A values
  filtered_df <- data_frames[[sample_name]][, numerical_columns]
  filtered_df <- filtered_df[complete.cases(filtered_df), ]
  
  # Filter out rows with missing values
  complete_rows <- complete.cases(filtered_df)
  filtered_df <- filtered_df[complete_rows, ]
  
  # Filter out columns with zero standard deviation
  non_zero_std_columns <- apply(filtered_df, 2, sd) != 0
  filtered_df <- filtered_df[, non_zero_std_columns]
  
  # Calculate the correlation matrix for the current sample
  correlation_matrix <- cor(filtered_df)
  
  # Set the file path and name for the SVG file
  output_file <- paste0(sample_name, ".correlation_heatmap.svg")
  
  # Create the SVG device with the desired dimensions
  svg(output_file)
  
  # Create the heatmap of the correlation matrix for the current sample
  heatmap(correlation_matrix, 
          col = colorRampPalette(c("#64B5F6", "white", "#EF5350"))(100),
          main = paste("Correlation Matrix of Bin Characteristics -", sample_name))
  
  # Save the plot to the SVG file
  dev.off()
}

# Set the significance threshold for correlation scores
significance_threshold <- 0.9

# Iterate through the list of data frames
for (sample_name in names(data_frames)) {
  # Select the relevant bin characteristics for the current sample
  selected_characteristics <- data_frames[[sample_name]][, numerical_columns]
  
  # Filter out rows with missing values
  complete_rows <- complete.cases(selected_characteristics)
  selected_characteristics <- selected_characteristics[complete_rows, ]
  
  # Filter out columns with zero standard deviation
  non_zero_std_columns <- apply(selected_characteristics, 2, sd) != 0
  selected_characteristics <- selected_characteristics[, non_zero_std_columns]
  
  # Calculate the correlation matrix for the current sample
  correlation_matrix <- cor(selected_characteristics)
  
  # Find the significant correlations
  significant_correlations <- which(abs(correlation_matrix) >= significance_threshold, arr.ind = TRUE)
  # exclude matrix diagonal
  significant_correlations <- significant_correlations[significant_correlations[,1] != significant_correlations[,2],]
  
  # Create a data frame to store the significant correlations
  significant_correlations_df <- data.frame(
    Row = rownames(correlation_matrix)[significant_correlations[, 1]],
    Column = colnames(correlation_matrix)[significant_correlations[, 2]],
    Correlation = correlation_matrix[significant_correlations]
  )
  
  # Set the file path and name for the CSV file
  output_file <- paste0(sample_name, ".significant_correlations.csv")
  
  # Save the significant correlations as a CSV file
  write.csv(significant_correlations_df, file = output_file, row.names = FALSE)
}

# Set the desired width and height for the plot in inches
plot_width <- 8
plot_height <- 6

# Calculate the resolution based on A4 paper size (assuming 300 pixels per inch)
resolution <- 300

# Calculate the width and height in pixels
width_pixels <- plot_width * resolution
height_pixels <- plot_height * resolution

for (sample_name in names(data_frames)) {
  significant_correlations <- read.csv(paste0(sample_name, ".significant_correlations.csv"), stringsAsFactors = F)
  for (i in 1:nrow(significant_correlations)) {
     x <- data_frames[[sample_name]][significant_correlations[i,1]]
     y <- data_frames[[sample_name]][significant_correlations[i,2]]
     output_file <- paste0(sample_name, "_", significant_correlations[i,1], "_", significant_correlations[i,2], ".", "png")
     # Create the PNG device with the specified dimensions and resolution
     png(output_file, width = width_pixels, height = height_pixels, res = resolution)
     plot(x[,1], y[,1], col = colours[2], xlab = significant_correlations[i,1], ylab = significant_correlations[i,2],
          main = sample_name)
     dev.off()
  }
}

