# CWS Ruby 101
This is a set of exercises for the Ruby 101 Program I am conducting at
CWS

## Exercise 1
Get a list of all current facilities with:
`ruby differences.rb`

* Print a list of all Facilities that were added
* Print a list of all Facilities that were removed
* Print a statement summarizing the additions and deletions at the top.
  Example: "25 Facilities were added and 15 removed"
* For each Facility that was added print the number of characters
* Parameterize the file names. You should be able to run the script
  with:
  ` ruby differences.rb old_facilities.txt new_facilities.txt`
* Make the script work across platforms with full paths (windows and linux) and remove
  the need for case sensitivity (i.e. old_facilities.txt,
C:\Users\username\CWSRub101\old_facilities.txt and
OLD_faciLIties.txt should all work)
* Set defaults. If a file name is not provided (for both old and new),
  the script should default to our names (old_facilities and
new_facilities)
* Now generate a report file. Report.txt with your output
* Now allows users to generate a report for only facilities that contain
  a certain string. For instance all FMC facilities start with FMC
