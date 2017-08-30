require "json-schema"

# Test the Product
puts "Test the Product"
JSON::Validator.validate!('ottp_circuitdata_schema.json', 'testfile-product.json')

# Test the Stackup
puts "Test the Stackup"
JSON::Validator.validate!('ottp_circuitdata_schema.json', 'testfile-stackup.json')

# Test the Profile defaults
puts "Test the Profile defaults"
JSON::Validator.validate!('ottp_circuitdata_schema.json', 'testfile-profile-default.json')

# Test the Profile required
puts "Test the Profile required"
JSON::Validator.validate!('ottp_circuitdata_schema.json', 'testfile-profile-enforced.json')

# Test the Profile restricted
puts "Test the Profile restricted"
JSON::Validator.validate!('ottp_circuitdata_schema.json', 'testfile-profile-restricted.json')

# Test the Capabilities
puts "Test the Capabilities"
JSON::Validator.validate!('ottp_circuitdata_schema.json', 'testfile-capability.json')
