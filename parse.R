library(dplyr)

# Get the list of .csv files in the directory
csv_files <- list.files("../stage-bdb/output_bins/output_csv", pattern = "\\.csv$", full.names = TRUE)

# Create an empty data frame to store the combined data
combined_df <- data.frame()
# Create a list to store the separate data frames
data_frames <- list()


# Loop through each .csv file and import its data
for (csv_file in csv_files) {
  # Extract the sample name from the file name
  sample_name <- tools::file_path_sans_ext(basename(csv_file))
  
  # Read the .csv file and store its data in a separate data frame
  temp_df <- read.csv(csv_file, stringsAsFactors = T)
  
  # Assign the data frame to a variable with the sample name as its name
  assign(sample_name, temp_df, envir = .GlobalEnv)
  
  # Add the data frame to the list
  data_frames[[sample_name]] <- temp_df
  
  # Append the temporary data frame to the combined data frame
  combined_df <- bind_rows(combined_df, temp_df)
}

colours <- c("#64B5F6", "#EF5350", "#81C784", "#FFA000", "#CE93D8", "#FFF59D")
