# openpcbXML
An open XML standard for communicating information needed for PCB manufacturability. Can be used to interchange information on the specification (manufacturing data only), a profile (requirements and default values when exchanging data) and capabilities (the production facility capabilities of a supplier).

## Structure of the XML
Within the root level (openpcbxml) everything is divided into four groups and their subgroups:

- specification
  - summary (listed in any order)
  - layers (listed top-down, include at least one conductive layer to determine placement in stack-up)
- profile
  - defaults
  - enforced
  - restricted
- capability
  - summary
  - materials
- custom
  - colors

## Data formats
- Percentage - Denotes a percentage - all percentages are expressed as percent out of 100- for example 10.4% is written as "10.4" and not "0.104"
- List - The data has only a fixed number of values that are selected from the list in the description table for the tag.  These items are case sensitive, and no other values are allowed.
- Text - The data is free format text.  For multiline entries, line breaks will be preserved where possible and the text may be truncated on import if the text is too long for the importing program to store.  Multiline entries may be split with either a newline (Unix format) or a carriage return – newline combination (DOS format).  Importing programs should accept either.
- Boolean - May be either TRUE or FALSE, with TRUE and FALSE in capitals.  A default value should be specified for optional fields - the default is used if the value is not present.
- Integer - An integer number with no decimal point.  May include negative values - examples include ...-3, -2, -1, 0, 1, 2, 3,...
- Floating Point - A floating point number, usually expressed in its simplest form with a decimal point as in "1.2", "0.004", etc...  Programs shall endeavor to store as many significant digits as possible to avoid truncating or losing small values.

## abbreviations
Used in the tables below, they carry the following meaning:

- "O": Optional
- "R": Required
- "F": Forbidden

## Possible elements
The name of the element as it is to be used in the XML is included behind the title within the parenthesis, e.g. "soldermask". When a table of possible elements is present, you will find the following headers:

- "Data tag": The name of the elements
- "Format": The format of the element (possible formats listed above)
- "S": When used in a Specification part of the XML (see above for structure and abbreviations)
- "P": When used in a Profile part of the XML (see above for structure and abbreviations)
- "C": When used in a Capability part of the XML (see above for structure and abbreviations)
- If the element have alternative names in everyday use, this is referenced as an "Alias" and stated just below the title.

### Rigid Conductive layer ("conductive_layer")
- specification -> summary (single)
- specification -> layers (multiple)
- profile -> all sections
- capability

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*count* | Integer| R/O | F | R | The number of conductive layers. Forbidden to use in the specification -> layers part. As a capability it needs to be a range represented as X-X
*minimum_track_width* | Integer | O | O | O | The minimum track width of conductors either on the specific layer (if in specification -> layer) or total
*minimum_internal_track_width* | Integer | O/F | O | O | The minimum track width of conductors in internal layers (can not be used in a stackup)
*minimum_external_track_width* | Integer | O/F | O | O | The minimum track width of conductors in external layers (can not be used in a stackup)
*minimum_spacing_width* | Integer | O | O | O | The minimum gap between two conductors either on the specific layer (if in specification -> layer) or total
*minimum_internal_spacing_width* | Integer | O/F | O | O | The minimum gap between two conductors on the internal layers (can not be used in a stackup)
*minimum_external_spacing_width* | Integer | O/F | O | O | The minimum gap between two conductors on the external layers (can not be used in a stackup)
*external_base_copper_thickness* | Valuelist | O | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1  
*internal_base_copper_thickness* | Valuelist | O | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1
*copper_foil_type* | Valuelist | O | O | O | The roughness of the copper foil. Can be either "S" (Standard), "L" (Low profile) or "V" (Very Low Profile)

