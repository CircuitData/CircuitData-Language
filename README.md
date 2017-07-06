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
Current version is 0.5. This should stated in every section directly below the "printed_circuits_fabrication_data" element in an element called "version".

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

### Stackup ("stackup")
Aliases: "stack-up", "buildup", "build-up"
The stackup of the board: Free stackup (supplier to choose), specified in a separate file or specified in this file. Can also include the stackup itself.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*specification_level* | O | F | F | F | O | The stack up of this board
*file_name* | O | O | O | F | O | The URI of the file that specifies the stackup. Either as a path witin a project compressed file (ZIP) or as a link
*specified* | O | F | F | F | O | The container where the elements describing the stackup should be placed. All elements under object must contain the "layer_order" tags to set the order of the layer. They should also contain the "layer_name" tag to set the descriptive name of the layer

### Rigid Conductive layer ("rigid_conductive_layer")
The layers of rigid conductive material (usually copper)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*count* | O | F | F | F | O | The number of conductive layers.
*minimum_internal_track_width* | O | F | F | O | O | The minimum nominal width of conductors on internal/unplated layers (minimum track).
*minimum_external_track_width* | O | F | F | O | O | The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
*minimum_internal_spacing_width* | O | F | F | O | O | The minimum gap between two conductors on the internal layers.
*minimum_external_spacing_width* | O | F | F | O | O | The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
*external_base_copper_thickness* | O | F | F | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer.
*internal_base_copper_thickness* | O | F | F | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer.
*copper_foil_roughness* | O | O | O | O | O | The roughness of the copper foil.
*copper_coverage_average* | O | F | F | F | O | The average copper coverage of the board. UoM is percentage

### Flexible Conductive layer ("flexible_conductive_layer")
The layers of flexible conductive material (usually copper)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*count* | O | F | F | F | O | The number of conductive layers.
*minimum_internal_track_width* | O | F | F | O | O | The minimum nominal width of conductors on internal/unplated layers (minimum track).
*minimum_external_track_width* | O | F | F | O | O | The minimum nominal width of conductors on external/plated layers (minimum track). If only only one minimum track is present, is should be here.
*minimum_internal_spacing_width* | O | F | F | O | O | The minimum gap between two conductors on the internal layers.
*minimum_external_spacing_width* | O | F | F | O | O | The minimum gap between two conductors on the external layers. If only one minimum gap is present, is should be here.
*external_base_copper_thickness* | O | F | F | O | O | Finished base copper thickness following IPC Class on the up to two external layers in micrometer.
*internal_base_copper_thickness* | O | F | F | O | O | Finished base copper thickness following IPC Class on the internal layers in micrometer.
*copper_foil_roughness* | O | O | O | O | O | The roughness of the copper foil.
*copper_foil_type* | O | O | O | O | O | The The type of the copper foil
*copper_coverage_average* | O | F | F | F | O | The average copper coverage of the board. UoM is percentage

### Final Finish ("final_finish")
Aliases: "Surfacefinish", "Surface finish", "Coating", "finalfinish", "Solderable finish", "Solderable coating"
A list of final finishes, can be more than one. E.g. selective finish ENIG and OSP.
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*finish* | O | O | O | O | O | The material/method/surface to be used in the finish.
*area* | O | F | F | F | O | The area that the finish will cover, in square decimeter.
*thickness* | O | O | O | F | O | The thickness of the finish in micrometer.
*gold_thickness* | O | O | O | F | O | The thickness of the gold finish in micrometer.
*silver_thickness* | O | O | O | F | O | The thickness of silver the finish in micrometer.
*paladium_thickness* | O | O | O | F | O | The thickness of the paladium finish in micrometer.
*tin_thickness* | O | O | O | F | O | The thickness of the tin finish in micrometer.
*nickel_thickness* | O | O | O | F | O | The thickness of the nickel finish in micrometer.

### Dielectric ("dielectric")
Aliases: "Laminate"
A list of one of more materials by name and referencing a material listed in the materials section
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | O | O | O | O | O | The name of a material that appears in the materials section

