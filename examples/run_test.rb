require "json-schema"

schema_path = File.join(__dir__, "../schema/v1/ottp_circuitdata_schema.json")

Dir[File.join(__dir__, "**.json")].each do |file_name|
  local_name = file_name.sub(__dir__, "")

  print "Testing: #{local_name}"

  result = JSON::Validator.fully_validate(
    schema_path,
    file_name,
    errors_as_objects: true,
  )

  if result.empty?
    puts " ✅"
  else
    puts "  ⚠ FAILED!"
    puts JSON.pretty_generate(result)
    exit 1
  end
end