### Flexible Conductive layer ("conductive_layer")
- specification -> summary (single)
- specification -> layers (multiple)
- profile -> all sections
- capability

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*count* | Integer| R/O | F | R | The number of conductive layers. Forbidden to use in the specification -> layers part. As a capability it needs to be a range represented as X-X
*minimum_track_width* | Integer | O | O | O | The minimum track width of conductors either on the specific layer (if in specification -> layer) or total
*minimum_internal_track_width* | Integer | O/F | O | O | The minimum track width of conductors in internal layers (can not be used in a stackup)
*minimum_external_track_width* | Integer | O/F | O | O | The minimum track width of conductors in external layers (can not be used in a stackup)
*minimum_spacing_width* | Integer | O | O | O | The minimum gap between two conductors either on the specific layer (if in specification -> layer) or total
*minimum_internal_spacing_width* | Integer | O/F | O | O | The minimum gap between two conductors on the internal layers (can not be used in a stackup)
*minimum_external_spacing_width* | Integer | O/F | O | O | The minimum gap between two conductors on the external layers (can not be used in a stackup)
*external_base_copper_thickness* | Valuelist | O | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1  
*internal_base_copper_thickness* | Valuelist | O | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer. Allowed values are: 5.1, 8.5, 12, 17.1, 25.7, 34.3, 68.6, 102.9, 137.2, 171.5, 205.7, 240, 342.9, 480.1
*copper_foil_type* | Valuelist | O | O | O | The roughness of the copper foil. Can be either "S" (Standard), "L" (Low profile) or "V" (Very Low Profile)

### Final Finish ("final_finish")
Aliases: "Surfacefinish", "Surface finish", "Coating", "finalfinish"

Can be listed in the following sections:
- specification -> summary (single)
- specification -> layers (multiple)
- profile -> all sections
- capability

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*finish* | Valuelist | O | O | O | The material/method/surface to be used in the finish. Pick from the valuelist "Final finishes"
*area* | Float | O | O | O | The area that the finish will cover, in square desimeter
*gold_thickness* | Float | O | O | O | The thickness of the finish in micrometer
*silver_thickness* | Float | O | O | O | The thickness of the finish in micrometer
*paladium_thickness* | Float | O | O | O | The thickness of the finish in micrometer
*tin_thickness* | Float | O | O | O | The thickness of the finish in micrometer
*nickel_thickness* | Float | O | O | O | The thickness of the finish in micrometer
*lead_free* | Boolean | O | O | O | The method must involve no lead used


### Soldermask ("soldermask")
Aliases: "solder mask".

Can be listed in the following sections:
- specification -> summary (single)
- specification -> layers (multiple)
- profile -> all sections
- capability

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*color* | List or Custom | O | O | R | This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*finish* | List | R | R | R | Can be `matte`, `semi-matte`, `glossy` or `any`. Required due to the "any" value
*material* | Material | O | O | R |  The material needs to listed in the materials section
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates soldermask presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates soldermask presence/capability at bottom

### Legend ("legend")
Alias: "silk screen" or "silkscreen", "ink", "ident".

Can be listed in the following sections:
- specification -> summary (single)
- specification -> layers (multiple)
- profile -> all sections
- capability

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*color* | List or Custom | R | R | R | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates legend presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates legend presence/capability at bottom
*state* | List | F | R | F | Only to be used in a profile. Can be either "allow" or "disallow"


### Stiffener ("stiffener")
Aliases: "Support"

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*size* | Float | O | O | O | The size of the stiffener should be specified in drawing
*placement* | Valuelist | O | O | O | Can be either "top" or "bottom", indicating if the stiffener is on top or bottom of the flexible layer
*thickness* | Float | O | O | O | The thickness of the stiffener
*material* | Material | O | O | R |  The material needs to listed in the materials section.

### CoverLay ("coverlay")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*total_thickness* | Integer | O | O | O | The number of...
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates coverlay presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates coverlay presence/capability at bottom


### Peelable mask ("peelable_mask")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*heating_operations* | Integer | O | O | O | The number of...
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at bottom

### Kapton tape ("kapton_tape")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates peelable mask presence/capability at bottom
*accept_equivalent* | Boolean | O | O | O | If alternative to DuPont™ Kapton® HN general-purpose film can be used

### Conductive Carbon Print ("conductive_carbon_print")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates carbon print presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates carbon print presence/capability at bottom

