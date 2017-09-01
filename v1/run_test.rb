require "json-schema"

if RUBY_VERSION.to_f < 2.3
  puts "Must have at least version 2.3.0 of Ruby to run this"
  exit
end


$jsonschema = 'ottp_circuitdata_schema.json'

def crosschecker( productfile, checksfile, validate_origins=true )

  # prepare the return
  returnarray = {
    error: false,
    errormessage: "",
    validationserrors: {},
    restrictederrors: {},
    enforcederrors: {},
    capabilitieserrors: {},
  }

  # Check to see if the URIs are correct on the received files
  if not File.exist?(productfile)
    returnarray[:error] = true
    returnarray[:errormessage] = "Could not access the file to test"
    return returnarray
  end
  if not File.exist?(checksfile)
    returnarray[:error] = true
    returnarray[:errormessage] = "Could not access the file to check agains (profile or capability)"
    return returnarray
  end

  # Validate the original files against the CircuitData schema
  if validate_origins
    prod = JSON::Validator.fully_validate($jsonschema, productfile, :errors_as_objects => true)
    if prod.count > 0
      returnarray[:error] = true
      returnarray[:errormessage] = "Count not validate the product file against the CircuitData json schema"
      prod.each do |valerror|
        returnarray[:validationserrors][valerror[:fragment]] = [] unless returnarray[:validationserrors].has_key? valerror[:fragment]
        scrap, keep, scrap2 = valerror[:message].match("^(The\\sproperty\\s\\'[\\s\\S]*\\'\\s)([\\s\\S]*)(\\sin\\sschema\\sfile[\\s\\S]*)$").captures
        returnarray[:validationserrors][valerror[:fragment]] << keep
      end
    end
    checks = JSON::Validator.fully_validate($jsonschema, checksfile, :errors_as_objects => true)
    if checks.count > 0
      returnarray[:error] = true
      returnarray[:errormessage] = "Count not validate the file to check agains (profile or capability) against the CircuitData json schema"
      checks.each do |valerror|
        returnarray[:validationserrors][valerror[:fragment]] = [] unless returnarray[:validationserrors].has_key? valerror[:fragment]
        scrap, keep, scrap2 = valerror[:message].match("^(The\\sproperty\\s\\'[\\s\\S]*\\'\\s)([\\s\\S]*)(\\sin\\sschema\\sfile[\\s\\S]*)$").captures
        returnarray[:validationserrors][valerror[:fragment]] << keep
      end
      return returnarray
    end
  end

  $has_restrictions = false
  $has_enforced = false
  $has_capabilities = false


  restrictedschema = enforcedschema = capabilityschema = {
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


  checksjson = JSON.parse(File.read(checksfile))
  if checksjson["open_trade_transfer_package"].has_key? "profiles"
    # RUN THROUGH THE ENFORCED
    if checksjson["open_trade_transfer_package"]["profiles"].has_key? "enforced"
      $has_enforced = true
      if checksjson["open_trade_transfer_package"]["profiles"]["enforced"].has_key? "printed_circuits_fabrication_data"
        checksjson["open_trade_transfer_package"]["profiles"]["enforced"]["printed_circuits_fabrication_data"].each do |key, value|
          if checksjson["open_trade_transfer_package"]["profiles"]["enforced"]["printed_circuits_fabrication_data"][key].is_a? Hash
            checksjson["open_trade_transfer_package"]["profiles"]["enforced"]["printed_circuits_fabrication_data"][key].each do |subkey, subvalue|
              enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym] = {:type => "object", :properties => {} } unless enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties].has_key? key.to_sym
              enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym] = {:type => "object", :properties => {} } unless enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties].has_key? key.to_sym
              if subvalue.is_a? String
                if subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$") #This is a value range
                  from, too = subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$").captures
                  newhash = eval("{:minimum => #{from}, :maximum => #{too}}")
                  enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                  enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                else # This is a normal string - check for commas
                  enum = []
                  subvalue.split(',').each { |enumvalue| enum << enumvalue.strip }
                  enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
                  enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
                end
              elsif subvalue.is_a? Numeric # This is a normal string
                enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
                enforcedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
              end
            end
          end
        end
      end
    # RUN THROUGH THE RESTRICTED
    elsif checksjson["open_trade_transfer_package"]["profiles"].has_key? "restricted"
      $has_restrictions = true
      if checksjson["open_trade_transfer_package"]["profiles"]["restricted"].has_key? "printed_circuits_fabrication_data"
        checksjson["open_trade_transfer_package"]["profiles"]["restricted"]["printed_circuits_fabrication_data"].each do |key, value|
          if checksjson["open_trade_transfer_package"]["profiles"]["restricted"]["printed_circuits_fabrication_data"][key].is_a? Hash
            checksjson["open_trade_transfer_package"]["profiles"]["restricted"]["printed_circuits_fabrication_data"][key].each do |subkey, subvalue|
              restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym] = {:type => "object", :properties => {} } unless restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties].has_key? key.to_sym
              restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym] = {:type => "object", :properties => {} } unless restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties].has_key? key.to_sym
              if subvalue.is_a? String
                if subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$") #This is a value range
                  from, too = subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$").captures
                  newhash = {:not => {:allOf => [{:minimum => from.to_f},{:maximum => too.to_f}]}}
                  restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                  restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                else # This is a normal string - check for commas
                  newhash = {:not => {:anyOf => [{ :enum => ""}]}}
                  enum = []
                  subvalue.split(',').each { |enumvalue| enum << enumvalue.strip }
                  newhash[:not][:anyOf][0][:enum] = enum
                  restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                  restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                end
              elsif subvalue.is_a? Numeric # This is a normal string
                newhash = {:not => {:allOf => [{:minimum => subvalue.to_f},{:maximum => subvalue.to_f}]}}
                restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                restrictedschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
              end
            end
          end
        end
      end
    end
  end
  # RUN THROUGH THE CAPABILITIES
  if checksjson["open_trade_transfer_package"].has_key? "capabilities"
    $has_capabilities = true
    if checksjson["open_trade_transfer_package"]["capabilities"].has_key? "printed_circuits_fabrication_data"
      checksjson["open_trade_transfer_package"]["capabilities"]["printed_circuits_fabrication_data"].each do |key, value|
        if checksjson["open_trade_transfer_package"]["capabilities"]["printed_circuits_fabrication_data"][key].is_a? Hash
          checksjson["open_trade_transfer_package"]["capabilities"]["printed_circuits_fabrication_data"][key].each do |subkey, subvalue|
            capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym] = {:type => "object", :properties => {} } unless capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties].has_key? key.to_sym
            capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym] = {:type => "object", :properties => {} } unless capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties].has_key? key.to_sym
            if subvalue.is_a? String
              if subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$") #This is a value range
                from, too = subvalue.match("^(\\d*|\\d*.\\d*)\\.\\.\\.(\\d*|\\d*.\\d*)$").captures
                newhash = eval("{:minimum => #{from}, :maximum => #{too}}")
                capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
                capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = newhash
              else # This is a normal string - check for commas
                enum = []
                subvalue.split(',').each { |enumvalue| enum << enumvalue.strip }
                capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
                capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => #{enum}}")
              end
            elsif subvalue.is_a? Numeric # This is a normal string
              capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
              capabilityschema[:properties][:open_trade_transfer_package][:properties][:products][:patternProperties][:"^(?!generic$).*"][:properties][:printed_circuits_fabrication_data][:properties][:stackup][:properties][:specified][:properties][key.to_sym][:properties][subkey.to_sym] = eval("{:enum => [#{subvalue.to_s}]}")
            end
          end
        end
      end
    end
  end

  # Test enforced
  if $has_enforced
    enforcedvalidate = JSON::Validator.fully_validate(enforcedschema.to_json, productfile, :errors_as_objects => true)
    if enforcedvalidate.count > 0
      returnarray[:error] = true
      returnarray[:errormessage] = "The product to check did not meet the requirements"
      enforcedvalidate.each do |valerror|
        returnarray[:enforcederrors][valerror[:fragment]] = [] unless returnarray[:enforcederrors].has_key? valerror[:fragment]
        begin
          scrap, keep, scrap2 = valerror[:message].match("^(The\\sproperty\\s\\'[\\s\\S]*\\'\\s)([\\s\\S]*)(\\sin\\sschema[\\s\\S]*)$").captures
        rescue
          keep = valerror[:message]
        end
        returnarray[:enforcederrors][valerror[:fragment]] << keep
      end
    end
  end


  # Test restricted
  if $has_restrictions
    restrictedvalidate = JSON::Validator.fully_validate(restrictedschema.to_json, productfile, :errors_as_objects => true)
    if restrictedvalidate.count > 0
      returnarray[:error] = true
      returnarray[:errormessage] = "The product to check did not meet the requirements"
      restrictedvalidate.each do |valerror|
        returnarray[:restrictederrors][valerror[:fragment]] = [] unless returnarray[:restrictederrors].has_key? valerror[:fragment]
        begin
          scrap, keep, scrap2 = valerror[:message].match("^(The\\sproperty\\s\\'[\\s\\S]*\\'\\s)([\\s\\S]*)(\\sin\\sschema[\\s\\S]*)$").captures
        rescue
          keep = valerror[:message]
        end
        returnarray[:restrictederrors][valerror[:fragment]] << keep
      end
    end
  end

  # Test capabilites
  if $has_capabilities
    capabilitiesvalidate = JSON::Validator.fully_validate(capabilityschema.to_json, productfile, :errors_as_objects => true)
    if capabilitiesvalidate.count > 0
      returnarray[:error] = true
      returnarray[:errormessage] = "The product to check did not meet the requirements"
      capabilitiesvalidate.each do |valerror|
        returnarray[:capabilitieserrors][valerror[:fragment]] = [] unless returnarray[:capabilitieserrors].has_key? valerror[:fragment]
        begin
          scrap, keep, scrap2 = valerror[:message].match("^(The\\sproperty\\s\\'[\\s\\S]*\\'\\s)([\\s\\S]*)(\\sin\\sschema[\\s\\S]*)$").captures
        rescue
          keep = valerror[:message]
        end
        returnarray[:capabilitieserrors][valerror[:fragment]] << keep
      end
    end
  end

  return returnarray

end


# Test the Product
puts "Test the Product"
prod = JSON::Validator.fully_validate($jsonschema, 'testfile-product.json')
if prod.count > 0
  puts "ERRORS DETECTED:"
  prod.each do |error|
    puts "-- #{error}"
  end
end

# Test the Stackup
puts "Test the Stackup"
stackupreturn = JSON::Validator.fully_validate($jsonschema, 'testfile-stackup.json')
if stackupreturn.count > 0
  puts "ERRORS DETECTED:"
  stackupreturn.each do |error|
    puts "-- #{error}"
  end
end

# Test the Profile defaults
puts "Test the Profile defaults"
puts crosschecker( 'testfile-product.json', 'testfile-profile-default.json' )

# Test the Profile required
puts "Test the Profile enforced"
puts crosschecker( 'testfile-product.json', 'testfile-profile-enforced.json' )

# Test the Profile restricted
puts "Test the Profile restricted"
puts crosschecker( 'testfile-product.json', 'testfile-profile-restricted.json' )

# Test the Capabilities
puts "Test the Capabilities"
puts crosschecker( 'testfile-product.json', 'testfile-capability.json' )
