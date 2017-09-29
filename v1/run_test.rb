require "json-schema"
require "circuitdata"


# Test the Product
puts "Test the Product"
puts JSON.pretty_generate(Circuitdata.compatibility_checker( 'testfile-product.json' ))

# Test the Stackup
puts "Test the Stackup"
puts JSON.pretty_generate(Circuitdata.compatibility_checker( 'testfile-stackup.json' ))

# Test the Profile defaults
puts "Test the Profile defaults"
puts JSON.pretty_generate(Circuitdata.compatibility_checker( 'testfile-product.json', 'testfile-profile-default.json' ))

# Test the Profile required
puts "Test the Profile enforced"
puts JSON.pretty_generate(Circuitdata.compatibility_checker( 'testfile-product.json', 'testfile-profile-enforced.json' ))

# Test the Profile restricted
puts "Test the Profile restricted"
puts JSON.pretty_generate(Circuitdata.compatibility_checker( 'testfile-product.json', 'testfile-profile-restricted.json' ))

# Test the Capabilities
puts "Test the Capabilities"
puts JSON.pretty_generate(Circuitdata.compatibility_checker( 'testfile-product.json', 'testfile-capability.json' ))
