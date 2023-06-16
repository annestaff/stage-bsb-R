# Create an empty list to store contamination values per sample
contamination_list <- list()

# Extract the contamination values per sample
for (sample_name in names(data_frames)) {
  contamination_values <- data_frames[[sample_name]]$Contamination
  contamination_list[[sample_name]] <- contamination_values
}

boxplot(contamination_list)
contamination_medians <- lapply(contamination_list, median)

# Get the indices that would sort the list in decreasing order
contamination_medians_sorted_indices <- order(unlist(contamination_medians))

# Rearrange the list based on the sorted indices
contamination_medians_sorted <- contamination_medians[contamination_medians_sorted_indices]

filtered_contamination <- list()

# Iterate over each sample in the contamination list
for (sample_name in names(contamination_list)) {
  contamination_values <- contamination_list[[sample_name]]
  median_value <- median(contamination_values)
  
  if (median_value <= 0.1) {
    filtered_contamination[[sample_name]] <- contamination_values
  }
}

boxplot(filtered_contamination)
plot(combined_df$Completeness ~ combined_df$Contamination)
combined_gunc <- combined_df[combined_df$pass.GUNC,]
plot(combined_gunc$Completeness ~ combined_gunc$Contamination)
