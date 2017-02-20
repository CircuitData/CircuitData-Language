# openpcbXML
En open XML standard for communicating information needed for PCB manufacturability.

## Structure of the XML
Within the root level (openpcbxml) everything is divided into five groups and their subgroups:
- specification
  - summary (listed in any order, this sums up technology present)
  - layers (listed top-down, include at least one conductive layer to determin placement in stackup)
  - standards (listed in any order, these are the required standards to meet)
  - markings (listed in any order, these are the necessary markings)
  - dimensions (the physical dimensions of the board)
  - array (array (also called panel) specifications)
  - packaging
  - materials
- profile
  - defaults
  - enforced
  - restricted
- capability
  -
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
"O": Optional
"R": Required

## Possible elements
The name of the element as it is to be used in the XML is included behind the title within the parenthesis, e.g. "soldermask". When a table of possible elements is present, you will find the following headers:
"Data tag": The name of the elements
"Format": The format of the element (possible formats listed above)
"S": When used in a Specification part of the XML (see above for structure and abbreviations)
"P": When used in a Profile part of the XML (see above for structure and abbreviations)
"C": When used in a Capability part of the XML (see above for structure and abbreviations)

### Soldermask ("soldermask")
Can be listed in the following sections:
- specification -> summary (single)
- specification -> layers (multiple)
- profile -> all sections
- capability ->

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*color* | List or Custom | O | O | R | This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*finish* | List | R | R | R | Can be `matte`, `semi-matte`, `glossy` or `any`
*material* | Material | O | O | R |  The material needs to listed in the materials section

### Legend ("legend")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*color* | List or Custom | R | R | R | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.


### CoverLay ("coverlay")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*total_thickness* | Integer | O | O | O | The number of...


### Peelable mask ("peelable_mask")

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*heating_operations* | Integer | O | O | O | The number of...

### Kapton tape ("kapton_tape")

This can only be added as an item without any further specification:
`<kapton_tape></kapton_tape>`

### Conductive Carbon Print ("conductive_carbon_print")

This can only be added as an item without any further specification:
`<conductive_carbon_print></conductive_carbon_print>`

### Silver Print ("silver_print")

This can only be added as an item without any further specification:
`<silver_print></silver_print>`

### Inner Packaging ("inner_packaging")
This describes how boards are packed together to be shipped. Part of IPC 1601 (4.2.2)

Data tag | Format | S | P | C | Description
---------|--------|---|---|---|-------------
*type_of_bag* | List | O | O | O | Possible values are `a`, `b`, `c`, `d` where `a` = Nylon/Foil/Polyethylene, `b` = TyvekTM/Foil/Polyethylene, `c` = Aluminized Polyester/Polyethylene and `d` = Clear Plastics/Polymers (non-metallic).
*hic* | Boolean | O | O | O | True to include a Humidity Indicator Card (HIC), False to not
*esd* | Boolean | O | O | O | True to indicate that packaging for ESD-sensitive required.
*silica* | Boolean | O | O | O | True to indicate that a silica bag is required
*desiccant* | Boolean | O | O | O | True to indicate that a desiccant material is required


## Custom elements

#### Colors

## Materials
### Soldermasks
A list of suggested soldermasks can be found in a separate file but feel free to define ones that are not found in that file. The generic ones includes below. Structure is as follows:

Data tag | Required | Format | Description
---------|----------|--------|-------------
*name* | Yes | String | The name of the Soldermask. Use the official name or some name as close to it as possible
*ipc-sm-840-class* | No | List | Can be either T or H
*link* | No | String | The link to some url that gives more information or a reference to the product

##### Example
```
<materials>
  <soldermasks>
     <standard-lpi>
       <name>Standard LPI</name>
       <ipc-sm-840-class>T</ipc-sm-840-class>
     </standard-lpi>
  </soldermasks>
</materials>
```

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
