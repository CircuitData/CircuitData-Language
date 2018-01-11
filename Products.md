# Structure for specifications
We divide the specifications into a few major groups:
* Sections
* Layers (also including stackup information)
* Processes
* Tolerances
* Logistics
* Administrative

## Sections
To understand sections, you should read [this document](https://www.circuitdata.org/t/18phm5).
The sections part allows you to divide the product you are describing into several sections and then allow the layers to appear in one or more of them. A single section product needs to contain at least one section. Liek this example:
```
"sections": [
  {
       "name": "rigid1",
       "in_x": [1],
       "in_y": [1],
       "mm2": 400
   }
]
```

## Layers
Layers include everything which is part of the finished product (could be a PCB). It is not limited by the traditional convention of a "stack up" but will also contain layers like a peelable mask. An example of one conductive layer in the structure would be:
```
"layers": [
  {
    "order": 1,
    "name": "conductive_layer_1",
    "function": "conductive",
    "flexible": false,
    "materials": ["copper"],
    "sections": ["main_rigid"],
    "thickness": 34.8,
    "tolerance_minus": 0.1,
    "tolerance_pluss": 0.1,
    "coverage": 34,
    "attributes": {
      "minimum_track_width": 0.135,
      "minimum_spacing_width": 0.15,
      "function": "signal",
      "polarity": "positive"
    }
  }
]
```
### How to describe layers
Potential tags are:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| order         | Order of the layer as seen in a cross section and counted from above | integer | None | Yes |
| name          | A given name for the layer. Must be unique amongst the layers. Can be any string without spaces | string | None | Yes |
| function      | The function of layer. [See the list of potential functions below](#layer-functions-and-their-attributes) | integer | None | Yes |
| flexible      | True or false to indicate if this layer is flexible or not | boolean | None | No - default is "False" |
| materials     | An array of materials that appear in the materials element. There can be more than one | Array of String | None | Yes |
| sections      | An array of the sections where the layer appears (use the name of the section) | Array of strings | None | Yes |
| thickness     | The thickness of the layer in micrometers | number | micrometers | No |
| tolerance_minus | Allowed deviation of thickness on the minus side | number | micrometers | No |
| tolerance_plus | Allowed deviation of thickness on the plus side | number | micrometers | No |
| sub_material_thickness | Thickness of individual components in a multicomponent layer. Read more [here](#thickness-of-individual-components) | object | None | No |
| coverage      | How many percent of the section is covered by the layer (related to the mm2 value) | number | percent | No - default is 100 |
| layer_attributes | A object containing attributes to further describe the layer. See potential attributes under each [layer type](#layer-functions-and-their-attributes) | object | None | No |

### Layer functions and their attributes
Potential values are:
* none
* conductive
  * Potential attributes:
    * minimum_track_width ( type is "number". Sets the minimum track. UoM is "micrometers" )
    * minimum_spacing_width ( type is "number". Sets the minimum gap. UoM is "micrometers")
    * conductive_function ( type is "string". Select either "signal", "plane" or "mixed" )
    * polarity ( type is "string". Select either "positive" or "negative" )    
* dielectric
* soldermask
  * Potential attributes:
    * color ( type is "string". Se the color section for more information )
* stiffener
* plating
* adhesive
* thermal
* legend
  * Potential attributes:
    * color ( type is "string". Ses the color section for more information )
* final_finish
* peelable_tape
* peelable_mask
  * Potential attributes:
    * heating_operations ( type is "integer". Describes the minimum number of heating operations that the mask must withstand )


### Thickess of individual components
Some materials, such as an ENIG final finish are made up from two or more material. In such cases, it can be useful to be able to specify the individual materials minimum and/or maximum thickness. You can do this in CircuitData by adding an object under the "sub_material_thickness" object. The name of the object should represent the material itself, e.g. "gold" and then you can place a "minimum" and or "maximum" object there with the type of "number" and UoM of micrometers. Example:
```
"layers": [
  {
    "order": 1,
    "name": "top_final_finish",
    "function": "final_finish",
    "flexible": false,
    "materials": ["ENIG"],
    "sections": ["main_rigid"],
    "coverage": 100,
    "sub_material_thickness": {
      "gold": {
        "minimum": 1.5
      }
    }
  }
]
```
## Processes
Processes include everything which is done to one or more layers. An example of one via (hole) process could be:
```
"processes": [
  {
    "function": "via",
    "attributes": {
      "number_of_vias": 60,
      "type": through,
      "plated": false,
      "size": 0.15,
      "layer_start": "conductive_layer_1",
      "layer_stop": "conductive_layer_4",
      "protection": "type4a"
    }
  }
]
```
### How to describe processes
Potential tags are:

| Tags          | Description           | [Type](#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:
| function      | The function of process. [See the list of potential processes below](#process-functions-and-their-attributes) | integer | None | Yes |
| layer_attributes | A object containing attributes to further describe the layer. See potential attributes under each [layer type](#layer-functions-and-their-attributes) | object | None | No |

### Process functions and their attributes
Potential values are:
* edge_bevelling
* depth_routing
* counterboring
* countersink
* punching
* plating
* plated_edges
* plated_slots
* plated_castellated_holes
* coin_attachment
* via
  * Potential attributes:
    * number_of_vias ( type is "integer". Describes the number of holes/vias in the process )
    * type ( type is "string". Describes the type of via. Choices are "through", "blind", "buried", "back_drill")
    * plated ( type is "boolean". True to indicate plated vias )
    * size ( type is "number". The size of the vias in micrometers )
    * layer_start ( type is "string". Must refer to the name of a layer in the layers section )
    * layer_stop ( type is "string". Must refer to the name of a layer in the layers section )
    * depth ( type is "number". Indicates the depth of the via in micrometers )
    * method ( type is "string". How the via is made. Can be either "routing, "drilling" or "laser", where default is "drilling" )
    * minimum_designed_annular_ring ( type is "number". The minimum designed annular ring in micrometers )
    * press_fit ( type is "boolean". True if the via is for press fit )
    * copper_filled ( type is "boolean". True if the via is to be copper filled )
    * staggered ( type is "boolean". True if the vias are staggered )
    * stacked ( type is "boolean". True if the vias are staggered )
    * alivh ( type is "boolean". True if ALIVH vias )