### Soldermask ("soldermask")
Aliases: "solder mask", "sm", "solder resist", "green mask"
A list of final soldermasks, can be more than one
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*color* | O | O | O | O | O | This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.
*finish* | O | O | O | O | O | The finish of the soldermask.
*min_thickness* | O | O | O | F | O | The minimum thickness of the soldermask.
*max_thickness* | O | O | O | F | O | The maximum thickness of the soldermask.
*material* | O | O | O | O | O | The name of a material that appears in the materials section
*top* | O | O | O | O | O | Indicates soldermask presence/capability at top
*bottom* | O | O | O | O | O | Indicates soldermask presence/capability at bottom

### Legend ("legend")
Aliases: "silk screen", "silkscreen", "ink", "ident"
The legend to be used on the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*color* | O | O | O | O | O | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done custom -> colors section.
*top* | O | O | O | O | O | Indicates legend presence/capability at top
*bottom* | O | O | O | O | O | Indicates legend presence/capability at bottom

### Stiffener ("stiffener")
Aliases: "support"
Stiffener in flexible boards

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size* | O | O | O | O | O | The size of the stiffener should be specified in drawing
*placement* | O | O | O | O | O | Indicating if the stiffener is on top or bottom of the flexible layer.
*thickness* | O | O | O | F | O | The thickness of the stiffener
*material* | O | O | O | O | O | The name of a material that appears in the materials section

### CoverLay ("coverlay")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*total_thickness* | O | O | O | O | O | The total thickness of the coverlay
*top* | O | O | O | O | O | Indicates coverlay presence/capability at top
*bottom* | O | O | O | O | O | Indicates coverlay presence/capability at bottom

### Peelable mask ("peelable_mask")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*heating_operations* | O | O | O | O | O | 
*top* | O | O | O | O | O | Indicates peelable mask presence/capability at top
*bottom* | O | O | O | O | O | Indicates peelable mask presence/capability at bottom

### Kapton tape ("kapton_tape")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*accept_equivalent* | O | O | O | O | O | If alternative to DuPont™ Kapton® HN general-purpose film can be used
*top* | O | O | O | O | O | Indicates peelable mask presence/capability at top
*bottom* | O | O | O | O | O | Indicates peelable mask presence/capability at bottom

### Conductive Carbon Print ("conductive_carbon_print")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | O | O | O | O | O | Indicates Conductive Carbon Print presence/capability at top
*bottom* | O | O | O | O | O | Indicates Conductive Carbon Print presence/capability at bottom

### Silver Print ("silver_print")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*top* | O | O | O | O | O | Indicates silver print presence/capability at top
*bottom* | O | O | O | O | O | Indicates silver print presence/capability at bottom

### Inner Packaging ("inner_packaging")
This describes how boards are packed together to be shipped. Part of IPC 1601 (4.2.2)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type_of_bag* | O | O | O | O | O | The material of the bag to be used
*hic* | O | O | O | O | O | True to include a Humidity Indicator Card (HIC), False to not
*esd* | O | O | O | O | O | True to indicate that packaging for ESD-sensitive required.
*silica* | O | O | O | O | O | True to indicate that a silica bag is required.
*desiccant* | O | O | O | O | O | True to indicate that a desiccant material is required.
*vacuum* | O | O | O | O | O | True to indicate that vacuum is needed for shrinkage - no heat rap or shrink rap allowed.

### Via Protection ("via_protection")
The via/hole protection according to IPC 4761

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type_1* | O | O | O | O | O | A via with a dry film mask material applied bridging over the via wherein no additional materials are in the hole.
*type_2* | O | O | O | O | O | A Type I via with a secondary covering of mask material applied over the tented via.
*type_3* | O | O | O | O | O | A via with material applied allowing partial penetration into the via. The plug material may be applied from one or both sides.
*type_4a* | O | O | O | O | O | A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*type_4b* | O | O | O | O | O | A Type III via with a secondary covering of material applied over the via. The plug material may be applied from one or both sides.
*type_5* | O | O | O | O | O | A via with material applied into the via targeting a full penetration and encapsulation of the hole.
*type_6a* | O | O | O | O | O | A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*type_6b* | O | O | O | O | O | A Type V via with a secondary covering of material (liquid or dry film soldermask) applied over the via. The plug material may be applied from one or both sides.
*type_7* | O | O | O | O | O | A Type V via with a secondary metallized coating covering the via. The metallization is on both sides.

