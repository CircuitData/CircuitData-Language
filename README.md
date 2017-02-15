# openpcbXML
En open XML standard for communicating information needed for PCB manufacturability

## Data formats
- Percentage - Denotes a percentage - all percentages are expressed as percent out of 100- for example 10.4% is written as "10.4" and not "0.104"
- List - The data has only a fixed number of values that are selected from the list in the description table for the tag.  These items are case sensitive, and no other values are allowed.
- Text - The data is free format text.  For multiline entries, line breaks will be preserved where possible and the text may be truncated on import if the text is too long for the importing program to store.  Multiline entries may be split with either a newline (Unix format) or a carriage return – newline combination (DOS format).  Importing programs should accept either.
- Boolean - May be either TRUE or FALSE, with TRUE and FALSE in capitals.  A default value should be specified for optional fields - the default is used if the value is not present.
- Integer - An integer number with no decimal point.  May include negative values - examples include ...-3, -2, -1, 0, 1, 2, 3,...
- Floating Point - A floating point number, usually expressed in its simplest form with a decimal point as in "1.2", "0.004", etc...  Programs shall endeavor to store as many significant digits as possible to avoid truncating or losing small values.


## Structure of the XML
Within the root level (openpcbxml) everything is divided into five groups and their subgroups:
- specification
  - layers (listed top-down, include at least one conductive layer to determin placement in stackup)
  - standards (listed in any order, these are the required standards to meet)
  - markings (listed in any order, these are the necessary markings)
  - dimensions (the physical dimensions of the board)
  - Array (array (also called panel) specifications)
  - packaging
- profile
- capability
- custom

## Possible elements
The name of the element as it is to be used in the XML is included behind the title within the parenthesis, e.g. "soldermask".

### Soldermask ("soldermask")

Data tag | Format | Description
---------|--------|-------------
*color* | List or Custom | This describes the color based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*finish* | List | Can be `matte`, `semi-matte`, `glossy` or `any`
*material* | Material | The material needs to listed in the materials section

##### Example 1
Where just one top soldermask layer is listed as a specification, and standard LPI is the material
```
<specification>
  <layers>
    <soldermask>
      <color>green</color>
      <finish>any</finish>
      <material>standard-lpi</material>
    </soldermask>
    <conductive></conductive>
  </layers>
  <materials>
    <soldermasks>
       <standard-lpi>
         <name>Standard LPI</name>
         <ipc-sm-840-class>T</ipc-sm-840-class>
       </standard-lpi>
    </soldermasks>
  </materials>
</specification>

```
### Legend ("legend")

Data tag | Required | Format | Description
---------|----------|--------|-------------
*color* | Yes | List or Custom | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.

##### Example 1
One top legend layer above a soldermask is listed as a specification.
```
<specification>
  <layers>
    <legend>
      <color>white</color>
    </legend>
    <soldermask>
      <color>green</color>
      <finish>any</finish>
      <material>standard-lpi</material>
    </soldermask>
    <conductive>...</conductive>
  </layers>
</specification>
```

### CoverLay ("coverlay")
Data tag | Required |Format | Description
---------|----------|-------|-------------
*total_thickness* | No | Integer | The number of...


### Peelable mask ("peelable_mask")

Data tag | Required |Format | Description
---------|----------|-------|-------------
*heating_operations* | No | Integer | The number of...

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

Data tag |  Required |Format | Description
---------|-----------|-------|-------------
*type_of_bag* | No | List | Possible values are `a`, `b`, `c`, `d` where `a` = Nylon/Foil/Polyethylene, `b` = TyvekTM/Foil/Polyethylene, `c` = Aluminized Polyester/Polyethylene and `d` = Clear Plastics/Polymers (non-metallic).
*hic* | No | Boolean | True to include a Humidity Indicator Card (HIC), False to not
*esd* | No | Boolean | True to indicate that packaging for ESD-sensitive required.
*silica* | No | Boolean | True to indicate that a silica bag is required
*desiccant* | No | Boolean | True to indicate that a desiccant material is required




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
*min_tg* | No | Integer | The minimum Glass Transition Temperature (Tg) required.
*min_td* | No | Integer | The minimum required temperature at which a base laminate material experiences an established percentage of weight loss using Thermograv imetric Analysis (TGA)
*link* | No | String | The link to some url that gives more information or a reference to the product
