# UnixHandsOn
Base repository for learning unix commands

# Steps

1. Fork this repo.
2. Clone this repo in your local.
3. Create a separate folder with your name and then create folders for each of the problems. For ex: {geethasivakumar/problem(n)}.
4. Solve the problems. Upload the .sh file and output file/screenshot in the respective problem folders.
5. Raise a pull request with your changes

# Problems

# Problem 1 :
 Write a command to print the lines that has the the pattern “july” in all the files in a particular directory?
 
# Problem 2 :
  Write a shell script to print the current date, time, username and current working directory.

# Problem 3 :
  Write a shell script to print the reverse of an input number

  Input : 123
  Output : 321

# Problem 4 :
  Write a shell script to find out the unique words in a file and also count the occurrence of each of these words. We can say that the file under consideration contains many lines, and each line has multiple words.

  Input :  animal.txt is a file
  cat animal.txt
  tiger bear
  elephant tiger bear
  bear

  Output :

  elephant 1
  bear 3
  tiger 2
  
  # Problem 5 :
   The attached csv ( 100 CC Records.csv) file has randomly generated credit card records.
   
   Column: Card Type Code,Card Type Full Name,Issuing Bank,Card Number,Card Holder's Name,CVV/CVV2,Issue Date,Expiry Date,Billing Date,Card PIN,Credit Limit

   PART 1:

   Write a shell script to read the file and create a file each record from csv. The files should be in following format.
   Suppose the "Card Number" is 3587804193769544 and "Expiry Date"  is 08/2023, then the file name should be 3587804193769544.active. If suppose the "Expiry Date" is passed the current month/year then file name should be 3587804193769544.expired

   Details "JC,Japan Credit Bureau,JCB,3587804193769544,Jeffrey J Barnes,337,08/2015,08/2023,2,7675,155600" in file should be as follows:
   Card Type Code: JC
   Card Type Full Name: Japan Credit Bureau
   Issuing Bank: JCB
   Card Number: 3587804193769544
   Card Holder's Name: Jeffrey J Barnes
   CVV/CVV2: 337
   Issue Date: 08/2015
   Expiry Date: 08/2023
   Billing Date: 2
   Card PIN: 7675
   Credit Limit: $155,600 USD

   Note: The Credit Limit should be formatted in United States currency format. Ex: 123456789 => $123,456,789 USD

   These files should be segregated in following format. Parent directories should be name by "Card Type Full Name" from the records. Inside each directories, there should be sub-directories based on "Issuing Bank" from records. 
   The above created files file should be found in these sub-directories based on "Card Type Full Name" and "Issuing Bank".

   PART 2:

   Once the above script has executed successfully, and the expected directory structure is created. Then you need to write a new script which should parse all the .active and .expired files from the sub directories and again write the data in the new file consolidated.csv which should have similar structure and row count as the original file "100 CC Records.csv"

   So basically a reverse script of the initial script.
