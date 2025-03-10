# Getting the current timestamp
timestamp=$(date "+%F-%T")

# Defining the path to the dataset
data_file="/home/salapati22/cs131/a1/2019-01-h1.csv"

# Defining an array of vendor IDs
vendor_ids=("1.0" "2.0" "4.0")

# Making sure that  the output files start fresh each run
> .gitignore
> ws4.txt

# Print the vendor IDs (for debugging purposes)
echo "Vendor IDs: ${vendor_ids[@]}"

# For-loop to loop through each vendor ID
for vendor in "${vendor_ids[@]}"; do
    # Print the vendor currently being processed (for debugging purposes)
    echo "Processing vendor: $vendor"
    
    # Extract lines where the first column matches the vendor ID
    grep "^$vendor," "$data_file" > "${timestamp}-${vendor}.csv"

    # Check if the file was successfully created and has content
    if [[ -s "${timestamp}-${vendor}.csv" ]]; then
        echo "${timestamp}-${vendor}.csv created successfully."
    else
        echo "Error: No data for vendor $vendor."
    fi

    # Adding the generated CSV file to .gitignore
    echo "${timestamp}-${vendor}.csv" >> .gitignore
done

# Add wc results to ws4.txt
wc -l "${timestamp}-"*.csv > ws4.txt

# Append .gitignore contents to ws4.txt
echo -e "\nContents of .gitignore:" >> ws4.txt
cat .gitignore >> ws4.txt
