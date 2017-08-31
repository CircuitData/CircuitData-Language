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
#pe = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-profile-enforced.json')
#if pe.count > 0
#  puts "ERRORS DETECTED:"
#  pe.each do |error|
#    puts "-- #{error}"
#  end
#end

# Test the Profile restricted
puts "Test the Profile restricted"
#pr = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-profile-restricted.json')
#f pr.count > 0
#  puts "ERRORS DETECTED:"
#  pr.each do |error|
#    puts "-- #{error}"
#  end
#end

# Test the Capabilities
puts "Test the Capabilities"
cp = JSON::Validator.fully_validate('ottp_circuitdata_schema.json', 'testfile-capability.json')
if cp.count > 0
  puts "ERRORS DETECTED:"
  cp.each do |error|
    puts "-- #{error}"
  end
end

# CONVERT TO CROSS-CHECKER
puts "Test cross-check"
puts "-- read the schema"
#raw_schema = JSON.parse(File.read('ottp_circuitdata_schema.json'))
#include Hashie::Extensions::DeepMerge
#raw_schema.extend Hashie::Extensions::DeepFind

schema = {
"$schema": "http://json-schema.org/draft-04/schema#",
"type": "object",
"additionalProperties": false,
"required": ["open_trade_transfer_package"],
"properties": {
  "open_trade_transfer_package": {
    "type": "object",
    "properties": {
      "version": {
        "type": "string",
        "pattern": "^1.0$"
      },
      "information": {
        "$ref": "https://raw.githubusercontent.com/elmatica/Open-Trade-Transfer-Package/master/v1/ottp_schema_definitions.json#/definitions/information"
      },
      "products": {
        "type": "object",
        "properties": {
          "generic": {
            "type": "object",
            "properties": {},
            "id": "generic",
            "description": "this should validate any element under generic to be valid"
          }
        },
        "patternProperties": {
          "^(?!generic$).*": {
            "type": "object",
            "required": ["printed_circuits_fabrication_data"],
            "properties": {
              "printed_circuits_fabrication_data": {
                "type": "object",
                "required": ["version"],
                "properties": {
                  "stackup": {
                    "type": "object",
                    "properties": {
                      "specified": {
                        "type": "object",
                        "properties": {
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
}


restriction_file = JSON.parse(File.read('testfile-profile-enforced.json'))
if restriction_file["open_trade_transfer_package"].has_key? "profiles"
  # RUN THROUGH THE ENFORCED
  if restriction_file["open_trade_transfer_package"]["profiles"].has_key? "enforced"
    if restriction_file["open_trade_transfer_package"]["profiles"]["enforced"].has_key? "printed_circuits_fabrication_data"
      restriction_file["open_trade_transfer_package"]["profiles"]["enforced"]["printed_circuits_fabrication_data"].each do |key, value|
        if restriction_file["open_trade_transfer_package"]["profiles"]["enforced"]["printed_circuits_fabrication_data"][key].is_a? Hash
          restriction_file["open_trade_transfer_package"]["profiles"]["enforced"]["printed_circuits_fabrication_data"][key].each do |subkey, subvalue|
            schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym] = {:type => "object", :properties => {} } unless schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties].has_key? key.to_sym
            schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym] = {:type => "object", :properties => {} } unless schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties].has_key? key.to_sym
            if subvalue.is_a? String
              if subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$") #This is a value range
                from, too = subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$").captures
                newhash = eval("{:minimum => #{from}, :maximum => #{too}}")
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
              else # This is a normal string - check for commas
                enum = []
                subvalue.split(',').each { |enumvalue| enum << enumvalue }
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
              end
            elsif subvalue.is_a? Numeric # This is a normal string
              schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
              schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
            end
          end
        end
      end
    end
  # RUN THROUGH THE RESTRICTED
  elsif restriction_file["open_trade_transfer_package"]["profiles"].has_key? "restricted"
    if restriction_file["open_trade_transfer_package"]["profiles"]["restricted"].has_key? "printed_circuits_fabrication_data"
      restriction_file["open_trade_transfer_package"]["profiles"]["restricted"]["printed_circuits_fabrication_data"].each do |key, value|
        if restriction_file["open_trade_transfer_package"]["profiles"]["restricted"]["printed_circuits_fabrication_data"][key].is_a? Hash
          restriction_file["open_trade_transfer_package"]["profiles"]["restricted"]["printed_circuits_fabrication_data"][key].each do |subkey, subvalue|
            schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym] = {:type => "object", :properties => {} } unless schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties].has_key? key.to_sym
            schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym] = {:type => "object", :properties => {} } unless schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties].has_key? key.to_sym
            if subvalue.is_a? String
              if subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$") #This is a value range
                from, too = subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$").captures
                newhash = eval("{:minimum => #{from}, :maximum => #{too}}")
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
              else # This is a normal string - check for commas
                enum = []
                subvalue.split(',').each { |enumvalue| enum << enumvalue }
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
                schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
              end
            elsif subvalue.is_a? Numeric # This is a normal string
              schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
              schema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
            end
          end
        end
      end
    end
  end
end


puts JSON::Validator.fully_validate(schema.to_json, 'testfile-product.json', :validate_schema => true, :errors_as_objects => true)
