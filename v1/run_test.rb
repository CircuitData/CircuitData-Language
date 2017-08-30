require "json-schema"

# Test the Product
puts "Test the Product"
prod = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-product.json')
if prod.count > 0
  puts "ERRORS DETECTED:"
  prod.each do |error|
    puts "-- #{error}"
  end
end

# Test the Stackup
puts "Test the Stackup"
stackupreturn = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-stackup.json')
if stackupreturn.count > 0
  puts "ERRORS DETECTED:"
  stackupreturn.each do |error|
    puts "-- #{error}"
  end
end

# Test the Profile defaults
puts "Test the Profile defaults"
pd = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-profile-default.json')
if pd.count > 0
  puts "ERRORS DETECTED:"
  pd.each do |error|
    puts "-- #{error}"
  end
end

# Test the Profile required
puts "Test the Profile enforced"
pe = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-profile-enforced.json')
if pe.count > 0
  puts "ERRORS DETECTED:"
  pe.each do |error|
    puts "-- #{error}"
  end
end

# Test the Profile restricted
puts "Test the Profile restricted"
pr = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-profile-restricted.json')
if pr.count > 0
  puts "ERRORS DETECTED:"
  pr.each do |error|
    puts "-- #{error}"
  end
end

# Test the Capabilities
puts "Test the Capabilities"
cp = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-capability.json')
if cp.count > 0
  puts "ERRORS DETECTED:"
  cp.each do |error|
    puts "-- #{error}"
  end
end
