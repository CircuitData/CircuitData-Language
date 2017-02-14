# openpcbXML
En open XML standard for communicating information needed for PCB manufacturability

## Structure of the XML
Within the root level (openpcbxml) everything is divided into five groups:
- specification
- profile
- capability
- custom
- materials

## Possible elements

### Soldermask

Data tag | Format | Description
---------|--------|-------------
*color* | List or Custom | This describes the color of the soldermask based on the name of the color; green, black, blue, red, white, yellow. If a specific color needs to be defined, this can be done with RGB or HEX in the `<custom><colors>` section.
*finish* | List | Can be `matte`, `semi-matte`, `glossy` or `any`
*material* | Material | The material needs to listed in the materials section

```
<soldermask>
  <color>green</color>
  <finish>any/matte/semi-matte/glossy</finish>
  <material></material>
</soldermask>
```


## Custom elements

#### Color


## Materials

### Soldermasks
  <ipc-sm-804-class>h/t</ipc-sm-804-class>
