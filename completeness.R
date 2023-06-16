# Create an empty list to store completeness values per sample
completeness_list <- list()

# Extract the completeness values per sample
for (sample_name in names(data_frames)) {
  completeness_values <- data_frames[[sample_name]]$Completeness
  completeness_list[[sample_name]] <- completeness_values
}

boxplot(completeness_list)
completeness_medians <- lapply(completeness_list, median)

# Get the indices that would sort the list in decreasing order
completeness_medians_sorted_indices <- order(unlist(medians), decreasing = TRUE)

# Rearrange the list based on the sorted indices
completeness_medians_sorted <- completeness_medians[completeness_medians_sorted_indices]

filtered_completeness <- list()

# Iterate over each sample in the completeness list
for (sample_name in names(completeness_list)) {
  completeness_values <- completeness_list[[sample_name]]
  median_value <- median(completeness_values)
  
  if (median_value >= 50) {
    filtered_completeness[[sample_name]] <- completeness_values
  }
}

boxplot(filtered_completeness)
boxplot(combined_df$Completeness ~ combined_df$Completeness_Model_Used,
        col = c("#64B5F6", "#EF5350"),
        ylab = "Completeness",
        xlab = "Completeness Model Used",
        main = "Completeness Score Based on the Machine Learning Model Used")

# Set the desired width and height for the plot in inches
plot_width <- 8
plot_height <- 6

# Calculate the resolution based on A4 paper size (assuming 300 pixels per inch)
resolution <- 300

# Calculate the width and height in pixels
width_pixels <- plot_width * resolution
height_pixels <- plot_height * resolution

# Set the file path and name for the PNG file
output_file <- "completeness_by_model.png"

# Create the PNG device with the specified dimensions and resolution
png(output_file, width = width_pixels, height = height_pixels, res = resolution)

# Create the boxplot with customized options
boxplot(combined_df$Completeness ~ combined_df$Completeness_Model_Used,
        col = c("blue", "red"),
        ylab = "Completeness",
        xlab = "Completeness Model Used",
        main = "Completeness Score Based on the Model Used")

# Save the plot to the PNG file
dev.off()
