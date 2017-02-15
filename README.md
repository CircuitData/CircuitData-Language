# openpcbXML
En open XML standard for communicating information needed for PCB manufacturability

## Data formats
- List
- Boolean

## Structure of the XML
Within the root level (openpcbxml) everything is divided into five groups:
- specification
- profile
- capability
- custom

### Specifications
Specifications are divided into new subsections
- layers
- standards
- markings
- dimensions
- Array (panel)
- packaging

#### Layers
Layers are always listed top down for machine readability. There needs to be one conductive layer defined at the very least, so that placement on top or bottom can be determined.

#### Standards
Listed in any order, these are the required standards to meet.

#### Markings
Listed in any order, these are the necessary markings.

#### Dimensions
The physical dimensions of the board

#### Array
The description of the array/panel

## Possible elements

### Soldermask

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
    <conductive>...</conductive>
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
### Legend

Data tag | Format | Description
---------|--------|-------------
*color* | List or Custom | This describes the color based on the name of the color; white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.

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

### Inner Packaging
This describes how boards are packed together to be shipped. Part if IPC 1601 (4.2.2)

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