### Board ("board")
The physical description of the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size_x* | O | F | F | O | O | The size of the board in the x-asis, measured in millimeters
*size_y* | O | F | F | O | O | The size of the board in the y-asis, measured in millimeters
*thickness* | O | O | O | O | O | The thickness of the board measured in millimeters

### Array ("array")
Aliases: "Panel", "Panelization", "Panelisation", "customer panel"
The physical description of the array of boards, used in assembly

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*size_x* | O | F | F | O | O | The size of the array in the x-asis, measured in millimeters
*size_y* | O | F | F | O | O | The size of the array in the y-asis, measured in millimeters
*boards_x* | O | F | F | O | O | Number of boards in the panel in the x-direction.
*boards_y* | O | F | F | O | O | Number of boards in the panel in the y-direction.
*boards_total* | O | F | F | O | O | Number total number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used.
*border_left* | O | O | O | O | O | The size of the left side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_right* | O | O | O | O | O | The size of the right side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_top* | O | O | O | O | O | The size of the top side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*border_bottom* | O | O | O | O | O | The size of the bottom side boarder between the edge and the board measured in millimeters. When used in a Profile or Capability, it must specify minimum needed boarder
*board_spacing_x* | O | O | O | O | O | The size of the space between the boards in the x-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*board_spacing_y* | O | O | O | O | O | The size of the space between the boards in the y-direction measured in millimeters. When used in a Profile or Capability, it must specify the minimum needed space
*fiducials_number* | O | O | O | F | O | The number of fiducials on the array.
*fiducials_size* | O | O | O | O | O | The size of the fiducials measured in millimeters. If used in a Profile, it is the minimum needed size
*fiducials_shape* | O | O | O | O | O | The shape of the fiducials.
*breakaway_method* | O | O | O | O | O | The method of creation of the breakaways on the array
*mouse_bites* | O | O | O | O | O | Indicates if there should be "mouse bites" to allow easy break away of the boards
*tooling_holes_number* | O | O | O | O | O | The number of tooling holes on the array.
*tooling_holes_size* | O | O | O | O | O | The size of the tooling holes measured in millimeters. If used in a Profile, it is the minimum needed size.

### Mechanical Processes ("mechanical")
Mechanical processes in the manufacturing

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*edge_bevelling* | O | O | O | O | O | Edge bevelling present.
*depth_routing_top* | O | O | O | O | O | Depth Routing from the top present
*depth_routing_bottom* | O | O | O | O | O | Depth Routing from the bottom present.
*counterboring_top* | O | O | O | O | O | Counterboring from the top present.
*counterboring_bottom* | O | O | O | O | O | Counterboring from the bottom present.
*countersink_top* | O | O | O | O | O | Countersink from the top present.
*countersink_bottom* | O | O | O | O | O | Countersink from the bottom present.

### Markings ("markings")
Physical markings on the board

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*date_code* | O | O | O | F | O | Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE".
*placement* | O | O | O | O | O | Placement of the markings.
*manufacturer_identification* | O | O | O | O | O | Manufacturer identification present.
*standards* | O | O | O | O | O | Possible values are the ones listed in the subelement "Standards and Requirements" but typical will be "ul" and "rohs". Separate by comma.

