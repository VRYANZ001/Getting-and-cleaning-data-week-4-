# Getting-and-cleaning-data-week-4-
Brief description of the R run file: 
1. Downloads the dataset using FileURL. 
2. Unzips the folders and stores it in the directory.
3. Create 8 seperate tables for test, train, feature and activity labels  data sets using read.table.
4. Assigns column names to test, train and activity tables. 
5. Merge test and train tables seperately using cbind and then combine the two merged tables using rbind.
6. Create a vector aas a lookup table for ID, mean and standard deviation using grepl
7. Use the lookup to create a subset of the table created in 5. Merge this with activity tables to appropriately label the activities. 
8. Create a seperate table averaging the  table created in 7. 
