# CircuitData Language
An open language for communicating information needed for PCB fabrication. Can be used to interchange information on the specification (fabrication data only), a profile (requirements and default values when exchanging data) and capabilities (the production facility capabilities of a supplier). It can also be used to exchange a material list or other needed related data.

## Based on the Open Trade Transfer Package format (OTTP)
[Open Trade Transfer Package](https://github.com/elmatica/Open-Trade-Transfer-Package) defines a structure on how the information is to be passed in either JSON or XML format. Printed Circuit data should be placed within an element called "printed_circuits_fabrication_data" and also contain a version. Printed Circuit data can be placed within the following subelements:

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
Current version is 0.7. This should stated in every section directly below the "printed_circuits_fabrication_data" element in an element called "version".

## Basic example
This example shows how to specify how to set a company profile that forbids production of printed circuit boards in countries that are not NATO members. More examples can be found in the examples folder.
```
{
  "open_trade_transfer_package": {
    "version": 0.1,
    "information": {
      "company_name": "Elmatica as",
      "date": "2017-04-03T08:00CET"
    },
    "profiles": {
      "restricted": {
        "printed_circuits_fabrication_data": {
          "version": 0.1,
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
    "version": 1.0,
    "information": {
      "company": "Elmatica as",
      "created": "2017-04-03T08:00:00Z"
    },
    "profiles": {
      "restricted": {
        "generic": {
          "version": 1.0,
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

## Elements that are both arrays and objects
Some elememts, such as `dielectric`, `soldermask` and `final_finish` can be both specified in an array or as an object depending on where they are used. If used in a stackup or generic product description, they will be arrays, as there can be several of them listed. When used here, there must be a counterpart in the `custom->materials` section with the same name that describes the material. For all products and capabilities it will be an object. The object can contain all the tags that would be used in the `custom->materials` section and should be compared against each of them to set or control values.

**Example of a dielectric in a generic product section:**
```
...
   "dielectric": ["FR4", "FR4-high-Tg"],
...
  "custom": {
    "materials": {
      "dielectrics": {
        "FR4": {
          "tg_min": 140,
          "ul": true
        },
        "FR4-high-Tg": {
          "tg_min": 150,
          "ul": true
        }
      }
    }
  }
```
**Example of a dielectric in a enforced profile section:**
```
...
   "dielectric": {
     "tg_min": 140,
     "ul": true
    }
...
```
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

## Elements and tags
====================

### stackup [link](#stackup)
* specification_level
* file_name
* specified

### rigid_conductive_layer [link](#rigid_conductive_layer)
* count
* minimum_internal_track_width
* minimum_external_track_width
* minimum_internal_spacing_width
* minimum_external_spacing_width
* external_base_copper_thickness
* internal_base_copper_thickness
* copper_foil_roughness
* copper_coverage_average

### flexible_conductive_layer [link](#flexible_conductive_layer)
* count
* minimum_internal_track_width
* minimum_external_track_width
* minimum_internal_spacing_width
* minimum_external_spacing_width
* external_base_copper_thickness
* internal_base_copper_thickness
* copper_foil_roughness
* copper_coverage_average

### final_finish [link](#final_finish)
* finish
* area
* thickness_min
* thickness_max
* gold_thickness_min
* gold_thickness_max
* silver_thickness_min
* silver_thickness_max
* paladium_thickness_min
* paladium_thickness_max
* tin_thickness_min
* tin_thickness_max
* nickel_thickness_min
* nickel_thickness_max

### dielectric [link](#dielectric)
* name

### soldermask [link](#soldermask)
* color
* finish
* min_thickness
* max_thickness
* material
* top
* bottom
* allow_touchups

### legend [link](#legend)
* color
* top
* bottom

### stiffener [link](#stiffener)
* size
* placement
* thickness
* material

### coverlay [link](#coverlay)
* total_thickness
* top
* bottom
* material

### peelable_mask [link](#peelable_mask)
* heating_operations
* top
* bottom

### kapton_tape [link](#kapton_tape)
* accept_equivalent
* top
* bottom

### conductive_carbon_print [link](#conductive_carbon_print)
* top
* bottom

### silver_print [link](#silver_print)
* top
* bottom

### inner_packaging [link](#inner_packaging)
* type_of_bag
* hic
* esd
* desiccant
* vacuum

### via_protection [link](#via_protection)
* type_1
* type_2
* type_3
* type_4a
* type_4b
* type_5
* type_6a
* type_6b
* type_7

### board [link](#board)
* size_x
* size_y
* thickness

### array [link](#array)
* size_x
* size_y
* boards_x
* boards_y
* boards_total
* border_left
* border_right
* border_top
* border_bottom
* board_spacing_x
* board_spacing_y
* fiducials_number
* fiducials_size
* fiducials_shape
* breakaway_method
* mouse_bites
* tooling_holes_number
* tooling_holes_size
* x_outs_allowed
* x_outs_max_percentage_on_array
* transplant_board_allowed
* weight

### mechanical [link](#mechanical)
* edge_bevelling
* depth_routing_top
* depth_routing_bottom
* counterboring_top
* counterboring_bottom
* countersink_top
* countersink_bottom
* punching
* plated_edges
* plated_slots
* plated_castellated_holes
* coin_attachment

### selective_plated_pads [link](#selective_plated_pads)
* present
* layers

### hard_gold_edge_connectors [link](#hard_gold_edge_connectors)
* present
* thickness
* thickness_other
* area
* layers

### markings [link](#markings)
* date_code
* placement
* manufacturer_identification
* standards
* serial_number
* serial_number_format
* serial_number_start
* serial_number_increase_by

### standards [link](#standards)
* ul
* c_ul
* rohs
* ul94
* esa
* itar
* dfars
* mil_prf_55110
* mil_prf_50884
* mil_prf_31032
* as9100
* nadcap
* rw_en45545_2_2013
* rw_nf_f_16_101
* rw_uni_cei_11170_3
* rw_nfpa_130
* ipc_6010_class
* ipc_6010_compliance_level
* ipc_6010_copper_plating_thickness_level
* ipc_6010_annular_ring_level
* ipc_6010_conductor_spacing_level
* ipc_6010_conductor_width_level
* ipc_6012_class
* ipc_6013_class
* ipc_6018

### testing [link](#testing)
* netlist
* allow_generate_netlist
* hipot
* 4_wire
* ist
* impedance

### country_of_origin [link](#country_of_origin)
* iso_3166_1_alpha_3
* iso_3166_1_alpha_2
* nato_member
* eu_member

### conflict_resolution [link](#conflict_resolution)
* order
* oem_specification_sheet
* assembly_specification_sheet
* drawing
* ipc2581
* odb
* gerber

### holes [link](#holes)
* number
* type
* plated
* size
* layer_start
* layer_stop
* depth
* method
* minimum_designed_annular_ring
* press_fit
* copper_filled
* staggered
* stacked
* alivh

### allowed_modifications [link](#allowed_modifications)
* dead_pad_removal
* add_copper_balancing
* add_copper_balancing_on_array
* add_tear_drops

### additional_requirements [link](#additional_requirements)
* any_name

### stackup
Aliases: stack-up, buildup, build-up

The stackup of the board: Free stackup (supplier to choose), specified in a separate file or specified in this file. Can also include the stackup itself.

#### specification_level
|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** |  |  |  |  | Array of s | Array of s |

#### file_name
|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** |  |  |  |  | Array of s | Array of s |

#### specified
|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** |  |  |  |  | Array of s | Array of s |

### rigid_conductive_layer

#### count
The number of conductive layers.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |
|**Min value:** | 1 | 1 | 1 | 1 | Each item: 1 | Each item: 1 |
|**Max value:** | 100 | 100 | 100 | 100 | Each item  : 100 | Each item: 100 |

#### minimum_internal_track_width
The minimum nominal width of conductors on internal/unplated layers (minimum track).

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### minimum_external_track_width
The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### minimum_internal_spacing_width
The minimum gap between two conductors on the internal layers.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### minimum_external_spacing_width
The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### external_base_copper_thickness
Finished base copper thickness following IPC Class on the up to two external layers.

Unit of Measure: um

Use one of these values:
* 5.1
* 8.5
* 12
* 17.1
* 25.7
* 34.3
* 68.6
* 102.9
* 137.2
* 171.5
* 205.7
* 240
* 342.9
* 480.1

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### internal_base_copper_thickness
Finished base copper thickness following IPC Class on the internal layers.

Unit of Measure: um

Use one of these values:
* 5.1
* 8.5
* 12
* 17.1
* 25.7
* 34.3
* 68.6
* 102.9
* 137.2
* 171.5
* 205.7
* 240
* 342.9
* 480.1

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### copper_foil_roughness
The roughness of the copper foil.

Use one of these values:
* S
* L
* V

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### copper_coverage_average
The average copper coverage of the board

Unit of Measure: %

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

### flexible_conductive_layer

#### count
The number of conductive layers.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |
|**Min value:** | 1 | 1 | 1 | 1 | Each item: 1 | Each item: 1 |
|**Max value:** | 100 | 100 | 100 | 100 | Each item  : 100 | Each item: 100 |

#### minimum_internal_track_width
The minimum nominal width of conductors on internal/unplated layers (minimum track).

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### minimum_external_track_width
The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### minimum_internal_spacing_width
The minimum gap between two conductors on the internal layers.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### minimum_external_spacing_width
The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### external_base_copper_thickness
Finished base copper thickness following IPC Class on the up to two external layers.

Unit of Measure: um

Use one of these values:
* 5.1
* 8.5
* 12
* 17.1
* 25.7
* 34.3
* 68.6
* 102.9
* 137.2
* 171.5
* 205.7
* 240
* 342.9
* 480.1

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### internal_base_copper_thickness
Finished base copper thickness following IPC Class on the internal layers.

Unit of Measure: um

Use one of these values:
* 5.1
* 8.5
* 12
* 17.1
* 25.7
* 34.3
* 68.6
* 102.9
* 137.2
* 171.5
* 205.7
* 240
* 342.9
* 480.1

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### copper_foil_roughness
The roughness of the copper foil.

Use one of these values:
* S
* L
* V

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### copper_coverage_average
The average copper coverage of the board

Unit of Measure: %

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

### final_finish

**You must specify this as en array when used in a generic product description or a stackup, but as a single object when used in any of the other parts.**

#### finish
The material/method/surface to be used in the finish.

Use one of these values:
* none
* c_bare_copper
* isn
* iag
* enig
* enepig
* osp
* ht_osp
* g
* GS
* t_fused
* tlu_unfused
* dig
* gwb-1_ultrasonic
* gwb-2-thermosonic
* s_hasl
* b1_lfhasl

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### area
The area that the finish will cover

Unit of Measure: dm2

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### thickness_min
The minimum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### thickness_max
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### gold_thickness_min
The minimum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### gold_thickness_max
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### silver_thickness_min
The minimum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### silver_thickness_max
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### paladium_thickness_min
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### paladium_thickness_max
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### tin_thickness_min
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### tin_thickness_max
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### nickel_thickness_min
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### nickel_thickness_max
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

### dielectric

**You must specify this as en array when used in a generic product description or a stackup, but as a single object when used in any of the other parts.**

#### name
The name of the Laminate. Use the official name or some name as close to it as possible.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

### soldermask

**You must specify this as en array when used in a generic product description or a stackup, but as a single object when used in any of the other parts.**

#### color
This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### finish
The finish of the soldermask.

Use one of these values:
* matte
* semi-matte
* glossy
* any

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### min_thickness
The minimum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### max_thickness
The maximum thickness.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### material
The name of a material that appears in the materials section

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability at bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### allow_touchups
The manufacturer is allowed to do touchups on the soldermask if true

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### legend
Aliases: silk screen, silkscreen, ink, ident

The legend to be used on the board

#### color
This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability at bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### stiffener
Aliases: support

Stiffener in flexible boards

#### size
The size of the stiffener should be specified in drawing

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### placement
Indicating if the stiffener is on top or bottom of the flexible layer.

Use one of these values:
* top
* bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### thickness
The thickness of the stiffener

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### material
The name of a material that appears in the materials section

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

### coverlay


#### total_thickness
The total thickness of the coverlay

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability at bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### material
The name of a material that appears in the materials -> soldermask section

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

### peelable_mask


#### heating_operations


|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability at bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### kapton_tape


#### accept_equivalent
If alternative to DuPont™ Kapton® HN general-purpose film can be used

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability at bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### conductive_carbon_print


#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### silver_print


#### top
Indicates presence/capability on top

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### bottom
Indicates presence/capability at bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### inner_packaging
This describes how boards are packed together to be shipped. Part of IPC 1601 (4.2.2)

#### type_of_bag
The material of the bag to be used

Use one of these values:
* a
* b
* c
* d

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### hic
True to include a Humidity Indicator Card (HIC), False to not

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### esd
True to indicate that packaging for ESD-sensitive required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### desiccant
True to indicate that a desiccant material is required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### vacuum
True to indicate that vacuum is needed for shrinkage - no heat rap or shrink rap allowed.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### via_protection
The via/hole protection according to IPC 4761

#### type_1
A via with a dry film mask material applied bridging over the via wherein no additional materials are in the hole.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_2
A Type I via with a secondary covering of mask material applied over the tented via.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_3
A via with material applied allowing partial penetration into the via. The plug material may be applied from one or both sides.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_4a
A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_4b
A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_5
A via with material applied into the via targeting a full penetration and encapsulation of the hole.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_6a
A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_6b
A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### type_7
A Type V via with a secondary metallized coating covering the via. The metallization is on both sides.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### board
The physical description of the board

#### size_x
The size of the board in the x-asis, measured in millimeters

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### size_y
The size of the board in the y-asis, measured in millimeters

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### thickness
The thickness of the board measured in millimeters

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

### array

#### size_x
The size of the array in the x-asis, measured in millimeters

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### size_y
The size of the array in the y-asis, measured in millimeters

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### boards_x
Number of boards in the panel in the x-direction.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### boards_y
Number of boards in the panel in the y-direction.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### boards_total
Number total number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### border_left
The size of the left side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### border_right
The size of the right side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### border_top
The size of the top side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### border_bottom
The size of the bottom side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### board_spacing_x
The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### board_spacing_y
The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### fiducials_number
The number of fiducials on the array.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### fiducials_size
The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### fiducials_shape
The shape of the fiducials.

Use one of these values:
* donut
* circle
* plus
* diamond

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### breakaway_method
The method of creation of the breakaways on the array

Use one of these values:
* routing
* scoring
* v-cut
* v-grove
* jump_scoring

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### mouse_bites
Indicates if there should be "mouse bites" to allow easy break away of the boards

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### tooling_holes_number
The number of tooling holes on the array.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### tooling_holes_size
The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size.

Unit of Measure: mm

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### x_outs_allowed
Manufacturer can deliver arrays with defect boards as long as these are clearly marked as defect (X'ed out).

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### x_outs_max_percentage_on_array
The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage

Unit of Measure: percentage

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### transplant_board_allowed
The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### weight
The weight of the array measured in grams.

Unit of Measure: g

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

### mechanical
Mechanical processes in the manufacturing

#### edge_bevelling
Edge bevelling present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### depth_routing_top
Depth Routing from the top present

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### depth_routing_bottom
Depth Routing from the bottom present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### counterboring_top
Counterboring from the top present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### counterboring_bottom
Counterboring from the bottom present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### countersink_top
Countersink from the top present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### countersink_bottom
Countersink from the bottom present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### punching
Punching process required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### plated_edges
Plated Edges process required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### plated_slots
Plated Slots process required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### plated_castellated_holes
Plated Castellated Holes process required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### coin_attachment
Coin Attachment process required.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### selective_plated_pads
Aliases: selective hard gold

Selective plated pads

#### present
Selective plated pads present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### layers
The layers included in the connectors, counter from 1 (top layer).

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

### hard_gold_edge_connectors
Aliases: gold fingers

Edge connectors made with hard gold

#### present
Hard gold edge connectors present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### thickness
The thickness of the connectors

Use one of these values:
* 0.76
* 1.27
* other

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### thickness_other
Thickness if it is not "0.76" or "1.27".

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### area
Area covered by the edge connectors in square desimeter.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### layers
The layers included in the connectors, counter from 1 (top layer).

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

### markings
Physical markings on the board

#### date_code
Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### placement
Placement of the markings.

Use one of these values:
* copper_top
* copper_bottom
* soldermask_top
* soldermask_bottom
* legend_top
* legend_bottom

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### manufacturer_identification
Manufacturer identification present.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### standards
Possible values are the ones listed in the subelement "standards" but typical will be "ul" and "rohs". Separate by comma.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | array | array | array | array | Array of arrays | Array of arrays |

#### serial_number
Serial number should be added in the markings.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### serial_number_format
Format of the serial number expressed as a "regular expression" but needs to have x amount of digits in it.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### serial_number_start
The number to start the serial number from. Will have to replace the digits from the "serial_number_format" above.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### serial_number_increase_by
The increase in number from "serial_number_start" with each product.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

### standards
If the format is boolean and nothing is stated other than the name of the standard in the Decription column, it should be understood as follows: Are to be met (if Specification), required (in Profile) or possible (in Capability)

#### ul
Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### c_ul
Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### rohs
RoHS.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### ul94
UL 94 - Standard for Safety of Flammability of Plastic Materials for Parts in Devices and Appliances testing

Use one of these values:
* hb
* v_0
* v_1
* v_2
* 5vb
* 5va

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### esa
European Space Agency Use.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### itar
US ITAR.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### dfars
US DFARS.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### mil_prf_55110
MIL-PRF-55110.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### mil_prf_50884
MIL-PRF-5884.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### mil_prf_31032
MIL-PRF-31032.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### as9100
AS9100.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### nadcap
NADCAP.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### rw_en45545_2_2013
Railway Europe EN45545-2:2013.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### rw_nf_f_16_101
Railway France NF F 16-101.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### rw_uni_cei_11170_3
Railway Italy UNI CEI 11170-3.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### rw_nfpa_130
Railway USA NFPA 130.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### ipc_6010_class
According to Table 4-2 /4-3.

Use one of these values:
* 1
* 2
* 3

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6010_compliance_level


Use one of these values:
* full
* factory_standard
* aabus

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6010_copper_plating_thickness_level
Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.

Use one of these values:
* 2
* 3

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6010_annular_ring_level
Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.

Use one of these values:
* 2
* 3

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6010_conductor_spacing_level
Used either if ipc_6010_class is set to 2 and you want to add conductor spacing demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.

Use one of these values:
* 2
* 3

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6010_conductor_width_level
Used either if ipc_6010_class is set to 2 and you want to add conductor width demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.

Use one of these values:
* 2
* 3

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6012_class
Requirements according to IPC 6012 class

Use one of these values:
* 1
* 2
* 3
* 3A
* 3S
* 3M

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6013_class
Requirements according to IPC 6013 for flexible or rigid-flex boards

Use one of these values:
* 1
* 2
* 3

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### ipc_6018
IPC-6018 Microwave End Product Board Inspection and Test

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### testing


#### netlist
100% Netlist testing according to IPC-D-356, ODB++ or IPC2581

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### allow_generate_netlist
Allow Netlist to be generated from Gerber or other file format if needed

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### hipot
HiPot Test (Dielectric Withstanding Voltage Test)

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### 4_wire
Use 4 wired test

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### ist
Use IST testing.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### impedance


Use one of these values:
* controlled
* calculated
* follow_stackup

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

### country_of_origin
Country of Origin is the country where the Printed Circuit Board is manufactured.

#### iso_3166_1_alpha_3
A three letter string representation of the Country of origin according too ISO 3166-1.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### iso_3166_1_alpha_2
A two letter string representation of the Country of origin according too ISO 3166-1.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### nato_member
Indicates if the COO is a NATO member state

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### eu_member
Indicates if the COO is a European Union member state.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### conflict_resolution
If several sources of data is present, this hierarchy is to set how to solve conflicts. Please specify a number to indicate priority and avoid setting the same number twice.

#### order
Information provided on order level

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### oem_specification_sheet
Information provided from the OEM in a PDF or other document format

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### assembly_specification_sheet
Information provided from the assembly facility in a PDF or other document format

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### drawing
Information in a drawing (if present)

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### ipc2581
Information in an IPC-2581 file

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### odb
 Information in a ODB++ file.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

#### gerber
Information in a Gerber format file

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | integer | integer | integer | integer | Array of integers | Array of integers |

### holes

**You must specify this as en array when used in a generic product description or a stackup, but as a single object when used in any of the other parts.**

#### number
The number of holes total or in this process.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### type
The type of holes.

Use one of these values:
* through
* blind
* buried
* back_drill

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### plated
True if the holes are plated.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### size
The size of the hole in micrometers. Can be considered the minimum hole size if only one holes element present in the list or as a capability.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### layer_start
The layer where the hole starts, counted from the top, where top layer is 1.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### layer_stop
The layer where the hole stops, counted from the top, where top layer is 1.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### depth
The depth of the hole in micrometer.

Unit of Measure: um

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### method
Can be either "routing" or "drilling", where drilling is default

Use one of these values:
* routing
* drilling
* laser

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

#### minimum_designed_annular_ring
The minimum designed annular ring in micrometers.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | number | number | number | number | Array of numbers | Array of numbers |

#### press_fit
Press Fit holes.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### copper_filled
Copper filled holes.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### staggered
Staggered holes.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### stacked
Stacked holes.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### alivh
ALIVH holes.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### allowed_modifications
Changes/fabrication decisions that are allowed to make to the files provided.

#### dead_pad_removal
Non Functioning Pad removal.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### add_copper_balancing
Adding copper balancing pattern

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### add_copper_balancing_on_array
Adding copper balancing pattern on array/panel frame.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

#### add_tear_drops
Adding Tear Drops.

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | boolean | boolean | boolean | boolean | Array of booleans | Array of booleans |

### additional_requirements
This section is for all requirements that still has not been adapted to the standard or needs to be stated as a comment. It allows you to specify custom elements that should be considered as part of the specification. You specify the value here and then need to create a separate element for it in the custom -> additional section. Multiple elements allowed - to be added as a list.

#### any_name
Must have a similar element in the custom -> additional

|  | Generic product | Stackup | Profile defaults | Profile enforced | Profile restricted | Capabilities |
|-:|:---------------:|:-------:|:----------------:|:----------------:|:------------------:|:------------:|
| **Use in:** | Allowed | Allowed | Allowed | Allowed | Allowed | Allowed | 
|**Format:** | string | string | string | string | Array of strings | Array of strings |