### Silver Print ("silver_print")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*top* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates silver print presence/capability at top
*bottom* | Boolean | O | O | O | Available when used in other sections than specification -> layers. Indicates silver print presence/capability at bottom

### Inner Packaging ("inner_packaging")
This describes how boards are packed together to be shipped. Part of IPC 1601 (4.2.2)

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*type_of_bag* | List | O | O | O | Possible values are `a`, `b`, `c`, `d` where `a` = Nylon/Foil/Polyethylene, `b` = TyvekTM/Foil/Polyethylene, `c` = Aluminized Polyester/Polyethylene and `d` = Clear Plastics/Polymers (non-metallic).
*hic* | Boolean | O | O | O | True to include a Humidity Indicator Card (HIC), False to not
*esd* | Boolean | O | O | O | True to indicate that packaging for ESD-sensitive required.
*silica* | Boolean | O | O | O | True to indicate that a silica bag is required
*desiccant* | Boolean | O | O | O | True to indicate that a desiccant material is required

### Board ("board")
The physical description of the board

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*size_x* | Float | O | F | F | The size of the board in the x-asis, measured in millimeters
*size_y* | Float | O | F | F | The size of the board in the y-asis, measured in millimeters
*thickness* | Float | O | F | F | The thickness of the board measured in millimeters

### Array ("array")
Aliases: "Panel", "Panelization", "Panelisation", "customer panel"

The physical description of the array of boards, used in assembly

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*size_x* | Float | O | O | O | The size of the array in the x-asis, measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum size of the array
*size_y* | Float | O | O | O | The size of the array in the y-asis, measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum size of the array
*boards_x* | Integer | O | O | O | The thickness of the board measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum number of boards in the X-direction.
*boards_y* | Integer | O | O | O | The thickness of the board measured in millimeters. When used in a Profile or Capability, it must specify a range (x-x) indicating the minimum and maximum number of boards in the X-direction.
*border_left* | Float | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_right* | Float | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_top* | Float | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_bottom* | Float | O | O | O | The size of the left side boarder between the edge and the baord measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*board_spacing_x* | Float | O | O | O | The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*boards_spacing_y* | Float | O | O | O | The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*fiducials_number* | Integer | O | O | F | The number of fiducials on the array.
*fiducials_size* | Float | O | O | F | The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size
*fiducials_shape* | Valuelist | O | O | F | The shape of the fiducials. Can be either "donut", "circle", "plus" or "diamond".
*breakaway_method* | Valuelist | O | O | O | The method of creation of the breakaways on the array. Possible values are "routing", "scoring" (alises includes "v-cut" and "v-grove") and "jump_scoring". If used in a Capability it can include several values separated with a comma
*mouse_bites* | Boolean | O | O | O | Indicates if there should be "mouse bites" to allow easy break away of the boards
*tooling_holes_number* | Integer | O | O | F | The number of tooling holes on the array.
*tooling_holes_size* | Float | O | O | F | The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size

### Mechanical Processes ("mechanical")
Mechanical processes

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*edge_bevelling* | Boolean | O | O | O | Edge bevelling present (if Specification), allowed (in Profile) or possible (in Capability)
*depth_routing_top* | Boolean | O | O | O | Depth Routing from the top present (if Specification), allowed (in Profile) or possible (in Capability)
*depth_routing_bottom* | Boolean | O | O | O | Depth Routing from the bottom present (if Specification), allowed (in Profile) or possible (in Capability)
*counterboring_top* | Boolean | O | O | O | Counterboring from the top present (if Specification), allowed (in Profile) or possible (in Capability)
*counterboring_bottom* | Boolean | O | O | O | Counterboring from the bottom present (if Specification), allowed (in Profile) or possible (in Capability)
*countersink_top* | Boolean | O | O | O | Countersink from the top present (if Specification), allowed (in Profile) or possible (in Capability)
*countersink_bottom* | Boolean | O | O | O | Countersink from the bottom present (if Specification), allowed (in Profile) or possible (in Capability)

