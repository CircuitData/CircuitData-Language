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
## Elements and tags
[stackup](#stackup)
* specification_level
* file_name
* specified

[rigid_conductive_layer](#rigid_conductive_layer)
* count
* minimum_internal_track_width
* minimum_external_track_width
* minimum_internal_spacing_width
* minimum_external_spacing_width
* external_base_copper_thickness
* internal_base_copper_thickness
* copper_foil_roughness
* copper_coverage_average

[flexible_conductive_layer](#flexible_conductive_layer)
* count
* minimum_internal_track_width
* minimum_external_track_width
* minimum_internal_spacing_width
* minimum_external_spacing_width
* external_base_copper_thickness
* internal_base_copper_thickness
* copper_foil_roughness
* copper_coverage_average

[final_finish](#final_finish)

[dielectric](#dielectric)

[soldermask](#soldermask)

[legend](#legend)
* color
* top
* bottom

[stiffener](#stiffener)
* size
* placement
* thickness
* material

[coverlay](#coverlay)
* total_thickness
* top
* bottom
* material

[peelable_mask](#peelable_mask)
* heating_operations
* top
* bottom

[kapton_tape](#kapton_tape)
* accept_equivalent
* top
* bottom

[conductive_carbon_print](#conductive_carbon_print)
* top
* bottom

[silver_print](#silver_print)
* top
* bottom

[inner_packaging](#inner_packaging)
* type_of_bag
* hic
* esd
* desiccant
* vacuum

[via_protection](#via_protection)
* type_1
* type_2
* type_3
* type_4a
* type_4b
* type_5
* type_6a
* type_6b
* type_7

[board](#board)
* size_x
* size_y
* thickness

[array](#array)
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

[mechanical](#mechanical)
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

[selective_plated_pads](#selective_plated_pads)
* present
* layers

[hard_gold_edge_connectors](#hard_gold_edge_connectors)
* present
* thickness
* thickness_other
* area
* layers

[markings](#markings)
* date_code
* placement
* manufacturer_identification
* standards
* serial_number
* serial_number_format
* serial_number_start
* serial_number_increase_by

[standards](#standards)
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

[testing](#testing)
* netlist
* allow_generate_netlist
* hipot
* 4_wire
* ist
* impedance

[country_of_origin](#country_of_origin)
* iso_3166_1_alpha_3
* iso_3166_1_alpha_2
* nato_member
* eu_member

[conflict_resolution](#conflict_resolution)
* order
* oem_specification_sheet
* assembly_specification_sheet
* drawing
* ipc2581
* odb
* gerber

[holes](#holes)

[allowed_modifications](#allowed_modifications)
* dead_pad_removal
* add_copper_balancing
* add_copper_balancing_on_array
* add_tear_drops

[additional_requirements](#additional_requirements)
* any_name

### stackup
Name: Stackup
Aliases: stack-up, buildup, build-up

#### specification_level
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### file_name
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### specified
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

### rigid_conductive_layer

#### count
The number of conductive layers.
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_internal_track_width
The minimum nominal width of conductors on internal/unplated layers (minimum track).
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_external_track_width
The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_internal_spacing_width
The minimum gap between two conductors on the internal layers.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_external_spacing_width
The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### external_base_copper_thickness
Finished base copper thickness following IPC Class on the up to two external layers.
Unit of Measure: um
Type: Number
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
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### internal_base_copper_thickness
Finished base copper thickness following IPC Class on the internal layers.
Unit of Measure: um
Type: Number
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
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### copper_foil_roughness
The roughness of the copper foil.
Type: String
Use one of these values:
* S
* L
* V
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### copper_coverage_average
The average copper coverage of the board
Unit of Measure: %
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

### flexible_conductive_layer

#### count
The number of conductive layers.
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

#### minimum_internal_track_width
The minimum nominal width of conductors on internal/unplated layers (minimum track).
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_external_track_width
The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_internal_spacing_width
The minimum gap between two conductors on the internal layers.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### minimum_external_spacing_width
The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### external_base_copper_thickness
Finished base copper thickness following IPC Class on the up to two external layers.
Unit of Measure: um
Type: Number
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
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### internal_base_copper_thickness
Finished base copper thickness following IPC Class on the internal layers.
Unit of Measure: um
Type: Number
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
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### copper_foil_roughness
The roughness of the copper foil.
Type: String
Use one of these values:
* S
* L
* V
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### copper_coverage_average
The average copper coverage of the board
Unit of Measure: %
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

### final_finish

### dielectric

### soldermask

### legend
Name: Legend
Aliases: silk screen, silkscreen, ink, ident

#### color
This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### top
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### bottom
Indicates presence/capability at bottom
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### stiffener
Name: Stiffener
Aliases: support

#### size
The size of the stiffener should be specified in drawing
Unit of Measure: um
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### placement
Indicating if the stiffener is on top or bottom of the flexible layer.
Type: String
Use one of these values:
* top
* bottom
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### thickness
The thickness of the stiffener
Unit of Measure: um
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

#### material
The name of a material that appears in the materials section
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### coverlay
Name: CoverLay

#### total_thickness
The total thickness of the coverlay
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### top
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### bottom
Indicates presence/capability at bottom
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### material
The name of a material that appears in the materials -> soldermask section
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### peelable_mask
Name: Peelable mask

#### heating_operations

Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### top
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### bottom
Indicates presence/capability at bottom
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### kapton_tape
Name: Kapton tape

#### accept_equivalent
If alternative to DuPont™ Kapton® HN general-purpose film can be used
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### top
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### bottom
Indicates presence/capability at bottom
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### conductive_carbon_print
Name: Conductive carbon print

#### top
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### bottom
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### silver_print
Name: Silver print tape

#### top
Indicates presence/capability on top
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### bottom
Indicates presence/capability at bottom
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### inner_packaging
Name: Inner Packaging

#### type_of_bag
The material of the bag to be used
Type: String
Use one of these values:
* a
* b
* c
* d
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### hic
True to include a Humidity Indicator Card (HIC), False to not
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### esd
True to indicate that packaging for ESD-sensitive required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### desiccant
True to indicate that a desiccant material is required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### vacuum
True to indicate that vacuum is needed for shrinkage - no heat rap or shrink rap allowed.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### via_protection
Name: Via Protection

#### type_1
A via with a dry film mask material applied bridging over the via wherein no additional materials are in the hole.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_2
A Type I via with a secondary covering of mask material applied over the tented via.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_3
A via with material applied allowing partial penetration into the via. The plug material may be applied from one or both sides.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_4a
A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_4b
A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_5
A via with material applied into the via targeting a full penetration and encapsulation of the hole.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_6a
A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_6b
A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### type_7
A Type V via with a secondary metallized coating covering the via. The metallization is on both sides.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### board
Name: Board

#### size_x
The size of the board in the x-asis, measured in millimeters
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### size_y
The size of the board in the y-asis, measured in millimeters
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### thickness
The thickness of the board measured in millimeters
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### array

#### size_x
The size of the array in the x-asis, measured in millimeters
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### size_y
The size of the array in the y-asis, measured in millimeters
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### boards_x
Number of boards in the panel in the x-direction.
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### boards_y
Number of boards in the panel in the y-direction.
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### boards_total
Number total number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### border_left
The size of the left side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### border_right
The size of the right side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### border_top
The size of the top side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### border_bottom
The size of the bottom side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### board_spacing_x
The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### board_spacing_y
The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### fiducials_number
The number of fiducials on the array.
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### fiducials_size
The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### fiducials_shape
The shape of the fiducials.
Type: String
Use one of these values:
* donut
* circle
* plus
* diamond
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### breakaway_method
The method of creation of the breakaways on the array
Type: String
Use one of these values:
* routing
* scoring
* v-cut
* v-grove
* jump_scoring
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### mouse_bites
Indicates if there should be "mouse bites" to allow easy break away of the boards
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### tooling_holes_number
The number of tooling holes on the array.
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### tooling_holes_size
The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size.
Unit of Measure: mm
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### x_outs_allowed
Manufacturer can deliver arrays with defect boards as long as these are clearly marked as defect (X'ed out).
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### x_outs_max_percentage_on_array
The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage
Unit of Measure: percentage
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### transplant_board_allowed
The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### weight
The weight of the array measured in grams.
Unit of Measure: g
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

### mechanical
Name: Mechanical processes

#### edge_bevelling
Edge bevelling present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### depth_routing_top
Depth Routing from the top present
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### depth_routing_bottom
Depth Routing from the bottom present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### counterboring_top
Counterboring from the top present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### counterboring_bottom
Counterboring from the bottom present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### countersink_top
Countersink from the top present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### countersink_bottom
Countersink from the bottom present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### punching
Punching process required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### plated_edges
Plated Edges process required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### plated_slots
Plated Slots process required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### plated_castellated_holes
Plated Castellated Holes process required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### coin_attachment
Coin Attachment process required.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### selective_plated_pads
Name: Selective plated pads
Aliases: selective hard gold

#### present
Selective plated pads present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### layers
The layers included in the connectors, counter from 1 (top layer).
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

### hard_gold_edge_connectors
Name: Hard Gold Edge Connectors
Aliases: gold fingers

#### present
Hard gold edge connectors present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### thickness
The thickness of the connectors
Type: String
Use one of these values:
* 0.76
* 1.27
* other
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### thickness_other
Thickness if it is not "0.76" or "1.27".
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

#### area
Area covered by the edge connectors in square desimeter.
Type: Number
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

#### layers
The layers included in the connectors, counter from 1 (top layer).
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

### markings
Name: Markings

#### date_code
Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

#### placement
Placement of the markings.
Type: String
Use one of these values:
* copper_top
* copper_bottom
* soldermask_top
* soldermask_bottom
* legend_top
* legend_bottom
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### manufacturer_identification
Manufacturer identification present.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### standards
Possible values are the ones listed in the subelement "standards" but typical will be "ul" and "rohs". Separate by comma.
Type: Array of unknown type
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### serial_number
Serial number should be added in the markings.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### serial_number_format
Format of the serial number expressed as a "regular expression" but needs to have x amount of digits in it.
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### serial_number_start
The number to start the serial number from. Will have to replace the digits from the "serial_number_format" above.
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### serial_number_increase_by
The increase in number from "serial_number_start" with each product.
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

### standards
Name: Standards and Requirements

#### ul
Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### c_ul
Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### rohs
RoHS.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ul94
UL 94 - Standard for Safety of Flammability of Plastic Materials for Parts in Devices and Appliances testing
Type: String
Use one of these values:
* hb
* v_0
* v_1
* v_2
* 5vb
* 5va
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### esa
European Space Agency Use.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### itar
US ITAR.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### dfars
US DFARS.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### mil_prf_55110
MIL-PRF-55110.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### mil_prf_50884
MIL-PRF-5884.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### mil_prf_31032
MIL-PRF-31032.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### as9100
AS9100.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### nadcap
NADCAP.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### rw_en45545_2_2013
Railway Europe EN45545-2:2013.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### rw_nf_f_16_101
Railway France NF F 16-101.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### rw_uni_cei_11170_3
Railway Italy UNI CEI 11170-3.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### rw_nfpa_130
Railway USA NFPA 130.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6010_class
According to Table 4-2 /4-3.
Type: String
Use one of these values:
* 1
* 2
* 3
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6010_compliance_level

Type: String
Use one of these values:
* full
* factory_standard
* aabus
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6010_copper_plating_thickness_level
Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
Type: String
Use one of these values:
* 2
* 3
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6010_annular_ring_level
Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
Type: String
Use one of these values:
* 2
* 3
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6010_conductor_spacing_level
Used either if ipc_6010_class is set to 2 and you want to add conductor spacing demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
Type: String
Use one of these values:
* 2
* 3
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6010_conductor_width_level
Used either if ipc_6010_class is set to 2 and you want to add conductor width demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
Type: String
Use one of these values:
* 2
* 3
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6012_class
Requirements according to IPC 6012 class
Type: String
Use one of these values:
* 1
* 2
* 3
* 3A
* 3S
* 3M
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6013_class
Requirements according to IPC 6013 for flexible or rigid-flex boards
Type: String
Use one of these values:
* 1
* 2
* 3
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ipc_6018
IPC-6018 Microwave End Product Board Inspection and Test
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### testing
Name: Testing

#### netlist
100% Netlist testing according to IPC-D-356, ODB++ or IPC2581
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### allow_generate_netlist
Allow Netlist to be generated from Gerber or other file format if needed
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### hipot
HiPot Test (Dielectric Withstanding Voltage Test)
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### 4_wire
Use 4 wired test
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### ist
Use IST testing.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### impedance

Type: String
Use one of these values:
* controlled
* calculated
* follow_stackup
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### country_of_origin
Name: Country of Origin

#### iso_3166_1_alpha_3
A three letter string representation of the Country of origin according too ISO 3166-1.
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### iso_3166_1_alpha_2
A two letter string representation of the Country of origin according too ISO 3166-1.
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### nato_member
Indicates if the COO is a NATO member state
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

#### eu_member
Indicates if the COO is a European Union member state.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilites section: Allowed*

### conflict_resolution
Name: Conflict resolution

#### order
Information provided on order level
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### oem_specification_sheet
Information provided from the OEM in a PDF or other document format
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### assembly_specification_sheet
Information provided from the assembly facility in a PDF or other document format
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### drawing
Information in a drawing (if present)
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### ipc2581
Information in an IPC-2581 file
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### odb
 Information in a ODB++ file.
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

#### gerber
Information in a Gerber format file
Type: Integer
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Disallowed*
* *Capabilities section: Disallowed*

### holes

### allowed_modifications
Name: Allowed Modifications

#### dead_pad_removal
Non Functioning Pad removal.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### add_copper_balancing
Adding copper balancing pattern
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### add_copper_balancing_on_array
Adding copper balancing pattern on array/panel frame.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

#### add_tear_drops
Adding Tear Drops.
Type: Boolean
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Allowed*
* *Profile enforced section: Allowed*
* *Profile restricted section: Allowed*
* *Capabilities section: Disallowed*

### additional_requirements
Name: Additional Requirements

#### any_name
Must have a similar element in the custom -> additional
Type: String
Use in:
* *Generic product section: Allowed*
* *Gtackup product section: Disallowed*
* *Profile defaults section: Disallowed*
* *Profile enforced section: Disallowed*
* *Profile restricted section: Disallowed*
* *Capabilites section: Allowed*

