# Open Trade Transfer Package: Printed Circuits Fabrication Data
An open standard for communicating information needed for PCB fabrication. Can be used to interchange information on the specification (fabrication data only), a profile (requirements and default values when exchanging data) and capabilities (the production facility capabilities of a supplier). It can also be used to exchange a material list or other needed related data.

## Based on the Open Trade Transfer Package format
[Open Trade Transfer Package](https://github.com/elmatica/Open-Trade-Transfer-Package) defines a structure on how the information is to be passed in either JSON or XML format. Printed Circuit data should be placed within an element called "printed_circuits_fabrication_data" and also contain a version. Printed Circuit data can be placed within the following subelements:

- products
- profile
  - defaults
  - enforced
  - restricted
- capability
  - summary
  - materials

You can also place custom elements in the appropriate folder, such as colors and materials.

## Version
Current version is 0.1. This should stated in every section directly below the "printed_circuits_fabrication_data" element in an element called "version". 0.1 is the first released version, and there are no prior versions.

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
    "profile": {
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

## abbreviations
Used in the tables below, they carry the following meaning:

- "O": Optional
- "R": Required
- "F": Forbidden

## Possible elements
The name of the element as it is to be used in the file is included behind the title within the parenthesis, e.g. "soldermask". When a table of possible elements is present, you will find the following headers:

- "Data tag": The name of the elements
- "Format": The format of the element (possible formats listed in the Open Trade Data Package format specification )
- "P": When used in a Product part of the file (to give a specification) (see above for structure and abbreviations)
- "PD": When used in a Profile->Defaults part of the file (see above for structure and abbreviations)
- "PE": When used in a Profile->Enforced part of the file (see above for structure and abbreviations)
- "PR": When used in a Profile->Restricted part of the file (see above for structure and abbreviations)
- "C": When used in a Capability part of the file (see above for structure and abbreviations)

If the element have alternative names in everyday use, this is referenced as an "Alias" and stated just below the title.

### Rigid Conductive layer ("rigid_conductive_layer")
The layers of rigid conductive material (usually copper)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*count* | Integer | R | F | F | F | O | The number of conductive layers. As a Capability it needs to be a Range.
*minimum_internal_track_width* | Float | O | F | F | O | O | The minimum nominal width of conductors on internal/unplated layers (minimum track). As a Capability it needs to be a Range.
*minimum_external_track_width* | Float | O | F | F | O | O | The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here. As a Capability it needs to be a Range.
*minimum_internal_spacing_width* | Float | O | F | F | O | O | The minimum gap between two conductors on the internal layers. As a Capability it needs to be a Range.
*minimum_external_spacing_width* | Float | O | F | F | O | O | The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here. As a Capability it needs to be a Range.
*external_base_copper_thickness* | List | O | F | F | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1. As a Capability it needs to be a Range.
*internal_base_copper_thickness* | List | O | F | F | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1. As a Capability it needs to be a Range.
*copper_foil_roughness* | List | O | O | O | O | O | The roughness of the copper foil. Can be either "S" (Standard), "L" (Low profile) or "V" (Very Low Profile). As a Capability it needs to be a Range.
*copper_coverage_average* | Float | O | F | F | F | F | The average copper coverage of the board. Used to calculate weight.


### Flexible Conductive layer ("flexible_conductive_layer")
The layers of flexible conductive material (usually copper)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*count* | Integer | R | F | F | F | O | The number of conductive layers. As a Capability it needs to be a Range.
*minimum_internal_track_width* | Float | O | F | F | O | O | The minimum nominal width of conductors on internal/unplated layers (minimum track). As a Capability it needs to be a Range.
*minimum_external_track_width* | Float | O | F | F | O | O | The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here. As a Capability it needs to be a Range.
*minimum_internal_spacing_width* | Float | O | F | F | O | O | The minimum gap between two conductors on the internal layers. As a Capability it needs to be a Range.
*minimum_external_spacing_width* | Float | O | F | F | O | O | The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here. As a Capability it needs to be a Range.
*external_base_copper_thickness* | List | O | F | F | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1. As a Capability it needs to be a Range.
*internal_base_copper_thickness* | List | O | F | F | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1. As a Capability it needs to be a Range.
*copper_foil_roughness* | List | O | O | O | O | O | The roughness of the copper foil. Can be either "S" (Standard), "L" (Low profile) or "V" (Very Low Profile). As a Capability it needs to be a Range.
*copper_foil_type* | List | O | O | O | O | O | The type of the copper foil. Can be either "ED" (Electro Deposited), "RA" (Rolled Annealed Copper). The default if not stated is "ED". As a Capability it needs to be a Range.
*copper_coverage_average* | Float | O | F | F | F | F | The average copper coverage of the board. Used to calculate weight.

### Final Finish ("final_finish")
Aliases: "Surfacefinish", "Surface finish", "Coating", "finalfinish", "Solderable finish", "Solderable coating"c

A list of final finishes, can be more than one. E.g. selective finish ENIG and OSP.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*finish* | List | O | O | O | O | O | The material/method/surface to be used in the finish. Pick from the valuelist "Final finishes". As a Capability it needs to be a Range.
*area* | Float | O | F | F | F | F | The area that the finish will cover, in square decimeter. As a Capability it needs to be a Range.
*thickness* | Float | O | O | O | F | O |  The thickness of the finish in micrometer. As a Capability it needs to be a Range.
*gold_thickness* | Float | O | O | O | F | O |  The thickness of the gold finish in micrometer. As a Capability it needs to be a Range.
*silver_thickness* | Float | O | O | O | F | O | The thickness of the silver finish in micrometer. As a Capability it needs to be a Range.
*paladium_thickness* | Float | O | O | O | F | O | The thickness of the paladium finish in micrometer. As a Capability it needs to be a Range.
*tin_thickness* | Float | O | O | O | F | O | The thickness of the tin finish in micrometer. As a Capability it needs to be a Range.
*nickel_thickness* | Float | O | O | O | F | O | The thickness of the nickel finish in micrometer. As a Capability it needs to be a Range.

### Dielectric ("dielectric")
Aliases: "Laminate"

A list of one of more materials by name and referencing a material listed in the materials section.

#### Example

```
"dielectric": [
  {
    "material": "Generic FR-4 UL approved"
  }
],
...
"materials": {
  "Generic FR-4 UL approved": {
    "name": "FR-4",
    "ipc-4101-sheet": 121,
    "tg_min": 140,
    "ul": true
  }
}
```

### Soldermask ("soldermask")
Aliases: "solder mask", "sm", "solder resist", "green mask"

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*color* | List or Custom | O | O | O | O | O | This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*finish* | List | O | O | O | O | O | Can be `matte`, `semi-matte`, `glossy` or `any`. Required due to the "any" value
*min_thickness* | Float | O | O | O | F | O | The minimum thickness of the soldermask
*max_thickness* | Float | O | O | O | F | O | The maximum thickness of the soldermask
*material* | Material | O | O | O | O | O | The material needs to listed in the materials section
*top* | Boolean | O | O | O | O | O | Indicates soldermask presence/capability at top
*bottom* | Boolean | O | O | O | O | O | Indicates soldermask presence/capability at bottom

### Legend ("legend")
Alias: "silk screen" or "silkscreen", "ink", "ident".

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*color* | List or Custom | O | O | O | O | O | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*top* | Boolean | O | O | O | O | O | Available when used in other sections than specification -> layers. Indicates legend presence/capability at top
*bottom* | Boolean | O | O | O | O | O | Available when used in other sections than specification -> layers. Indicates legend presence/capability at bottom


### Stiffener ("stiffener")
Aliases: "Support"

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size* | Float | O | O | O | F | O | The size of the stiffener should be specified in drawing
*placement* | List | O | O | O | F | O | Can be either "top" or "bottom", indicating if the stiffener is on top or bottom of the flexible layer
*thickness* | Float | O | O | O | F | O | The thickness of the stiffener
*material* | Material | O | O | O | O | O | The material needs to listed in the materials section.

### CoverLay ("coverlay")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*total_thickness* | Integer | O | O | O | O | O | The number of...
*top* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates coverlay presence/capability at top
*bottom* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates coverlay presence/capability at bottom


### Peelable mask ("peelable_mask")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*heating_operations* | Integer | O | O | O | F | O | The number of...
*top* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at top
*bottom* | Boolean | O | O | O | O | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at bottom

### Kapton tape ("kapton_tape")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at top
*bottom* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at bottom
*accept_equivalent* | Boolean | O | O | O | O | O | If alternative to DuPont™ Kapton® HN general-purpose film can be used

### Conductive Carbon Print ("conductive_carbon_print")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates carbon print presence/capability at top
*bottom* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates carbon print presence/capability at bottom

### Silver Print ("silver_print")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates silver print presence/capability at top
*bottom* | Boolean | O | O | O | F | O | Available when used in other sections than specification -> layers. Indicates silver print presence/capability at bottom

### Inner Packaging ("inner_packaging")
This describes how boards are packed together to be shipped. Part of IPC 1601 (4.2.2)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type_of_bag* | List | O | O | O | O | O | Possible values are `a`, `b`, `c`, `d` where `a` = Nylon/Foil/Polyethylene, `b` = TyvekTM/Foil/Polyethylene, `c` = Aluminized Polyester/Polyethylene and `d` = Clear Plastics/Polymers (non-metallic).
*hic* | Boolean | O | O | O | O | O | True to include a Humidity Indicator Card (HIC), False to not
*esd* | Boolean | O | O | O | O | O | True to indicate that packaging for ESD-sensitive required.
*silica* | Boolean | O | O | O | O | O | True to indicate that a silica bag is required
*desiccant* | Boolean | O | O | O | O | O | True to indicate that a desiccant material is required
*vacuum* | Boolean | O | O | O | O | O | True to indicate that vacuum is needed for shrinkage - no heat rap or shrink rap allowed.

### Via Protection
The via/hole protection according to IPC 4761

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type_1* | Boolean | O | O | O | O | O | A via with a dry film mask material applied bridging over the via wherein no additional materials are in the hole.
*type_2* | Boolean | O | O | O | O | O | A Type I via with a secondary covering of mask material applied over the tented via.
*type_3* | Boolean | O | O | O | O | O | A via with material applied allowing partial penetration into the via. The plug material may be applied from one or both sides.
*type_4a* | Boolean | O | O | O | O | O | A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*type_4b* | Boolean | O | O | O | O | O | A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*type_5* | Boolean | O | O | O | O | O | A via with material applied into the via targeting a full penetration and encapsulation of the hole.
*type_6a* | Boolean | O | O | O | O | O | A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides..
*type_6b* | Boolean | O | O | O | O | O | A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*type_7* | Boolean | O | O | O | O | O | A Type V via with a secondary metallized coating covering the via. The metallization is on both sides.


### Board ("board")
The physical description of the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size_x* | Float | O | O | O | O | O | The size of the board in the x-asis, measured in millimeters
*size_y* | Float | O | O | O | O | O | The size of the board in the y-asis, measured in millimeters
*thickness* | Float | O | O | O | O | O | The thickness of the board measured in millimeters

### Array ("array")
Aliases: "Panel", "Panelization", "Panelisation", "customer panel"

The physical description of the array of boards, used in assembly

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size_x* | Float | O | O | O | O | O | The size of the array in the x-asis, measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum size of the array
*size_y* | Float | O | O | O | O | O | The size of the array in the y-asis, measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum size of the array
*boards_x* | Integer | R | O | O | O | O | The thickness of the board measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum number of boards in the X-direction.
*boards_y* | Integer | R | O | O | O | O | The thickness of the board measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum number of boards in the X-direction.
*border_left* | Float | O | O | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_right* | Float | O | O | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_top* | Float | O | O | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_bottom* | Float | O | O | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*board_spacing_x* | Float | O | O | O | O | O | The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*boards_spacing_y* | Float | O | O | O | O | O | The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*fiducials_number* | Integer | O | O | O | F | O | The number of fiducials on the array.
*fiducials_size* | Float | O | O | O | O | O | The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size
*fiducials_shape* | Valuelist | O | O | O | O | O | The shape of the fiducials. Can be either "donut", "circle", "plus" or "diamond".
*breakaway_method* | Valuelist | R | O | O | O | O | The method of creation of the breakaways on the array. Possible values are "routing", "scoring" (alises includes "v-cut" and "v-grove") and "jump_scoring". If used in a Capability it can include several values separated with a comma
*mouse_bites* | Boolean | O | O | O | O | O | Indicates if there should be "mouse bites" to allow easy break away of the boards
*tooling_holes_number* | Integer | R| O | O | O | O | The number of tooling holes on the array.
*tooling_holes_size* | Float | R | O | O | O | O | The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size

### Mechanical Processes ("mechanical")
Mechanical processes

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*edge_bevelling* | Boolean | O | O | O | O | O | Edge bevelling present (if Specification), allowed (in Profile) or possible (in Capability)
*depth_routing_top* | Boolean | O | O | O | O | O | Depth Routing from the top present (if Specification), allowed (in Profile) or possible (in Capability)
*depth_routing_bottom* | Boolean | O | O | O | O | O | Depth Routing from the bottom present (if Specification), allowed (in Profile) or possible (in Capability)
*counterboring_top* | Boolean | O | O | O | O | O | Counterboring from the top present (if Specification), allowed (in Profile) or possible (in Capability)
*counterboring_bottom* | Boolean | O | O | O | O | O | Counterboring from the bottom present (if Specification), allowed (in Profile) or possible (in Capability)
*countersink_top* | Boolean | O | O | O | O | O | Countersink from the top present (if Specification), allowed (in Profile) or possible (in Capability)
*countersink_bottom* | Boolean | O | O | O | O | O | Countersink from the bottom present (if Specification), allowed (in Profile) or possible (in Capability)

### Markings ("markings")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*date_code* | String | O | O | O | O | O | ossible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".
*placement* | Valuelist | O | O | O | O | O | Placement of the markings. Possible values are "copper_top", "copper_bottom", "soldermask_top", "soldermask_bottom", "legend_top" or "legend_bottom". When used as a Capability, several can be listed separated by a comma
*manufacturer_identification* | Boolean | O | O | O | O | O | Manufacturer identification present (if Specification), allowed (in Profile) or possible (in Capability)
*standards* | Valuelist | R | O | O | O | O | Possible values are the ones listed in the subelement "Standards and Requirements" but typical will be "ul" and "rohs". Separate by comma.

### Standards and Requirements ("standards")
If the format is boolean and nothing is stated other than the name of the standard in the Decription column, it should be understood as follows: Are to be met (if Specification), required (in Profile) or possible (in Capability)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*ul* | Boolean | O | O | O | O | O | Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material
*c_ul* | Boolean | O | O | O | O | O | Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material
*rohs* | Boolean | O | O | O | O | O | RoHS
*ul94* | Valuelist | O | O | O | O | O | Possible values are "None, "v_0", "v_1" or "v_2". If capability, several can be listed separated by a comma.
*esa* | Boolean | O | O | O | O | O | European Space Agency Use
*itar* | Boolean | O | O | O | O | O | ITAR
*dfars* | Boolean | O | O | O | O | O | DFARS
*mil_prf_55110* | Boolean | O | O | O | O | O | MIL-PRF-55110
*mil_prf_50884* | Boolean | O | O | O | O | O | MIL-PRF-5884
*mil_prf_31032* | Boolean | O | O | O | O | O | MIL-PRF-31032
*as9100* | Boolean | O | O | O | O | O | AS9100
*nadcap* | Boolean | O | O | O | O | O | NADCAP
*rw_en45545_2_2013* | Boolean | O | O | O | O | O | Railway Europe EN45545-2:2013
*rw_nf_f_16_101* | Boolean | O | O | O | O | O | Railway France NF F 16-101
*rw_uni_cei_11170_3* | Boolean | O | O | O | O | O | Railway Italy UNI CEI 11170-3
*rw_nfpa_130* | Boolean | O | O | O | O | O | Railway USA NFPA 130
*ipc_6012_class* | Valuelist | O | O | O | O | O | Requirements according to IPC 6012 class. Possible values are "1", "2", "3", "3A" (Automotive addendum), "3S" (Space and Military Avionics Addendum) or "3M" (Medical Addendum).
*ipc_6013_class* | Valuelist | O | O | O | O | O | Requirements according to IPC 6013 for flexible or rigid-flex boards. Possible values are "1", "2", "3".
*ipc_6018* | Boolean | O | O | O | O | O | IPC-6018 Microwave End Product Board Inspection and Test
*ipc_6010_class* | Valuelist | O | O | O | O | O | Possible values are "1", "2" or "3". According to Table 4-2 /4-3
*ipc_6010_compliance_level* | Valuelist | O | O | O | O | O | Possible values are "full", "factory_standard", "aabus".
*ipc_6010_copper_plating_thickness_level* | Valuelist | O | O | O | O | O | Possible values are 2" or "3". Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6010_annular_ring_level* | Valuelist | O | O | O | O | O | Possible values are 2" or "3". Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6010_conductor_spacing_level* | Valuelist | O | O | O | O | O | Possible values are 2" or "3". Used either if ipc_6010_class is set to 2 and you want to add conductor spacing demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6010_conductor_width_level* | Valuelist | O | O | O | O | O | Possible values are 2" or "3". Used either if ipc_6010_class is set to 2 and you want to add conductor width demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.


### Testing ("testing")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*netlist* | Boolean | O | O | O | O | O | 100% Netlist testing according to IPC-D-356, ODB++ or IPC2581
*allow_generate_netlist* | Boolean | O | O | O | O | O | Allow Netlist to be generated from Gerber or other file format if needed
*hipot* | Boolean | O | O | O | O | O | HiPot Test  (Dielectric Withstanding Voltage Test)
*impedance* | Valuelist | O | O | O | O | O | Possible values er "controlled", "calculated" or "follow_stackup"
*4_wire* | Boolean | O | O | O | O | O | Use 4 wired test
*ist* | Boolean | O | O | O | O | O | Use IST testing


### Country of Origin ("country_of_origin")
Country of Origin is the country where the Printed Circuit Board is manufactured.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*iso_3166_1_alpha_3* | String | O | O | O | O | O | A three letter string representation of the Country of origin according too ISO 3166-1
*iso_3166_1_alpha_2* | String | O | O | O | O | O | A two letter string representation of the Country of origin according too ISO 3166-1
*nato_member* | Boolean | O | O | O | O | O | Indicates if the COO is a NATO member state (or needs to be if used as a profile)
*eu_member* | Boolean | O | O | O | O | O | Indicates if the COO is a European Union member state (or needs to be if used in a profile)

### Conflict resolution ("conflict_resolution")
If several sources of data is present, this hierarchy is to set how to solve conflicts. Please specify a number to indicate priority and avoid setting the same number twice.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*order* | Integer | O | O | O | Information provided on order level
*oem_specification_sheet* | Integer | O | O | O | O | O | Information provided from the OEM in a PDF or other document format
*assembly_specification_sheet* | Integer | O | O | O | O | O | Information provided from the assembly facility in a PDF or other document format
*drawing* | Integer | O | O | O | O | O | Information in a drawing (if present)
*ipc2581* | Integer | O | O | O | O | O | Information in an IPC-2581 file
*odb* | Integer | O | O | O | O | O | Information in a ODB++ file
*gerber* | Integer | O | O | O | O | O | Information in a Gerber format file

#### Example
```
<conflict_resolution>
  <order>1</order>
  <oem_specification_sheet>2</oem_specification_sheet>
  <assembly_specification_sheet>3</assembly_specification_sheet>
  <drawing>4</drawing>
  <ipc2581>5</ipc2581>
  <odb>6</odb>
  <gerber>7</gerber>
</conflict_resolution>
```

### Holes ("holes")
Multiple elements allowed.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*number* | Number | O | O | O | O | O | The number of holes of these specific settings
*type* | Valuelist | O | O | O | O | O | The type of holes. Possible values are "through", "blind", "buried" or "back_drill"
*plated* | Boolean | O | O | O | O | O | True if the holes are plated
*size* | Number | O | O | O | O | O | The size of the hole in micrometers
*layer_start* | Number | O | O | O | O | O | The layer where the hole starts, counted from the top, where top layer is 1
*layer_stop* | Number | O | O | O | O | O | The layer where the hole stops, counted from the top, where top layer is 1
*depth* | Float | O | O | O | O | O | The depth of the hole
*method* | Value | O | O | O | O | O | Can be either "routing" or "drilling", where drilling is default
*minimum_designed_annular_ring* | Float | O | O | O | O | O | The minimum designed annular ring

### Allowed Modifications ("allowed_modifications")
Changes/fabrication decisions that are allowed to make to the files provided.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*dead_pad_removal* | Boolean | O | O | O | O | F | Non Functioning Pad removal
*add_copper_balancing* | Boolean | O | O | O | F | O | Adding copper balancing pattern
*add_copper_balancing_on_array* | Boolean | O | O | O | O | F | Adding copper balancing pattern on array/panel frame
*add_tear_drops* | Boolean | O | O | O | O | F | Adding Tear Drops

### Additional Requirements ("additional_requirements")
This section is for all requirements that still has not been adapted to the standard. It allows you to specify custom elements that should be considered as part of the specification. You specify the value here and then need to create a separate element for it in the custom elements->additional section. Multiple elements allowed - to be added as a list.

#### Example

```
{
  "open_trade_transfer_package": {
    "version": "0.1"
    },
    "products": {
      "testproduct": {
        "printed_circuits_fabrication_data": {
          "version": "0.1",
          "additional_requirements": ["embedded_coin_soldered", "material_inlay", "multiple_net_via"]
        }
      }
    },
    "custom": {
      "additional": {
        "embedded_coin_soldered": "Soldered on embedded coin",
        "material_inlay": "Different material locally on some part of board",
        "multiple_net_via": "Multiple Net Via"
        }
      }
    }
  }
}

```

## Custom elements

### Colors

### Materials
#### Soldermasks
A list of suggested soldermasks can be found in a separate file but feel free to define ones that are not found in that file. The generic ones includes below. Structure is as follows:

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | String | O | O | O | O | O | The name of the Soldermask. Use the official name or some name as close to it as possible
*manufacturer* | String | O | O | O | O | O | The name of the manufacturer
*ipc-sm-840-class* | Valuelist | O | O | O | O | O | Can be either T or H
*link* | String | O | O | O | O | O | The link to some url that gives more information or a reference to the product

#### Dielectric / Laminate

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | String | O | O | O | O | O | The name of the Laminate. Use the official name or some name as close to it as possible
*manufacturer* | String | O | O | O | O | O | The name of the manufacturer of the material
*ipc-4101-sheet* | Integer | O | O | O | O | O | The reference sheet number of the IPC 4101 Standard.
*ipc-4103-sheet* | Integer | O | O | O | O | O | The reference sheet number of the IPC 4103 Standard.
*tg_min* | Integer | O | O | O | O | O | The minimum Glass Transition Temperature (Tg) required.
*tg_range_from* | Integer | O | O | O | O | O | The Glass Transition Temperature (Tg) range starts at
*tg_range_to* | Integer | O | O | O | O | O | The Glass Transition Temperature (Tg) range ands at
*td_min* | Integer | O | O | O | O | O | The minimum required temperature at which a base laminate material experiences an established percentage of weight loss using Thermograv imetric Analysis (TGA)
*td_range_from* | Integer | O | O | O | O | O | The Td range starts at
*td_range_to* | Integer | O | O | O | O | O | The Td range stops at
*halogen_free* | Boolean | O | O | O | O | O | Indicates the material is material free or is required to be.
*rw_en45545_2_2013* | Boolean | O | O | O | O | O | Railway Europe EN45545-2:2013 compatible
*rw_nf_f_16_101* | Boolean | O | O | O | O | O | Railway France NF F 16-101 compatible
*rw_uni_cei_11170_3* | Boolean | O | O | O | O | O | Railway Italy UNI CEI 11170-3 compatible
*rw_nfpa_130* | Boolean | O | O | O | O | O | Railway USA NFPA 130 compatible
*ul* | Boolean | O | O | O | O | O | UL compatible
*link* | String | O | F | F | F | F | The link to some url that gives more information or a reference to the product

#### Stiffener

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | String | O | O | O | O | O | The name of the stiffener. Use the official name or some name as close to it as possible
*manufacturer* | String | O | O | O | O | O | The name of the manufacturer of the material
*link* | String | O | O | O | O | O | The link to some url that gives more information or a reference to the product

### Additional

This defines the additional requirements defined in the elements above. It consists solely of a name and a description of your choice. See the example above.

## Value Lists

### Final finishes

Data tag | Description
---------|------------
*c_bare_copper* | AABUS
*isn* / *immersion_tin* | IPC-4554 Immersion Tin
*iag* / *immersion_silver* | IPC-4553 Immersion Silver
*enepig* | IPC-4556 ENEPIG
*enig* | IPC-4552 Immersion Gold
*osp*	| J-STD-003 Organic Solderability Preservative (OSP)
*ht_osp* | J-STD-003 High Temperature OSP
*g* | ASTM-B-488 Gold for edge printed board connectors and areas not to be soldered (hard gold)
*GS* | J-STD-003 Gold Electroplate on areas to be soldered (flash gold)
*t_fused*	| J-STD-003 Electrodeposited Tin-Lead (fused)
*tlu_unfused* | J-STD-003 Electrodeposited Tin-Lead Unfused
*dig* | J-STD-003 Direct Immersion Gold (Solderable Surface)
*gwb-1_ultrasonic* | ASTM-B-488 Gold Electroplate for areas to be wire bonded (ultrasonic - for gold wire bonding) (soft gold)
*gwb-2_thermosonic* | ASTM-B-488 Gold Electroplate for areas to be wire bonded (thermosonic - for aluminum wire bonding)
*s_hasl* | J-STD-003_J-STD-006 Solder Coating over Bare Copper (HASL)
*lf_hasl* | J-STD-003_J-STD-006 Lead-Free Solder Coating over Bare Copper (Lead-Free HASL, Lead free HASL)
