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
Current version is 0.6. This should stated in every section directly below the "printed_circuits_fabrication_data" element in an element called "version".

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
JSON schema is available in at its [own site (schema.circuitdata.org)](http://schema.circuitdata.org) in version folders. To link to it, please use the raw link. The schema allows you to validate your OTTP file syntax. An example of how this is done in Ruby with the [json-schema GEM](https://github.com/ruby-json-schema/json-schema) below:

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
The name of the element as it is to be used in the file is included behind the title within the parenthesis, e.g. "soldermask". When a table of possible elements is present, you will find the following headers:

- "Data tag": The name of the elements
- "Format": The format of the element (possible formats listed in the Open Trade Data Package format specification )
- "P": When used in a Products part of the file (to give a specification) (see above for structure and abbreviations)
- "PD": When used in a Profiles->Defaults part of the file (see above for structure and abbreviations)
- "PE": When used in a Profiles->Enforced part of the file (see above for structure and abbreviations)
- "PR": When used in a Profiles->Restricted part of the file (see above for structure and abbreviations)
- "C": When used in a Capabilities part of the file (see above for structure and abbreviations)

If the element have alternative names in everyday use, this is referenced as an "Alias" and stated just below the title.

### Stackup ("stackup")
Aliases: "stack-up", "buildup", "build-up"
The stackup of the board: Free stackup (supplier to choose), specified in a separate file or specified in this file. Can also include the stackup itself.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*specification_level* | list | O | F | F | F | O | The stack up of this board<br>Possible values are (string):<br>"free" (The manufacturer can choose the stackup that matches the rest of the requirements)<br>"separate_file" (A file is supplied with the package that will contain the actual stackup.)<br>"specified" (The actual stackup is under the stackup->specified tag)<br>
*file_name* | string | O | O | O | F | O | The URI of the file that specifies the stackup. Either as a path witin a project compressed file (ZIP) or as a link
*specified* | object | O | F | F | F | O | The container where the elements describing the stackup should be placed. All elements under object must contain the "layer_order" tags to set the order of the layer. They should also contain the "layer_name" tag to set the descriptive name of the layer

### Rigid Conductive layer ("rigid_conductive_layer")
The layers of rigid conductive material (usually copper)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*count* | integer | O | F | F | F | O | The number of conductive layers.
*minimum_internal_track_width* | float | O | F | F | O | O | The minimum nominal width of conductors on internal/unplated layers (minimum track).
*minimum_external_track_width* | float | O | F | F | O | O | The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
*minimum_internal_spacing_width* | float | O | F | F | O | O | The minimum gap between two conductors on the internal layers.
*minimum_external_spacing_width* | float | O | F | F | O | O | The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
*external_base_copper_thickness* | list | O | F | F | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer.<br>Possible values are (float):<br>"5.1"<br>"8.5"<br>"12"<br>"17.1"<br>"25.7"<br>"34.3"<br>"68.6"<br>"102.9"<br>"137.2"<br>"171.5"<br>"205.7"<br>"240"<br>"342.9"<br>"480.1"<br>
*internal_base_copper_thickness* | list | O | F | F | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer.<br>Possible values are (float):<br>"5.1"<br>"8.5"<br>"12"<br>"17.1"<br>"25.7"<br>"34.3"<br>"68.6"<br>"102.9"<br>"137.2"<br>"171.5"<br>"205.7"<br>"240"<br>"342.9"<br>"480.1"<br>
*copper_foil_roughness* | list | O | O | O | O | O | The roughness of the copper foil.<br>Possible values are (string):<br>"S" (Standard profile)<br>"L" (Low profile)<br>"V" (Very low profile)<br>
*copper_coverage_average* | float | O | F | F | F | O | The average copper coverage of the board. UoM is percentage

### Flexible Conductive layer ("flexible_conductive_layer")
The layers of flexible conductive material (usually copper)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*count* | integer | O | F | F | F | O | The number of conductive layers.
*minimum_internal_track_width* | float | O | F | F | O | O | The minimum nominal width of conductors on internal/unplated layers (minimum track).
*minimum_external_track_width* | float | O | F | F | O | O | The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
*minimum_internal_spacing_width* | float | O | F | F | O | O | The minimum gap between two conductors on the internal layers.
*minimum_external_spacing_width* | float | O | F | F | O | O | The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
*external_base_copper_thickness* | list | O | F | F | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer.<br>Possible values are (float):<br>"5.1"<br>"8.5"<br>"12"<br>"17.1"<br>"25.7"<br>"34.3"<br>"68.6"<br>"102.9"<br>"137.2"<br>"171.5"<br>"205.7"<br>"240"<br>"342.9"<br>"480.1"<br>
*internal_base_copper_thickness* | list | O | F | F | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer.<br>Possible values are (float):<br>"5.1"<br>"8.5"<br>"12"<br>"17.1"<br>"25.7"<br>"34.3"<br>"68.6"<br>"102.9"<br>"137.2"<br>"171.5"<br>"205.7"<br>"240"<br>"342.9"<br>"480.1"<br>
*copper_foil_roughness* | list | O | O | O | O | O | The roughness of the copper foil.<br>Possible values are (string):<br>"S" (Standard profile)<br>"L" (Low profile)<br>"V" (Very low profile)<br>
*copper_foil_type* | list | O | O | O | O | O | The The type of the copper foil<br>Possible values are (string):<br>"ED" (Electro Deposited)<br>"RA" (Rolled Annealed Copper)<br>"ED" (Default)<br>
*copper_coverage_average* | float | O | F | F | F | O | The average copper coverage of the board. UoM is percentage

### Final Finish ("final_finish")
Aliases: "Surfacefinish", "Surface finish", "Coating", "finalfinish", "Solderable finish", "Solderable coating"
A list of final finishes, can be more than one. E.g. selective finish ENIG and OSP.
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*finish* | list | O | O | O | O | O | The material/method/surface to be used in the finish.<br>Possible values are (string):<br>"c_bare_copper" (AABUS)<br>"isn" (IPC-4554 Immersion Tin)<br>"iag" (IPC-4553 Immersion Silver)<br>"enig" (IPC-4552 Immersion Gold)<br>"enepig" (IPC-4556 ENEPIG)<br>"osp" (J-STD-003 Organic Solderability Preservative)<br>"ht_osp" (J-STD-003 High Temperature OSP)<br>"g" (ASTM-B-488 Gold for edge printed board connectors and areas not to be soldered)<br>"GS" (J-STD-003 Gold Electroplate on areas to be soldered)<br>"t_fused" (J-STD-003 Electrodeposited Tin-Lead (fused))<br>"tlu_unfused" (J-STD-003 Electrodeposited Tin-Lead Unfused)<br>"dig" (J-STD-003 Direct Immersion Gold (Solderable Surface))<br>"gwb-1_ultrasonic" (ASTM-B-488 Gold Electroplate for areas to be wire bonded (ultrasonic))<br>"gwb-2-thermosonic" (ASTM-B-488 Gold Electroplate for areas to be wire bonded (thermosonic))<br>"s_hasl" (J-STD-003_J-STD-006 Solder Coating over Bare Copper (HASL))<br>"b1_lfhasl" (J-STD-003_J-STD-006 Lead-Free Solder Coating over Bare Copper (Lead-Free HASL, Lead free HASL))<br>"none" (No final finish should be used)<br>
*area* | float | O | F | F | F | O | The area that the finish will cover, in square decimeter.
*thickness_min* | float | O | O | O | F | O | The minimum thickness of the finish in micrometer.
*thickness_max* | float | O | O | O | F | O | The maximum thickness of the finish in micrometer.
*gold_thickness_min* | float | O | O | O | F | O | The minimum thickness of the gold finish in micrometer.
*gold_thickness_max* | float | O | O | O | F | O | The maximim thickness of the gold finish in micrometer.
*silver_thickness_min* | float | O | O | O | F | O | The minimum thickness of silver the finish in micrometer.
*silver_thickness_max* | float | O | O | O | F | O | The maximum thickness of silver the finish in micrometer.
*paladium_thickness_min* | float | O | O | O | F | O | The minimum thickness of the paladium finish in micrometer.
*paladium_thickness_max* | float | O | O | O | F | O | The maximim thickness of the paladium finish in micrometer.
*tin_thickness_min* | float | O | O | O | F | O | The minimum thickness of the tin finish in micrometer.
*tin_thickness_max* | float | O | O | O | F | O | The maximum thickness of the tin finish in micrometer.
*nickel_thickness_min* | float | O | O | O | F | O | The minimum thickness of the nickel finish in micrometer.
*nickel_thickness_max* | float | O | O | O | F | O | The maximum thickness of the nickel finish in micrometer.

### Dielectric ("dielectric")
Aliases: "Laminate"
A list of one of more materials used as dielectric. Every material listed here must have be listed in the materials section with the name of the material as the key.
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | string | O | O | O | O | O | The name of a material that appears in the materials section

### Soldermask ("soldermask")
Aliases: "solder mask", "sm", "solder resist", "green mask"
A list of final soldermasks, can be more than one
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*color* | string | O | O | O | O | O | This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.
*finish* | list | O | O | O | O | O | The finish of the soldermask.<br>Possible values are (string):<br>"matte" (Finish)<br>"semi-matte" (Finish)<br>"glossy" (Finish)<br>"any" (Finish)<br>
*min_thickness* | float | O | O | O | F | O | The minimum thickness of the soldermask.
*max_thickness* | float | O | O | O | F | O | The maximum thickness of the soldermask.
*material* | string | O | O | O | O | O | The name of a material that appears in the materials section
*top* | boolean | O | O | O | O | O | Indicates soldermask presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates soldermask presence/capability at bottom
*allow_touchups* | boolean | O | O | O | O | O | The manufacturer is allowed to do touchups on the soldermask if true

### Legend ("legend")
Aliases: "silk screen", "silkscreen", "ink", "ident"
The legend to be used on the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*color* | string | O | O | O | O | O | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.
*top* | boolean | O | O | O | O | O | Indicates legend presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates legend presence/capability at bottom

### Stiffener ("stiffener")
Aliases: "support"
Stiffener in flexible boards

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size* | float | O | O | O | O | O | The size of the stiffener should be specified in drawing
*placement* | list | O | O | O | O | O | Indicating if the stiffener is on top or bottom of the flexible layer.<br>Possible values are (string):<br>"top" (The stiffener is on top of the flexible layer(s))<br>"bottom" (The stiffener is below the flexible layer(s))<br>
*thickness* | float | O | O | O | F | O | The thickness of the stiffener
*material* | string | O | O | O | O | O | The name of a material that appears in the materials section

### CoverLay ("coverlay")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*total_thickness* | float | O | O | O | O | O | The total thickness of the coverlay
*top* | boolean | O | O | O | O | O | Indicates coverlay presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates coverlay presence/capability at bottom
*material* | string | O | O | O | O | O | The name of a material that appears in the materials -> soldermask section

### Peelable mask ("peelable_mask")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*heating_operations* | integer | O | O | O | O | O |
*top* | boolean | O | O | O | O | O | Indicates peelable mask presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates peelable mask presence/capability at bottom

### Kapton tape ("kapton_tape")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*accept_equivalent* | boolean | O | O | O | O | O | If alternative to DuPont™ Kapton® HN general-purpose film can be used
*top* | boolean | O | O | O | O | O | Indicates peelable mask presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates peelable mask presence/capability at bottom

### Conductive Carbon Print ("conductive_carbon_print")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | boolean | O | O | O | O | O | Indicates Conductive Carbon Print presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates Conductive Carbon Print presence/capability at bottom

### Silver Print ("silver_print")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | boolean | O | O | O | O | O | Indicates silver print presence/capability at top
*bottom* | boolean | O | O | O | O | O | Indicates silver print presence/capability at bottom

### Inner Packaging ("inner_packaging")
This describes how boards are packed together to be shipped. Part of IPC 1601 (4.2.2)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type_of_bag* | list | O | O | O | O | O | The material of the bag to be used<br>Possible values are (string):<br>"a" (Nylon/Foil/Polyethylene)<br>"b" (TyvekTM/Foil/Polyethylene)<br>"c" (Aluminized Polyester/Polyethylene)<br>"d" (Plastics/Polymers (non-metallic))<br>
*hic* | boolean | O | O | O | O | O | True to include a Humidity Indicator Card (HIC), False to not
*esd* | boolean | O | O | O | O | O | True to indicate that packaging for ESD-sensitive required.
*desiccant* | boolean | O | O | O | O | O | True to indicate that a desiccant material is required.
*vacuum* | boolean | O | O | O | O | O | True to indicate that vacuum is needed for shrinkage - no heat rap or shrink rap allowed.

### Via Protection ("via_protection")
The via/hole protection according to IPC 4761

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type_1* | boolean | O | O | O | O | O | A via with a dry film mask material applied bridging over the via wherein no additional materials are in the hole.
*type_2* | boolean | O | O | O | O | O | A Type I via with a secondary covering of mask material applied over the tented via.
*type_3* | boolean | O | O | O | O | O | A via with material applied allowing partial penetration into the via. The plug material may be applied from one or both sides.
*type_4a* | boolean | O | O | O | O | O | A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*type_4b* | boolean | O | O | O | O | O | A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*type_5* | boolean | O | O | O | O | O | A via with material applied into the via targeting a full penetration and encapsulation of the hole.
*type_6a* | boolean | O | O | O | O | O | A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*type_6b* | boolean | O | O | O | O | O | A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*type_7* | boolean | O | O | O | O | O | A Type V via with a secondary metallized coating covering the via. The metallization is on both sides.

### Board ("board")
The physical description of the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size_x* | float | O | F | F | O | O | The size of the board in the x-asis, measured in millimeters
*size_y* | float | O | F | F | O | O | The size of the board in the y-asis, measured in millimeters
*thickness* | float | O | O | O | O | O | The thickness of the board measured in millimeters
*weight* | float | O | F | F | F | O | The weight of the board measured in grams

### Array ("array")
Aliases: "Panel", "Panelization", "Panelisation", "customer panel"
The physical description of the array of boards, used in assembly

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size_x* | float | O | F | F | O | O | The size of the array in the x-asis, measured in millimeters
*size_y* | float | O | F | F | O | O | The size of the array in the y-asis, measured in millimeters
*boards_x* | integer | O | F | F | O | O | Number of boards in the panel in the x-direction.
*boards_y* | integer | O | F | F | O | O | Number of boards in the panel in the y-direction.
*boards_total* | integer | O | F | F | O | O | Number total number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used.
*border_left* | float | O | O | O | O | O | The size of the left side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_right* | float | O | O | O | O | O | The size of the right side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_top* | float | O | O | O | O | O | The size of the top side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_bottom* | float | O | O | O | O | O | The size of the bottom side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*board_spacing_x* | float | O | O | O | O | O | The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*board_spacing_y* | float | O | O | O | O | O | The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*fiducials_number* | integer | O | O | O | F | O | The number of fiducials on the array.
*fiducials_size* | float | O | O | O | O | O | The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size
*fiducials_shape* | list | O | O | O | O | O | The shape of the fiducials.<br>Possible values are (string):<br>"donut"<br>"circle"<br>"plus"<br>"diamond"<br>
*breakaway_method* | list | O | O | O | O | O | The method of creation of the breakaways on the array<br>Possible values are (string):<br>"routing"<br>"scoring" (alises includes "v-cut" and "v-grove")<br>"jump_scoring"<br>
*mouse_bites* | boolean | O | O | O | O | O | Indicates if there should be "mouse bites" to allow easy break away of the boards
*tooling_holes_number* | integer | O | O | O | O | O | The number of tooling holes on the array.
*tooling_holes_size* | float | O | O | O | O | O | The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size.
*x_outs_allowed* | boolean | O | O | O | O | O | Manufacturer can deliver arrays with defect boards as long as these are clearly marked as defect (X'ed out).
*x_outs_max_percentage_on_array* | integer | O | O | O | O | O | The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage
*transplant_board_allowed* | boolean | O | O | O | O | O | The maximum number of defective and clearly marked as such boards that are allowed on on panel, stated in percentage
*weight* | float | O | F | F | F | O | The weight of the array measured in grams

### Mechanical Processes ("mechanical")
Mechanical processes in the manufacturing

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*edge_bevelling* | boolean | O | O | O | O | O | Edge bevelling present.
*depth_routing_top* | boolean | O | O | O | O | O | Depth Routing from the top present
*depth_routing_bottom* | boolean | O | O | O | O | O | Depth Routing from the bottom present.
*counterboring_top* | boolean | O | O | O | O | O | Counterboring from the top present.
*counterboring_bottom* | boolean | O | O | O | O | O | Counterboring from the bottom present.
*countersink_top* | boolean | O | O | O | O | O | Countersink from the top present.
*countersink_bottom* | boolean | O | O | O | O | O | Countersink from the bottom present.
*punching* | boolean | O | O | O | O | O | Punching process required.
*plated_edges* | boolean | O | O | O | O | O | Plated Edges process required.
*plated_slots* | boolean | O | O | O | O | O | Plated Slots process required.
*plated_castellated_holes* | boolean | O | O | O | O | O | Plated Castellated Holes process required.
*coin_attachment* | boolean | O | O | O | O | O | Coin Attachment process required.

### Selective plated pads ("selective_plated_pads")
Aliases: "selective hard gold"
Selective plated pads

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*present* | boolean | O | O | O | O | O | Selective plated pads present.
*layers* | string | O | F | F | F | O | The layers included in the connectors, counter from 1 (top layer).

### Hard Gold Edge Connectors ("hard_gold_edge_connectors")
Aliases: "gold fingers"
Edge connectors made with hard gold

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*present* | boolean | O | O | O | O | O | Hard gold edge connectors present.
*thickness* | list | O | O | O | O | O | The thickness of the connectors<br>Possible values are (string):<br>"0.76" (According to IPC Class 2)<br>"1.27" (According to IPC Class 3)<br>"other" (To be specified in the thicknes_other tag)<br>
*thicknes_other* | float | O | O | O | F | O | Thickness if it is not "0.76" or "1.27".
*area* | float | O | F | F | F | O | Area covered by the edge connectors in square desimeter.
*layers* | string | O | F | F | F | O | The layers included in the connectors, counter from 1 (top layer).

### Markings ("markings")
Physical markings on the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*date_code* | string | O | O | O | F | O | Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".
*placement* | list | O | O | O | O | O | Placement of the markings.<br>Possible values are (string):<br>"copper_top"<br>"copper_bottom"<br>"soldermask_top"<br>"soldermask_bottom"<br>"legend_top"<br>"legend_bottom"<br>
*manufacturer_identification* | boolean | O | O | O | O | O | Manufacturer identification present.
*standards* | array | O | O | O | O | O | Possible values are the ones listed in the subelement "standards" but typical will be "ul" and "rohs"
*serial_number* | boolean | O | O | O | O | O | Serial number should be added in the markings.
*serial_number_format* | string | O | O | O | F | O | Format of the serial number expressed as a "regular expression" but needs to have x amount of digits in it.
*serial_number_start* | integer | O | O | O | F | O | The number to start the serial number from. Will have to replace the digits from the "serial_number_format" above.
*serial_number_increase_by* | integer | O | O | O | F | O | The increase in number from "serial_number_start" with each product.

### Standards and Requirements ("standards")
If the format is boolean and nothing is stated other than the name of the standard in the Decription column, it should be understood as follows: Are to be met (if Specification), required (in Profile) or possible (in Capability)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*ul* | boolean | O | O | O | O | O | Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
*c_ul* | boolean | O | O | O | O | O | Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
*rohs* | boolean | O | O | O | O | O | RoHS.
*ul94* | list | O | O | O | O | O | UL 94 - Standard for Safety of Flammability of Plastic Materials for Parts in Devices and Appliances testing<br>Possible values are (string):<br>"hb" (HB - Slow burning on a horizontal specimen; burning rate < 76 mm/min for thickness < 3 mm or burning stops before 100 mm)<br>"v_0" (V-0 - Burning stops within 30 seconds on a vertical specimen; drips of flaming particles are allowed.)<br>"v_1" (V-1 - Burning stops within 30 seconds on a vertical specimen; drips of particles allowed as long as they are not inflamed.)<br>"v_2" (V-2 - Burning stops within 30 seconds on a vertical specimen; drips of flaming particles are allowed.)<br>"5vb" (5VB - Burning stops within 60 seconds on a vertical specimen; no drips allowed; plaque specimens may develop a hole.)<br>"5va" (5VA - Burning stops within 60 seconds on a vertical specimen; no drips allowed; plaque specimens may not develop a hole.)<br>
*esa* | boolean | O | O | O | O | O | European Space Agency Use.
*itar* | boolean | O | O | O | O | O | US ITAR.
*dfars* | boolean | O | O | O | O | O | US DFARS.
*mil_prf_55110* | boolean | O | O | O | O | O | MIL-PRF-55110.
*mil_prf_50884* | boolean | O | O | O | O | O | MIL-PRF-5884.
*mil_prf_31032* | boolean | O | O | O | O | O | MIL-PRF-31032.
*as9100* | boolean | O | O | O | O | O | AS9100.
*nadcap* | boolean | O | O | O | O | O | NADCAP.
*rw_en45545_2_2013* | boolean | O | O | O | O | O | Railway Europe EN45545-2:2013.
*rw_nf_f_16_101* | boolean | O | O | O | O | O | Railway France NF F 16-101.
*rw_uni_cei_11170_3* | boolean | O | O | O | O | O | Railway Italy UNI CEI 11170-3.
*rw_nfpa_130* | boolean | O | O | O | O | O | Railway USA NFPA 130.
*ipc_6010_class* | list | O | O | O | O | O | According to Table 4-2 /4-3.<br>Possible values are (string):<br>"1"<br>"2"<br>"3"<br>
*ipc_6010_compliance_level* | list | O | O | O | O | O | <br>Possible values are (string):<br>"full"<br>"factory_standard"<br>"aabus" (As Agreed Between User and Supplier)<br>
*ipc_6010_copper_plating_thickness_level* | list | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.<br>Possible values are (string):<br>"2"<br>"3"<br>
*ipc_6010_annular_ring_level* | list | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.<br>Possible values are (string):<br>"2"<br>"3"<br>
*ipc_6010_conductor_spacing_level* | list | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add conductor spacing demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.<br>Possible values are (string):<br>"2"<br>"3"<br>
*ipc_6010_conductor_width_level* | list | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add conductor width demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.<br>Possible values are (string):<br>"2"<br>"3"<br>
*ipc_6012_class* | list | O | O | O | O | O | Requirements according to IPC 6012 class.<br>Possible values are (string):<br>"1"<br>"2"<br>"3"<br>"3A" (Automotive addendum)<br>"3S" (Space and Military Avionics Addendum)<br>"3M" (Medical Addendum)<br>
*ipc_6013_class* | list | O | O | O | O | O | Requirements according to IPC 6013 for flexible or rigid-flex boards.<br>Possible values are (string):<br>"1"<br>"2"<br>"3"<br>
*ipc_6018* | boolean | O | O | O | O | O | IPC-6018 Microwave End Product Board Inspection and Test.

### Testing ("testing")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*netlist* | boolean | O | O | O | O | O | 100% Netlist testing according to IPC-D-356, ODB++ or IPC2581.
*allow_generate_netlist* | boolean | O | O | O | O | O | Allow Netlist to be generated from Gerber or other file format if needed.
*hipot* | boolean | O | O | O | O | O |  HiPot Test (Dielectric Withstanding Voltage Test).
*4_wire* | boolean | O | O | O | O | O | Use 4 wired test
*ist* | boolean | O | O | O | O | O | Use IST testing.
*impedance* | list | O | O | O | O | O | <br>Possible values are (string):<br>"controlled"<br>"calculated"<br>"follow_stackup"<br>

### Country of Origin ("country_of_origin")
Country of Origin is the country where the Printed Circuit Board is manufactured.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*iso_3166_1_alpha_3* | string | O | O | O | O | O | A three letter string representation of the Country of origin according too ISO 3166-1.
*iso_3166_1_alpha_2* | string | O | O | O | O | O | A two letter string representation of the Country of origin according too ISO 3166-1.
*nato_member* | boolean | O | O | O | O | O | Indicates if the COO is a NATO member state
*eu_member* | boolean | O | O | O | O | O | Indicates if the COO is a European Union member state.

### Conflict resolution ("conflict_resolution")
If several sources of data is present, this hierarchy is to set how to solve conflicts. Please specify a number to indicate priority and avoid setting the same number twice.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*order* | integer | O | O | O | F | O | Information provided on order level
*oem_specification_sheet* | integer | O | O | O | F | O | Information provided from the OEM in a PDF or other document format
*assembly_specification_sheet* | integer | O | O | O | F | O | Information provided from the assembly facility in a PDF or other document format
*drawing* | integer | O | O | O | F | O | Information in a drawing (if present)
*ipc2581* | integer | O | O | O | F | O | Information in an IPC-2581 file
*odb* | integer | O | O | O | F | O |  Information in a ODB++ file.
*gerber* | integer | O | O | O | F | O | Information in a Gerber format file

### Holes ("holes")
One for each holes process, or at least one that sums up the minimum requirements
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*number* | integer | O | F | F | F | O | The number of holes total or in this process.
*type* | list | O | F | F | F | O | The type of holes.<br>Possible values are (string):<br>"through"<br>"blind"<br>"buried"<br>"back_drill"<br>
*plated* | boolean | O | O | O | O | O | True if the holes are plated.
*size* | float | O | F | F | F | O | The size of the hole in micrometers. Can be considered the minimum hole size if only one holes element present in the list or as a capability.
*tool_diameter* | boolean | O | F | F | F | O | If false, size indicated the hole diameter, if true the size indicates the tool diameter
*layer_start* | integer | O | F | F | F | O | The layer where the hole starts, counted from the top, where top layer is 1.
*layer_stop* | integer | O | F | F | F | O | The layer where the hole stops, counted from the top, where top layer is 1.
*depth* | float | O | F | F | F | O | The depth of the hole in micrometer.
*method* | list | O | F | F | F | O | Can be either "routing" or "drilling", where drilling is default<br>Possible values are (string):<br>"routing"<br>"drilling"<br>"laser"<br>
*minimum_designed_annular_ring* | float | O | F | F | F | O | The minimum designed annular ring in micrometers.
*press_fit* | boolean | O | F | F | F | O | Press Fit holes.
*copper_filled* | boolean | O | F | F | F | O | Copper filled holes.
*staggered* | boolean | O | F | F | F | O | Staggered holes.
*stacked* | boolean | O | F | F | F | O | Stacked holes.
*alivh* | boolean | O | F | F | F | O | ALIVH holes.

### Allowed Modifications ("allowed_modifications")
Changes/fabrication decisions that are allowed to make to the files provided.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*dead_pad_removal* | boolean | O | O | O | O | O | Non Functioning Pad removal.
*add_copper_balancing* | boolean | O | O | O | O | O | Adding copper balancing pattern
*add_copper_balancing_on_array* | boolean | O | O | O | O | O | Adding copper balancing pattern on array/panel frame.
*add_tear_drops* | boolean | O | O | O | O | O | Adding Tear Drops.

### Additional Requirements ("additional_requirements")
This section is for all requirements that still has not been adapted to the standard or needs to be stated as a comment. It allows you to specify custom elements that should be considered as part of the specification. You specify the value here and then need to create a separate element for it in the custom -> additional section. Multiple elements allowed - to be added as a list.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*any_name* | string | O | F | F | F | O | Must have a similar element in the custom -> additional


## Custom elements

### Colors
Colors can be defined by hex, rgb, cmyk or name. Name of the color present here can be references in the other elements

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | string | O | O | O | O | O | name of the color
*type* | list | O | F | F | F | O | How the color is declared
*value* | string | O | F | F | F | O | If type is hex, the value needs to be a "#" + 6 hexadecimals (e.g. "#FFFFFF"). for "rgb" the format is "rgb(0, 255, 255)", for "cmyk" the format is "cmyk(100%, 0%, 0%, 0%)". The name is just a string.


### Materials
#### Soldermasks
Materials used as soldermask. Must be placed within a "printed_circuits_fabrication_data" element that also contains a version

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | string | O | O | O | O | O | The name of the Soldermask. Use the official name or some name as close to it as possible
*manufacturer* | string | O | O | O | O | O | The name of the manufacturer
*ipc-sm-840-class* | list | O | O | O | O | O | Soldermask to meet IPC SM 840 Class.
*link* | string | O | O | O | O | O | The link to some url that gives more information or a reference to the product.

#### Dielectrics
Materials used as dielectrics/laminates. Must be placed within a "printed_circuits_fabrication_data" element that also contains a version

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | string | O | O | O | O | O | The name of the Laminate. Use the official name or some name as close to it as possible.
*manufacturer* | string | O | O | O | O | O | The name of the manufacturer
*ipc_4101_sheet* | integer | O | O | O | O | O | The reference sheet number of the IPC 4101 Standard.
*ipc_4103_sheet* | integer | O | O | O | O | O | The reference sheet number of the IPC 4103 Standard.
*ipc_4204_sheet* | integer | O | O | O | O | O | The reference sheet number of the IPC 4204 Standard.
*tg_min* | integer | O | O | O | O | O | The minimum Glass Transition Temperature (Tg) required.
*tg_range_from* | integer | O | O | O | O | O | The Glass Transition Temperature (Tg) range starts at.
*tg_range_to* | integer | O | O | O | O | O | The Glass Transition Temperature (Tg) range ands at.
*td_min* | integer | O | O | O | O | O | The minimum required temperature at which a base laminate material experiences an established percentage of weight loss using Thermograv imetric Analysis (TGA).
*td_range_from* | integer | O | O | O | O | O | The Td range starts at.
*td_range_to* | integer | O | O | O | O | O | The Td range stops at.
*halogen_free* | boolean | O | O | O | O | O | Indicates the material is material free or is required to be
*rw_en45545_2_2013* | boolean | O | O | O | O | O | Railway Europe EN45545-2:2013 compatible
*rw_nf_f_16_101* | boolean | O | O | O | O | O | Railway France NF F 16-101 compatible
*rw_uni_cei_11170_3* | boolean | O | O | O | O | O | Railway Italy UNI CEI 11170-3 compatible.
*rw_nfpa_130* | boolean | O | O | O | O | O | Railway USA NFPA 130 compatible.
*ul* | boolean | O | O | O | O | O | UL compatible.
*link* | string | O | O | O | O | O | The link to some url that gives more information or a reference to the product.
*accept_equivalent* | boolean | O | O | O | O | O | Equivalent material to the one specified is OK to use as a replacement if true.

#### Stiffeners
The materials to be used as stiffener. Must be placed within a "printed_circuits_fabrication_data" element that also contains a version

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | string | O | O | O | O | O | The name of the Soldermask. Use the official name or some name as close to it as possible
*manufacturer* | string | O | O | O | O | O | The name of the manufacturer
*link* | string | O | O | O | O | O | The link to some url that gives more information or a reference to the product.


## Additional elements

Must have a similar element in specification -> additional_requirements

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*description* | string | O | F | F | F | O | The description of the additional requirement or comment
