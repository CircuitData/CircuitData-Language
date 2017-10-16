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


newcontent += Circuitdata.create_documentation()

#newcontent += "\n\n## Custom elements\n\n"
# COLORS
#newcontent += "### Colors\n"
#newcontent += data_hash["sections"]["custom"]["colors"]["description"]
#newcontent += "\n"
#newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
#data_hash["sections"]["custom"]["colors"]["tags"].each do |tag|
#  newcontent += "*#{tag["tag"]}* | #{tag["format"]} |" + get_abbr(tag) + " #{tag["description"]}\n"
#end

#newcontent += "\n\n### Materials (\"materials\")\n"
# SOLDERMASKS
#newcontent += "#### Soldermasks\n"
#newcontent += data_hash["sections"]["custom"]["material"]["soldermasks"]["description"]
#newcontent += "\n"
#newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
#data_hash["sections"]["custom"]["material"]["soldermasks"]["tags"].each do |tag|
#  newcontent += "*#{tag["tag"]}* | #{tag["format"]} |" + get_abbr(tag) + " #{tag["description"]}\n"
#end
# DIELECTRICS
#newcontent += "\n#### Dielectrics (\"dielectrics\")\n"
#newcontent += data_hash["sections"]["custom"]["material"]["dielectrics"]["description"]
#newcontent += "\n"
#newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
#data_hash["sections"]["custom"]["material"]["dielectrics"]["tags"].each do |tag|
#  newcontent += "*#{tag["tag"]}* | #{tag["format"]} |" + get_abbr(tag) + " #{tag["description"]}\n"
#end
# STIFFENERS
#newcontent += "\n#### Stiffeners (\"stiffeners\")\n"
#newcontent += data_hash["sections"]["custom"]["material"]["stiffener"]["description"]
#newcontent += "\n"
#newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
#data_hash["sections"]["custom"]["material"]["stiffener"]["tags"].each do |tag|
#  newcontent += "*#{tag["tag"]}* | #{tag["format"]} |" + get_abbr(tag) + " #{tag["description"]}\n"
#end
# ADDITIONAL
#newcontent += "\n\n## Additional elements (\"additional_elements\")\n\n"
#newcontent += data_hash["sections"]["custom"]["additional"]["description"]
#newcontent += "\n"
#newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
#data_hash["sections"]["custom"]["additional"]["tags"].each do |tag|
#  newcontent += "*#{tag["tag"]}* | #{tag["format"]} |" + get_abbr(tag) + " #{tag["description"]}\n"
#end

# Write a new file
File.write('../README.md', newcontent)
puts "NEW README.md CREATED"
