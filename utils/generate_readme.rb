#!/usr/bin/env ruby
require 'json'

def get_abbr(tag)
  new = ""
  # Product
  pr = ""
  if tag.has_key? "in_product"
    case tag["in_product"]["state"]
    when "optional"
      pr = " O |"
    when "forbidden"
      pr = " F |"
    when "required"
      pr = " R |"
    else
      pr = " |"
    end
  else
    pr = " |"
  end
  new += pr

  # Profile Default
  pd = ""
  if tag.has_key? "in_profile_default"
    case tag["in_profile_default"]["state"]
    when "optional"
      pd = " O |"
    when "forbidden"
      pd = " F |"
    when "required"
      pd = " R |"
    else
      pd = " |"
    end
  else
    pd = " |"
  end
  new += pd

  # Profile enforced
  pe = ""
  if tag.has_key? "in_profile_enforced"
    case tag["in_profile_enforced"]["state"]
    when "optional"
      pe = " O |"
    when "forbidden"
      pe = " F |"
    when "required"
      pe = " R |"
    else
      pe = " |"
    end
  else
    pe = " |"
  end
  new += pe

  # Profile restricted
  pr = ""
  if tag.has_key? "in_profile_restricted"
    case tag["in_profile_restricted"]["state"]
    when "optional"
      pr = " O |"
    when "forbidden"
      pr = " F |"
    when "required"
      pr = " R |"
    else
      pr = " |"
    end
  else
    pr = " |"
  end
  new += pr

  # Capability
  cp = ""
  if tag.has_key? "in_product"
    case tag["in_product"]["state"]
    when "optional"
      cp = " O |"
    when "forbidden"
      cp = " F |"
    when "required"
      cp = " R |"
    else
      cp = " |"
    end
  else
    cp = " |"
  end
  new += cp

  return new
end

# Script to generate the REAMDE.md file from the schema

newcontent = ""

# Get the start of the file from the partial
File.open("partial_readme_start.md", "r") do |f|
  f.each_line do |line|
    newcontent += line
  end
end

jf = File.read('../schema.json')
data_hash = JSON.parse(jf)
newcontent.sub! "Current version is 0.1.", "Current version is #{data_hash["version"].to_s}."
data_hash["sections"]["elements"].keys.each do |element|
  newcontent += "\n"
  newcontent += "### #{data_hash["sections"]["elements"][element]["name"]} (\"#{element}\")\n"
  if data_hash["sections"]["elements"][element]["aliases"] != ""
    as = "Aliases: "
    data_hash["sections"]["elements"][element]["aliases"].split(",").each do |al|
      as += "\"" + al.strip + "\", "
    end
    newcontent += as.chomp(", ") + "\n"
  end
  newcontent += data_hash["sections"]["elements"][element]["description"] + "\n" unless data_hash["sections"]["elements"][element]["description"] == ""
  newcontent += "This element is a list and can contain several items\n" if data_hash["sections"]["elements"][element]["type"] == "list"
  newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
  data_hash["sections"]["elements"][element]["tags"].each do |tag|
    newcontent += "*#{tag["tag"]}* |" + get_abbr(tag) + " #{tag["description"]}\n"
  end
end

newcontent += "\n\n## Custom elements\n\n"
# COLORS
newcontent += "### Colors\n"
newcontent += data_hash["sections"]["custom"]["colors"]["description"]
newcontent += "\n"
newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
data_hash["sections"]["custom"]["colors"]["tags"].each do |tag|
  newcontent += "*#{tag["tag"]}* |" + get_abbr(tag) + " #{tag["description"]}\n"
end

newcontent += "\n\n### Materials\n"
# SOLDERMASKS
newcontent += "#### Soldermasks\n"
newcontent += data_hash["sections"]["custom"]["material"]["soldermasks"]["description"]
newcontent += "\n"
newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
data_hash["sections"]["custom"]["material"]["soldermasks"]["tags"].each do |tag|
  newcontent += "*#{tag["tag"]}* |" + get_abbr(tag) + " #{tag["description"]}\n"
end
# DIELECTRICS
newcontent += "\n#### Dielectrics\n"
newcontent += data_hash["sections"]["custom"]["material"]["dielectrics"]["description"]
newcontent += "\n"
newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
data_hash["sections"]["custom"]["material"]["dielectrics"]["tags"].each do |tag|
  newcontent += "*#{tag["tag"]}* |" + get_abbr(tag) + " #{tag["description"]}\n"
end
# STIFFENERS
newcontent += "\n#### Stiffeners\n"
newcontent += data_hash["sections"]["custom"]["material"]["stiffener"]["description"]
newcontent += "\n"
newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
data_hash["sections"]["custom"]["material"]["stiffener"]["tags"].each do |tag|
  newcontent += "*#{tag["tag"]}* |" + get_abbr(tag) + " #{tag["description"]}\n"
end
# ADDITIONAL
newcontent += "\n\n## Additional elements\n\n"
newcontent += data_hash["sections"]["custom"]["additional"]["description"]
newcontent += "\n"
newcontent += "\nData tag | Format | P | PD | PE | PR | C | Description\n---------|--------|---|----|----|----|---|--------------\n"
data_hash["sections"]["custom"]["additional"]["tags"].each do |tag|
  newcontent += "*#{tag["tag"]}* |" + get_abbr(tag) + " #{tag["description"]}\n"
end

# Write a new file
File.write('../README.md', newcontent)
puts "NEW README.md CREATED"
