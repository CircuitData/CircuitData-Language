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
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
#### file_name
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
#### specified
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
### rigid_conductive_layer
#### count
The number of conductive layers.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### minimum_internal_track_width
The minimum nominal width of conductors on internal/unplated layers (minimum track).
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### minimum_external_track_width
The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### minimum_internal_spacing_width
The minimum gap between two conductors on the internal layers.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### minimum_external_spacing_width
The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### external_base_copper_thickness
Finished base copper thickness following IPC Class on the up to two external layers in micrometer.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
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
#### internal_base_copper_thickness
Finished base copper thickness following IPC Class on the internal layers in micrometer.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
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
#### copper_foil_roughness
The roughness of the copper foil.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* S
* L
* V
#### copper_coverage_average
The average copper coverage of the board. UoM is percentage
Unit of Measure: %
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Number
### flexible_conductive_layer
#### count
The number of conductive layers.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### minimum_internal_track_width
The minimum nominal width of conductors on internal/unplated layers (minimum track).
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### minimum_external_track_width
The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### minimum_internal_spacing_width
The minimum gap between two conductors on the internal layers.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### minimum_external_spacing_width
The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### external_base_copper_thickness
Finished base copper thickness following IPC Class on the up to two external layers in micrometer.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
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
#### internal_base_copper_thickness
Finished base copper thickness following IPC Class on the internal layers in micrometer.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
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
#### copper_foil_roughness
The roughness of the copper foil.
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* S
* L
* V
#### copper_coverage_average
The average copper coverage of the board. UoM is percentage
Unit of Measure: %
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Number
### final_finish
### dielectric
### soldermask
### legend
Name: Legend
Aliases: silk screen, silkscreen, ink, ident
#### color
This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
#### top
Indicates legend presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### bottom
Indicates legend presence/capability at bottom
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### stiffener
Name: Stiffener
Aliases: support
#### size
The size of the stiffener should be specified in drawing
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### placement
Indicating if the stiffener is on top or bottom of the flexible layer.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* top
* bottom
#### thickness
The thickness of the stiffener
Unit of Measure: um
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Number
#### material
The name of a material that appears in the materials section
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
### coverlay
Name: CoverLay
#### total_thickness
The total thickness of the coverlay
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### top
Indicates coverlay presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### bottom
Indicates coverlay presence/capability at bottom
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### material
The name of a material that appears in the materials -> soldermask section
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
### peelable_mask
Name: Peelable mask
#### heating_operations

