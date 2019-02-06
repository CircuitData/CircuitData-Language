# CircuitData Language
An open language for communicating specifications on a printed circuit (mainly Printed Circuit Boards - PCBs). Can be used to interchange information on the specification (fabrication data only), a profile (requirements and default values when exchanging data) and capabilities (the production facility capabilities of a supplier). It can also be used to exchange a material list or other needed related data.

## How to use this documentation
* If you are looking for how to communicate a specific technology, use our [howto](/Howto.md)
* Specifying products is documented [here](/Products.md)
* Setting a profile or capability is [here](/Profiles_and_Capabilities.md)
* Specifying materials is documented [here](/Materials.md)
* A table of the structure of all objects, items and tags is [here](/Product_structure_table.md)

## Version
Current version is 1.0. This should stated in every section directly below the "circuitdata" element in an element called "version".

### Versioning
CircuitData Language uses [semver](https://semver.org/). This means that we try our best to ensure that breaking changes mean a change in version number of the first component of the version.

For example a change from `1.0` to `2.0` means that there have been breaking changes to the structure or allowed values in the language. If the version is changed by only the secondary component then it is a non breaking change. This means tooling compatible with the previous version should also be compatible with the next version. For example `1.1` to `1.2` is a non breaking change.

### Releases of new versions

The next version of the language is maintained on the master branch of this repository within the `schema/next` folder. Versions are created through the following process:
1. Copy the files from `schema/next` to `schema/[version number]`.
1. Bump the version number in this readme.
1. Create a PR to make the change.
1. Have the PR approved and merged.
1. Tagging the merge commit from above so that it appears in the [releases](/releases) section.

All releases are accompanied by a post to [CircuitData Forum](https://www.circuitdata.org/). See:
- [1.0](https://www.circuitdata.org/t/x1gkmg/v1-released)

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

## The custom elements
As described in the [Open Trade Transfer Package](https://github.com/elmatica/Open-Trade-Transfer-Package#the-custom-elements) project, a file can contain an element called `custom`. This element is where you place description of colors, materials or additional elements. Custom objects are always listed in an array.

### Colors
Describing colors is part of the OTTP project. You'll find the documentation [here](https://github.com/elmatica/Open-Trade-Transfer-Package#colors)

## Contributing to the project
We really appreciate all involvement. If you feel that there are additions or changes needed to the language, please start out by raising the issue in the [CircuitData Forum](https://www.circuitdata.org/). Then clone this repo and branch out before you make your changes. Please use a branch name that explains what you want to add. When you are done and have tested it, make a Pull Request in this GitHub project. It is the board of CircuitData that decided when code is to merged with the master and thus become part of the language.