### Standards and Requirements ("standards")
If the format is boolean and nothing is stated other than the name of the standard in the Decription column, it should be understood as follows: Are to be met (if Specification), required (in Profile) or possible (in Capability)

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*ul* | O | O | O | O | O | Indicating if UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
*c_ul* | O | O | O | O | O | Indicating if Canadian UL is required for the board. Can not be used as a capability, as this will be indicated on each material.
*rohs* | O | O | O | O | O | RoHS.
*ul94* | O | O | O | O | O | Counterboring from the top present.
*esa* | O | O | O | O | O | European Space Agency Use.
*itar* | O | O | O | O | O | US ITAR.
*dfars* | O | O | O | O | O | US DFARS.
*mil_prf_55110* | O | O | O | O | O | MIL-PRF-55110.
*mil_prf_50884* | O | O | O | O | O | MIL-PRF-5884.
*mil_prf_31032* | O | O | O | O | O | MIL-PRF-31032.
*as9100* | O | O | O | O | O | AS9100.
*nadcap* | O | O | O | O | O | NADCAP.
*rw_en45545_2_2013* | O | O | O | O | O | Railway Europe EN45545-2:2013.
*rw_nf_f_16_101* | O | O | O | O | O | Railway France NF F 16-101.
*rw_uni_cei_11170_3* | O | O | O | O | O | Railway Italy UNI CEI 11170-3.
*rw_nfpa_130* | O | O | O | O | O | Railway USA NFPA 130.
*ipc_6010_class* | O | O | O | O | O | According to Table 4-2 /4-3.
*ipc_6010_compliance_level* | O | O | O | O | O | 
*ipc_6010_copper_plating_thickness_level* | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6010_annular_ring_level* | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6010_conductor_spacing_level* | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add conductor spacing demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6010_conductor_width_level* | O | O | O | O | O | Used either if ipc_6010_class is set to 2 and you want to add conductor width demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2.
*ipc_6012_class* | O | O | O | O | O | Requirements according to IPC 6012 class.
*ipc_6013_class* | O | O | O | O | O | Requirements according to IPC 6013 for flexible or rigid-flex boards.
*ipc_6018* | O | O | O | O | O | IPC-6018 Microwave End Product Board Inspection and Test.

### Testing ("testing")

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*netlist* | O | O | O | O | O | 100% Netlist testing according to IPC-D-356, ODB++ or IPC2581.
*allow_generate_netlist* | O | O | O | O | O | Allow Netlist to be generated from Gerber or other file format if needed.
*hipot* | O | O | O | O | O |  HiPot Test (Dielectric Withstanding Voltage Test).
*4_wire* | O | O | O | O | O | Use 4 wired test
*ist* | O | O | O | O | O | Use IST testing.
*impedance* | O | O | O | O | O | 

### Country of Origin ("country_of_origin")
Country of Origin is the country where the Printed Circuit Board is manufactured.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*iso_3166_1_alpha_3* | O | O | O | O | O | A three letter string representation of the Country of origin according too ISO 3166-1.
*iso_3166_1_alpha_2* | O | O | O | O | O | A two letter string representation of the Country of origin according too ISO 3166-1.
*nato_member* | O | O | O | O | O | Indicates if the COO is a NATO member state
*eu_member* | O | O | O | O | O | Indicates if the COO is a European Union member state.

### Conflict resolution ("conflict_resolution")
If several sources of data is present, this hierarchy is to set how to solve conflicts. Please specify a number to indicate priority and avoid setting the same number twice.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*order* | O | O | O | F | O | Information provided on order level
*oem_specification_sheet* | O | O | O | F | O | Information provided from the OEM in a PDF or other document format
*assembly_specification_sheet* | O | O | O | F | O | Information provided from the assembly facility in a PDF or other document format
*drawing* | O | O | O | F | O | Information in a drawing (if present)
*ipc2581* | O | O | O | F | O | Information in an IPC-2581 file
*odb* | O | O | O | F | O |  Information in a ODB++ file.
*gerber* | O | O | O | F | O | Information in a Gerber format file

### Holes ("holes")
One for each holes process, or at least one that sums up the minimum requirements
This element is a list and can contain several items

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*number* | O | F | F | F | O | The number of holes total or in this process.
*type* | O | F | F | F | O | The type of holes.
*plated* | O | O | O | O | O | True if the holes are plated.
*size* | O | F | F | F | O | The size of the hole in micrometers. Can be considered the minimum hole size if only one holes element present in the list.
*layer_start* | O | F | F | F | O | The layer where the hole starts, counted from the top, where top layer is 1.
*layer_stop* | O | F | F | F | O | The layer where the hole stops, counted from the top, where top layer is 1.
*depth* | O | F | F | F | O | The depth of the hole in micrometer.
*method* | O | F | F | F | O | Can be either "routing" or "drilling", where drilling is default
*minimum_designed_annular_ring* | O | F | F | F | O |  The minimum designed annular ring in micrometers.