### Markings ("markings")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*date_code* | String | O | O | F | Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".
*placement* | Valuelist | O | O | O | Placement of the markings. Possible values are "copper_top", "copper_bottom", "soldermask_top", "soldermask_bottom", "legend_top" or "legend_bottom". When used as a Capability, several can be listed separated by a comma
*manufacturer_identification* | Boolean | O | O | O | Manufacturer identification present (if Specification), allowed (in Profile) or possible (in Capability)
*standards* | Valuelist | O | O | O | Possible values are the ones listed in the subelement "Standards and Requirements" but typical will be "ul" and "rohs". Separate by comma.

### Standards and Requirements ("standards")
If the format is boolean and nothing is stated other than the name of the standard in the Decription column, it should be understood as follows: Are to be met (if Specification), required (in Profile) or possible (in Capability)

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*ul* | Boolean | O | O | F | Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material
*c_ul* | Boolean | O | O | F | Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material
*rohs* | Boolean | O | O | O | RoHS
*ul94* | Valuelist | O | O | O | Possible values are "None, "v_0", "v_1" or "v_2". If capability, several can be listed separated by a comma.
*esa* | Boolean | O | O | O | European Space Agency Use
*itar* | Boolean | O | O | O | ITAR
*defar* | Boolean | O | O | O | DEFAR
*mil_prf_55110* | Boolean | O | O | O | MIL-PRF-55110
*mil_prf_50884* | Boolean | O | O | O | MIL-PRF-5884
*mil_prf_31032* | Boolean | O | O | O | MIL-PRF-31032
*as9100* | Boolean | O | O | O | AS9100
*nadcap* | Boolean | O | O | O | NADCAP
*rw_en45545_2_2013* | Boolean | O | O | O | Railway Europe EN45545-2:2013
*rw_nf_f_16_101* | Boolean | O | O | O | Railway France NF F 16-101
*rw_uni_cei_11170_3* | Boolean | O | O | O | Railway Italy UNI CEI 11170-3
*rw_nfpa_130* | Boolean | O | O | O | Railway USA NFPA 130
*ipc_6012_class* | Valuelist | O | O | O | Requirements according to IPC 6012 class. Possible values are "1", "2", "3", "3A" (Automotive addendum), "3S" (Space and Military Avionics Addendum) or "3M" (Medical Addendum).
*ipc_6013_class* | Valuelist | O | O | O | Requirements according to IPC 6013 for flexible boards. Possible values are "1", "2", "3".
*ipc_6015* | Boolean | O | O | O | IPC-6015 Qualification and Performance Specification for Organic Multichip Module (MCM-L) Mounting and Interconnecting Structures
*ipc_6016* | Boolean | O | O | O | IPC-6016 Qualification and Performance Specification for High Density Interconnect (HDI) Layers or Boards
*ipc_6017* | Boolean | O | O | O | IPC-6017 Qualification and Performance Specification for PCBs w/ Embedded Passives
*ipc_6018* | Boolean | O | O | O | IPC-6018 Microwave End Product Board Inspection and Test


### Testing ("testing")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*netlist* | Boolean | O | O | O | 100% Netlist testing according to IPC-D-356
*allow_generate_netlist* | Boolean | O | O | O | Allow Netlist to be generated from Gerber or other file format if needed
*hipot* | Boolean | O | O | O | HiPot Test  (Dielectric Withstanding Voltage Test)
*impedance* | Valuelist | O | O | O | Possible values er "controlled", "calculated" or "follow_stackup"


### Country of Origin ("country_of_origin")
Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*iso_3166_1_alpha_3* | String | O | O | O | A three letter string representation of the Country of origin according too ISO 3166-1
*iso_3166_1_alpha_2* | String | O | O | O | A two letter string representation of the Country of origin according too ISO 3166-1
*nato_member* | Boolean | O | O | O | Indicates if the COO is a NATO member state (or needs to be if used as a profile)
*eu_member* | Boolean | O | O | O | Indicates if the COO is a European Union member state (or needs to be if used in a profile)