*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### top
Indicates peelable mask presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### bottom
Indicates peelable mask presence/capability at bottom
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### kapton_tape
Name: Kapton tape
#### accept_equivalent
If alternative to DuPont™ Kapton® HN general-purpose film can be used
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### top
Indicates kapton tape presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### bottom
Indicates kapton tape presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### conductive_carbon_print
Name: Conductive carbon print
#### top
Indicates Conductive Carbon Print presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### bottom
Indicates Conductive Carbon Print presence/capability at bottom
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### silver_print
Name: Silver print tape
#### top
Indicates silver print presence/capability at top
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### bottom
Indicates silver print presence/capability at bottom
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### inner_packaging
Name: Inner Packaging
#### type_of_bag
The material of the bag to be used
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* a
* b
* c
* d
#### hic
True to include a Humidity Indicator Card (HIC), False to not
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### esd
True to indicate that packaging for ESD-sensitive required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### desiccant
True to indicate that a desiccant material is required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### vacuum
True to indicate that vacuum is needed for shrinkage - no heat rap or shrink rap allowed.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### via_protection
Name: Via Protection
#### type_1
A via with a dry film mask material applied bridging over the via wherein no additional materials are in the hole.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_2
A Type I via with a secondary covering of mask material applied over the tented via.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_3
A via with material applied allowing partial penetration into the via. The plug material may be applied from one or both sides.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_4a
A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_4b
A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_5
A via with material applied into the via targeting a full penetration and encapsulation of the hole.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_6a
A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_6b
A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### type_7
A Type V via with a secondary metallized coating covering the via. The metallization is on both sides.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### board
Name: Board
#### size_x
The size of the board in the x-asis, measured in millimeters
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### size_y
The size of the board in the y-asis, measured in millimeters
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### thickness
The thickness of the board measured in millimeters
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
### array
#### size_x
The size of the array in the x-asis, measured in millimeters
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### size_y
The size of the array in the y-asis, measured in millimeters
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### boards_x
Number of boards in the panel in the x-direction.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### boards_y
Number of boards in the panel in the y-direction.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### boards_total
Number total number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used.
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### border_left
The size of the left side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### border_right
The size of the right side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### border_top
The size of the top side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### border_bottom
The size of the bottom side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### board_spacing_x
The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### board_spacing_y
The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### fiducials_number
The number of fiducials on the array.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### fiducials_size
The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### fiducials_shape
The shape of the fiducials.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* donut
* circle
* plus
* diamond
#### breakaway_method
The method of creation of the breakaways on the array
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* routing
* scoring
* v-cut
* v-grove
* jump_scoring
#### mouse_bites
Indicates if there should be "mouse bites" to allow easy break away of the boards
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### tooling_holes_number
The number of tooling holes on the array.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### tooling_holes_size
The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size.
Unit of Measure: mm
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Number
#### x_outs_allowed
Manufacturer can deliver arrays with defect boards as long as these are clearly marked as defect (X'ed out).
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### x_outs_max_percentage_on_array
The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage
Unit of Measure: percentage
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### transplant_board_allowed
The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### weight
The weight of the array measured in grams.
Unit of Measure: g
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Number
### mechanical
Name: Mechanical processes
#### edge_bevelling
Edge bevelling present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### depth_routing_top
Depth Routing from the top present
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### depth_routing_bottom
Depth Routing from the bottom present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### counterboring_top
Counterboring from the top present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### counterboring_bottom
Counterboring from the bottom present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### countersink_top
Countersink from the top present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### countersink_bottom
Countersink from the bottom present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### punching
Punching process required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### plated_edges
Plated Edges process required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### plated_slots
Plated Slots process required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### plated_castellated_holes
Plated Castellated Holes process required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### coin_attachment
Coin Attachment process required.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### selective_plated_pads
Name: Selective plated pads
Aliases: selective hard gold
#### present
Selective plated pads present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### layers
The layers included in the connectors, counter from 1 (top layer).
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: String
### hard_gold_edge_connectors
Name: Hard Gold Edge Connectors
Aliases: gold fingers
#### present
Hard gold edge connectors present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### thickness
The thickness of the connectors
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 0.76
* 1.27
* other
#### thickness_other
Thickness if it is not "0.76" or "1.27".
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Number
#### area
Area covered by the edge connectors in square desimeter.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Number
#### layers
The layers included in the connectors, counter from 1 (top layer).
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: String
### markings
Name: Markings
#### date_code
Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: String
#### placement
Placement of the markings.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* copper_top
* copper_bottom
* soldermask_top
* soldermask_bottom
* legend_top
* legend_bottom
#### manufacturer_identification
Manufacturer identification present.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### standards
Possible values are the ones listed in the subelement "standards" but typical will be "ul" and "rohs". Separate by comma.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### serial_number
Serial number should be added in the markings.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### serial_number_format
Format of the serial number expressed as a "regular expression" but needs to have x amount of digits in it.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: String
#### serial_number_start
The number to start the serial number from. Will have to replace the digits from the "serial_number_format" above.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### serial_number_increase_by
The increase in number from "serial_number_start" with each product.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
### standards
Name: Standards and Requirements
#### ul
Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### c_ul
Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### rohs
RoHS.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### ul94
UL 94 - Standard for Safety of Flammability of Plastic Materials for Parts in Devices and Appliances testing
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* hb
* v_0
* v_1
* v_2
* 5vb
* 5va
#### esa
European Space Agency Use.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### itar
US ITAR.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### dfars
US DFARS.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### mil_prf_55110
MIL-PRF-55110.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### mil_prf_50884
MIL-PRF-5884.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### mil_prf_31032
MIL-PRF-31032.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### as9100
AS9100.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### nadcap
NADCAP.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### rw_en45545_2_2013
Railway Europe EN45545-2:2013.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### rw_nf_f_16_101
Railway France NF F 16-101.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### rw_uni_cei_11170_3
Railway Italy UNI CEI 11170-3.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### rw_nfpa_130
Railway USA NFPA 130.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### ipc_6010_class
According to Table 4-2 /4-3.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 1
* 2
* 3
#### ipc_6010_compliance_level

*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* full
* factory_standard
* aabus
#### ipc_6010_copper_plating_thickness_level
Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 2
* 3
#### ipc_6010_annular_ring_level
Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 2
* 3
#### ipc_6010_conductor_spacing_level
Used either if ipc_6010_class is set to 2 and you want to add conductor spacing demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 2
* 3
#### ipc_6010_conductor_width_level
Used either if ipc_6010_class is set to 2 and you want to add conductor width demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 2
* 3
#### ipc_6012_class
Requirements according to IPC 6012 class.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 1
* 2
* 3
* 3A
* 3S
* 3M
#### ipc_6013_class
Requirements according to IPC 6013 for flexible or rigid-flex boards.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* 1
* 2
* 3
#### ipc_6018
IPC-6018 Microwave End Product Board Inspection and Test.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### testing
Name: Testing
#### netlist
100% Netlist testing according to IPC-D-356, ODB++ or IPC2581.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### allow_generate_netlist
Allow Netlist to be generated from Gerber or other file format if needed.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### hipot
 HiPot Test (Dielectric Withstanding Voltage Test).
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### 4_wire
Use 4 wired test
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### ist
Use IST testing.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### impedance

*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
Use one of these values:
* controlled
* calculated
* follow_stackup
### country_of_origin
Name: Country of Origin
#### iso_3166_1_alpha_3
A three letter string representation of the Country of origin according too ISO 3166-1.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
#### iso_3166_1_alpha_2
A two letter string representation of the Country of origin according too ISO 3166-1.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
Type: String
#### nato_member
Indicates if the COO is a NATO member state
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### eu_member
Indicates if the COO is a European Union member state.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### conflict_resolution
Name: Conflict resolution
#### order
Information provided on order level
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### oem_specification_sheet
Information provided from the OEM in a PDF or other document format
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### assembly_specification_sheet
Information provided from the assembly facility in a PDF or other document format
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### drawing
Information in a drawing (if present)
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### ipc2581
Information in an IPC-2581 file
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### odb
 Information in a ODB++ file.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
#### gerber
Information in a Gerber format file
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
Type: Integer
### holes
### allowed_modifications
Name: Allowed Modifications
#### dead_pad_removal
Non Functioning Pad removal.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### add_copper_balancing
Adding copper balancing pattern
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### add_copper_balancing_on_array
Adding copper balancing pattern on array/panel frame.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
#### add_tear_drops
Adding Tear Drops.
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Allowed*
*Use in profile enforced section: Allowed*
*Use in profile restricted section: Allowed*
*Use in capabilities section: Disallowed*
### additional_requirements
Name: Additional Requirements
#### any_name
Must have a similar element in the custom -> additional
*Use in generic product section: Allowed*
*Use in stackup product section: Disallowed*
*Use in profile defaults section: Disallowed*
*Use in profile enforced section: Disallowed*
*Use in profile restricted section: Disallowed*
*Use in capabilities section: Disallowed*
