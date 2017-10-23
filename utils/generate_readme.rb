#!/usr/bin/env ruby
require 'json'
require 'circuitdata'

# Script to generate the REAMDE.md file from the schema

newcontent = ""

# Get the start of the file from the partial
File.open("partial_readme_start.md", "r") do |f|
  f.each_line do |line|
    newcontent += line
  end
end

newcontent += "\n"

# Use the circuitdata gem to create documentation based on the schema
newcontent += Circuitdata.create_documentation()

# Write a new file
File.write('../README.md', newcontent)
puts "NEW README.md CREATED"
