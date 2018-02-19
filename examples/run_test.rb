require "json-schema"
#require "circuitdata"


# Test the Product
puts "Testing the \"All elements\" file"
puts JSON::Validator.fully_validate('../schema/v1/ottp_circuitdata_schema.json', 'testfile-all-elements.json', :errors_as_objects => true)
