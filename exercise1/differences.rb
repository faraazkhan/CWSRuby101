#!/usr/bin/env ruby

#puts Prints the output
#File.open opens a referenced file and returns a File object
#readlines is an instance method on the File class that reads
#all lines of the file and returns them as an array of strings
puts File.open('old_facilities.txt').readlines
