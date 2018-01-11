# CircuitData Language
An open language for communicating specifications on a printed circuit (mainly Printed Circuit Boards - PCB). Can be used to interchange information on the specification (fabrication data only), a profile (requirements and default values when exchanging data) and capabilities (the production facility capabilities of a supplier). It can also be used to exchange a material list or other needed related data.

This is the main documentation. You can find documents describing the structures below and use the [howto](/Howto.md) to find information on how to specify different technologies.

## Based on the Open Trade Transfer Package format (OTTP)
[Open Trade Transfer Package](https://elmatica.github.io/Open-Trade-Transfer-Package/) defines a structure on how the information is to be passed in either JSON or XML format. Printed Circuit data should be placed within an element called "circuitdata" and also contain a version. "circuitdata" objects can be placed within the following sub-objects:

- products
- profiles
  - defaults
  - enforced
  - restricted
- capabilities
  - summary
  - materials
- custom
  - colors
  - material
  - additional_requirements

## Version
Current version is 1.0. This should stated in every section directly below the "circuitdata" element in an element called "version".

## Documentation on the various subelements
### Products
* Specifying products are documented [here](/Products.md)
* A table of the structure of all objects, items and tags is [here](/Product_structure_table.md)


## JSON schema
JSON schema is available in at its [own site (schema.circuitdata.org)](http://schema.circuitdata.org) in version folders. The schema allows you to validate your OTTP file syntax. An example of how this is done in Ruby with the [json-schema GEM](https://github.com/ruby-json-schema/json-schema) below:

```
ottp = '{
  "open_trade_transfer_package": {
    "version": 1.0,
    "information": {
      "company": "Elmatica as",
      "created": "2017-04-03T08:00:00Z"
    },
    "profiles": {
      "restricted": {
        "circuitdata": {
          "generic": {
            "version": 1.0,
            "country_of_origin": {
              "nato_member": false
            }
          }
        }
      }
    }
  }
}'

puts JSON::Validator.validate!('http://schema.circuitdata.org/v1/ottp_circuitdata_schema.json', ottp)
```

## About types and how to use them
Under each element and subelement, you'll find the type that is expected there. These are to be understood as this:
* **object** - the element will contain other elements
* **array** - a list/array of value or elements. In JSON the values are enclosed in brackets. E.g. `[1, 2, 3]` or `["white", "yellow", "blue"]`
* **number** - any number. In JSON this is given without hyphens, e.g. `1.2` or `1`. If a whole number is expected, then this will be stated with `number (integer)` as the type.
* **string** - any set of characters, e.g. `"white"`.
* **boolean** - either `true` or `false`

## Restrictions on values
The following restrictions can inflict on the values, and will be stated under each element.
* **minimum** - a minimum value that a numeric type can meet
* **maximum** - a maximum value that a numeric type can meet
* **enum/possible values** - a list of values that a string can match. Any value that does not match will be rejected by the schema.

## arrays in restrictive profiles
All elements in a restrictive profile are to be understood as values that are not allowed in products. The exception is a numeric, which is the opposite as long as there are no *enum/possible values* present.
* **number** - always two values, to represent the minimum and maximum ALLOWED number that the element in a product must meet. E.g. a `rigid_conductive_layer->count` represented as `[2, 4]` would be understood that anything outside a count of 2 too 4 layers would be restricted. If the element has *enum/possible values* it is to be treated as a normal array, and each value represents a forbidden value.
* **boolean** - can be either `[true]` - true is not allowed, `[false]` - false is not allowed, `[true, false]` - neither value is allowed.
* **string** - can be any string, and would restrict that value. If a `enum/possible values` are set, only these values can be part of the array of strings

## The custom elements
As described in the [Open Trade Transfer Package](https://github.com/elmatica/Open-Trade-Transfer-Package) project, a file can contain an element called `custom`. This element is where you place description of colors, materials or additional elements. Custom objects are always listed in an array.

### Colors
Describing colors is part of the OTTP project, and needs no `printed_circuits_fabrication_data` element.
**Example:**
```
...
  "custom": {
    "colors": [
      {
        "name": "orange",
        "type": "hex",
        "value": "#f4ad42"
      }
    ]
  }
...
```
### Materials
Materials in CircuitData is devided into three different kinds: `dielectrics`, `soldermasks` and `stiffeners`. As they are part of the CircuitData they need to be wrapped in an `printed_circuits_fabrication_data` element.
**Example:**
```
...
  "custom": {
    "materials": {
      "soldermasks": [
        {
          "name": "FR-4 Lead Free",
          "ul": true
        }      
      ]
    }
  }
...
```
### Additional requirements
This section is for all items that are not are not part of the CircuitData language yet.

## Contributing to the project
We really appreciate all involvement. If you feel that there are additions or changes needed to the language, please start out by raising the issue in the [CircuitData Forum](https://www.circuitdata.org/). Then clone this repo and branch out before you make your changes. Please use a branch name that explains what you want to add. When you are done and have tested it, make a Pull Request in this GitHub project. It is the board of CircuitData that decided when code is to merged with the master and thus become part of the language.