### Allowed Modifications ("allowed_modifications")
Changes/fabrication decisions that are allowed to make to the files provided.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*dead_pad_removal* | O | O | O | O | O | Non Functioning Pad removal.
*add_copper_balancing* | O | O | O | O | O | Adding copper balancing pattern
*add_copper_balancing_on_array* | O | O | O | O | O | Adding copper balancing pattern on array/panel frame.
*add_tear_drops* | O | O | O | O | O | Adding Tear Drops.

### Additional Requirements ("additional_requirements")
This section is for all requirements that still has not been adapted to the standard or needs to be stated as a comment. It allows you to specify custom elements that should be considered as part of the specification. You specify the value here and then need to create a separate element for it in the custom -> additional section. Multiple elements allowed - to be added as a list.

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*any_name* | O | F | F | F | O | Must have a similar element in the custom -> additional


## Custom elements

### Colors
Colors can be defined by hex, rgb, cmyk or name. Name of the color present here can be references in the other elements

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*type* | O | F | F | F | O | How the color is declared
*value* | O | F | F | F | O | If type is hex, the value needs to be a "#" + 6 hexadecimals (e.g. "#FFFFFF"). for "rgb" the format is "rgb(0, 255, 255)", for "cmyk" the format is "cmyk(100%, 0%, 0%, 0%)". The name is just a string.


### Materials
#### Soldermasks
Materials used as soldermask

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | O | O | O | O | O | The name of the Soldermask. Use the official name or some name as close to it as possible
*manufacturer* | O | O | O | O | O | The name of the manufacturer
*ipc-sm-840-class* | O | O | O | O | O | Soldermask to meet IPC SM 840 Class.
*link* | O | O | O | O | O | The link to some url that gives more information or a reference to the product.

#### Dielectrics
Materials used as dielectrics/laminates

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | O | O | O | O | O | The name of the Laminate. Use the official name or some name as close to it as possible.
*manufacturer* | O | O | O | O | O | The name of the manufacturer
*ipc_4101_sheet* | O | O | O | O | O | The reference sheet number of the IPC 4101 Standard.
*ipc_41013_sheet* | O | O | O | O | O | The reference sheet number of the IPC 4103 Standard.
*tg_min* | O | O | O | O | O | The minimum Glass Transition Temperature (Tg) required.
*tg_range_from* | O | O | O | O | O | The Glass Transition Temperature (Tg) range starts at.
*tg_range_to* | O | O | O | O | O | The Glass Transition Temperature (Tg) range ands at.
*td_min* | O | O | O | O | O | The minimum required temperature at which a base laminate material experiences an established percentage of weight loss using Thermograv imetric Analysis (TGA).
*td_range_from* | O | O | O | O | O | The Td range starts at.
*td_range_to* | O | O | O | O | O | The Td range stops at.
*halogen_free* | O | O | O | O | O | Indicates the material is material free or is required to be
*rw_en45545_2_2013* | O | O | O | O | O | Railway Europe EN45545-2:2013 compatible
*rw_nf_f_16_101* | O | O | O | O | O | Railway France NF F 16-101 compatible
*rw_uni_cei_11170_3* | O | O | O | O | O | Railway Italy UNI CEI 11170-3 compatible.
*rw_nfpa_130* | O | O | O | O | O | Railway USA NFPA 130 compatible.
*ul* | O | O | O | O | O | UL compatible.
*link* | O | O | O | O | O | The link to some url that gives more information or a reference to the product.

#### Stiffeners
The materials to be used as stiffener

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*name* | O | O | O | O | O | The name of the Soldermask. Use the official name or some name as close to it as possible
*manufacturer* | O | O | O | O | O | The name of the manufacturer
*link* | O | O | O | O | O | The link to some url that gives more information or a reference to the product.


## Additional elements

Must have a similar element in specification -> additional_requirements

Data tag | Format | P | PD | PE | PR | C | Description
---------|--------|---|----|----|----|---|--------------
*description* | O | F | F | F | O | The description of the additional requirement or comment
