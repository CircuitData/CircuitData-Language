# OTTP: CircuitData
An open standard for communicating information needed for PCB fabrication. Can be used to interchange information on the specification (fabrication data only), a profile (requirements and default values when exchanging data) and capabilities (the production facility capabilities of a supplier). It can also be used to exchange a material list or other needed related data.

## Based on the Open Trade Transfer Package format
[Open Trade Transfer Package](https://github.com/elmatica/Open-Trade-Transfer-Package) defines a structure on how the information is to be passed in either JSON or XML format. Printed Circuit data should be placed within an element called "printed_circuits_fabrication_data" and also contain a version. Printed Circuit data can be placed within the following subelements:

- products
- profiles
  - defaults
  - enforced
  - restricted
- capabilities
  - summary
  - materials

You can also place custom elements in the appropriate folder, such as colors and materials.

## Version
Current version is 0.1. This should stated in every section directly below the "printed_circuits_fabrication_data" element in an element called "version".

## Example
This example shows how to specify how to set a company profile that forbids production of printed circuit boards in countries that are not NATO members. More examples can be found in the examples folder.
```
{
  "open_trade_transfer_package": {
    "version": "0.1",
    "information": {
      "company_name": "Elmatica as",
      "date": "2017-04-03T08:00CET"
    },
    "profiles": {
      "restricted": {
        "printed_circuits_fabrication_data": {
          "version": "0.1",
          "country_of_origin": {
            "nato_member": false
          }
        }
      }
    }
  }
}
```

## JSON schema
JSON schema is available in at its [own site (schema.circuitdata.org)](http://schema.circuitdata.org) in version folders. The schema allows you to validate your OTTP file syntax. An example of how this is done in Ruby with the [json-schema GEM](https://github.com/ruby-json-schema/json-schema) below:

```
ottp = '{
  "open_trade_transfer_package": {
    "version": "1.0",
    "information": {
      "company": "Elmatica as",
      "created": "2017-04-03T08:00:00Z"
    },
    "profiles": {
      "restricted": {
        "generic": {
          "version": "1.0",
          "country_of_origin": {
            "nato_member": false
          }
        }
      }
    }
  }
}'

puts JSON::Validator.validate!('http://schema.circuitdata.org/v1/ottp_circuitdata_schema.json', ottp)
```

## abbreviations
Used in the tables below, they carry the following meaning:

- "O": Optional
- "R": Required
- "F": Forbidden

## Possible elements
The name of the element as it is to be used in the file is included behind the title within the parenthesis, e.g. "soldermask". When a table of possible elements is present, you will find the following headers (see above for structure and abbreviations):

- "Data tag": The name of the elements
- "Format": The format of the element (possible formats listed in the Open Trade Data Package format specification )
- "P": When used in a Products part of the file (to give a specification)
- "PD": When used in a Profiles->Defaults part of the file, Possible formats are "Range", "Stringlist", "Integer" or "Float".
- "PE": When used in a Profiles->Enforced part of the file, Possible formats are "Range", "Stringlist", "Integer" or "Float".
- "PR": When used in a Profiles->Restricted part of the file, Possible formats are "Range", "Stringlist", "Integer" or "Float".
- "C": When used in a Capabilities part of the file, Possible formats are "Range", "Stringlist", "Integer" or "Float".

If the element have alternative names in everyday use, this is referenced as an "Alias" and stated just below the title.

IMPORTANT: Any data in profiles or capabilities, "PD", "PE", "PR" or "C" must be in the formats "Range", "Stringlist", "Integer" or "Float".