### Conflict resolution ("conflict_resolution")
If several sources of data is present, this hierarchy is to set how to solve conflicts. Please specify a number to indicate priority and avoid setting the same number twice.

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*order* | Integer | O | O | O | Information provided on order level
*oem_specification_sheet* | Integer | O | O | O |  Information provided from the OEM in a PDF or other document format
*assembly_specification_sheet* | Integer | O | O | O | Information provided from the assembly facility in a PDF or other document format
*drawing* | Integer | O | O | O | Information in a drawing (if present)
*odb* | Integer | O | O | O | Information in a ODB++ file
*gerber* | Integer | O | O | O | Information in a Gerber format file

#### Example
```
<conflict_resolution>
  <order>1</order>
  <oem_specification_sheet>2</oem_specification_sheet>
  <assembly_specification_sheet>3</assembly_specification_sheet>
  <drawing>4</drawing>
  <odb>5</odb>
  <gerber>6</gerber>
</conflict_resolution
```

## Custom elements

#### Colors

## Materials
### Soldermasks
A list of suggested soldermasks can be found in a separate file but feel free to define ones that are not found in that file. The generic ones includes below. Structure is as follows:

Data tag | Required | Format | Description
---------|----------|--------|-------------
*name* | Yes | String | The name of the Soldermask. Use the official name or some name as close to it as possible
*manufacturer* | No | String | The name of the manufacturer
*ipc-sm-840-class* | No | List | Can be either T or H
*link* | No | String | The link to some url that gives more information or a reference to the product

### Dielectric / Laminate

Data tag | Required | Format | Description
---------|----------|--------|-------------
*name* | Yes | String | The name of the Laminate. Use the official name or some name as close to it as possible
*manufacturer* | No | String | The name of the manufacturer of the material
*ipc-4101-sheet* | No | Integer | The reference sheet number of the IPC 4101 Standard.
*ipc-4103-sheet* | No | Integer | The reference sheet number of the IPC 4103 Standard.
*tg_min* | No | Integer | The minimum Glass Transition Temperature (Tg) required.
*tg_range_from* | No | Integer | The Glass Transition Temperature (Tg) range starts at
*tg_range_to* | No | Integer | The Glass Transition Temperature (Tg) range ands at
*td_min* | No | Integer | The minimum required temperature at which a base laminate material experiences an established percentage of weight loss using Thermograv imetric Analysis (TGA)
*td_range_from* | No | Integer | The Td range starts at
*td_range_to* | No | Integer | The Td range stops at
*halogen_free* | No | Boolean | Indicates the material is material free or is required to be.
*link* | No | String | The link to some url that gives more information or a reference to the product

### Stiffener
Data tag | Required | Format | Description
---------|----------|--------|-------------
*name* | Yes | String | The name of the stiffener. Use the official name or some name as close to it as possible
*manufacturer* | No | String | The name of the manufacturer of the material
*link* | No | String | The link to some url that gives more information or a reference to the product

## Value Lists

### Final finishes

Name | Description
-----|------------
c_bare_copper | AABUS
isn / immersion_tin | IPC-4554 Immersion Tin
iag / immersion_silver | IPC-4553 Immersion Silver
enepig | IPC-4556 ENEPIG
enig | IPC-4552 Immersion Gold
osp	| J-STD-003 Organic Solderability Preservative
ht_osp | J-STD-003 High Temperature OSP
g | ASTM-B-488 Gold for edge printed board connectors and areas not to be soldered
GS | J-STD-003 Gold Electroplate on areas to be soldered
t_fused	| J-STD-003 Electrodeposited Tin-Lead (fused)
tlu_unfused | J-STD-003 Electrodeposited Tin-Lead Unfused
dig | J-STD-003 Direct Immersion Gold (Solderable Surface)
gwb-1_ultrasonic | ASTM-B-488 Gold Electroplate for areas to be wire bonded (ultrasonic)
gwb-2-thermosonic | ASTM-B-488 Gold Electroplate for areas to be wire bonded (thermosonic)
s_hasl | J-STD-003_J-STD-006 Solder Coating over Bare Copper
lf_hasl | J-STD-003_J-STD-006 Lead-Free Solder Coating over Bare Copper
