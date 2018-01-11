# Structure for specifications
We divide the specifications into a few major groups:
* Sections
* Layers (also including stackup information)
* Processes
* Tolerances
* Logistical
* Configuration

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
The "layers" element type is an "array". Layers include everything which is part of the finished product (could be a PCB). It is not limited by the traditional convention of a "stack up" but will also contain layers like a peelable mask. An example of one conductive layer in the structure would be:
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
* hard_gold
  * Potential attributes
    * placement ( type is "string". Either "selective_pads" or "edge_connectors" )


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
The "processes" element type is an "array". Processes include everything which is done to one or more layers. An example of one via (hole) process could be:
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

## Metrics
The "metrics" element type is an "object" and can have the following sub-objects:
### Board
Boards are one PCB. The following potential tags are available:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| size_x | The size of the board in the X-axis | Number | millimeters | Yes |
| size_y | The size of the board in the Y-axis | Number | millimeters | Yes |
| thickness | The finished thickness of the board | Number | millimeters | Yes |

### Array
Array (or custom panel) describes the panel that contains several boards. The following potential tags are available:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| size_x | The size of the array in the X-axis | Number | millimeters | Yes |
| size_y | The size of the array in the Y-axis | Number | millimeters | Yes |
| boards_x | The number of boards in the array in the X-axis | Integer | None | No |
| boards_y | The number of boards in the array in the Y-axis | Integer | None | No |
| boards_total | Total number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used | Integer | None | No |
| border_left | The size of the left side boarder between the edge and the board  | Number | millimeters | No |
| border_right | The size of the right side boarder between the edge and the board  | Number | millimeters | No |
| border_top | The size of the top side boarder between the edge and the board  | Number | millimeters | No |
| border_bottom | The size of the bottom side boarder between the edge and the board  | Number | millimeters | No |
| board_spacing_x | The size of the space between the boards in the x-direction | Number | millimeters | No |
| board_spacing_y | The size of the space between the boards in the y-direction | Number | millimeters | No |
| fiducials_number | The number of fiducials on the array | Integer | None | No |
| fiducials_size | The size of the fiducials | Number | millimeters | No |
| fiducials_shape | The shape of the fiducials. Potential values are "donut", "circle", "plus" and "diamond" | String | None | No |
| breakaway_method | The method of creation of the breakaways on the array. Potential values are "routing", "scoring", "v-cut", "v-grove", "jump_scoring" | String | None | No |
| mouse_bites | True if there should be "mouse bites" to allow easy break away of the boards | Boolean | None | No |
| tooling_holes_number | The number of tooling holes on the array | Integer | None | No |
| tooling_holes_size | The size of the tooling holes | Number | millimeters | No |
| x_outs_allowed | Manufacturer can deliver arrays with defect boards as long as these are clearly marked as defect (X'ed out) | Boolean | None | No |
| x_outs_max_percentage_on_array | The maximum number of defective and clearly marked as such boards that are allowed on on panel | Number | percentage | No |
| transplant_board_allowed | Inserting boards from one panel to another to remove x-outs allowed | Boolean | None | No |
| weight | The weight of the array | Number | grams | No |

## Logistical
The "logistical" element type is an "object" and can have the following sub-objects:
### Inner packaging
In describing the inner packaging of several products together before they are put in an outer package and shipped, there are several options to be set. They are all wrapped into a "inner_packing" object. Potential tags are:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| ipc_1601_section_4_2_2_type | Choices are "a", "b", "c" or "d". Please refer to the IPC document for description | String | millimeters | No |
| hic | True to include a HIC (Humidity Indicator Card) in the inner packaging | Boolean | None | No |
| esd | True to force the use of electrostatic discharge compatible material | Boolean | None | No |
| dessicant | True if a dessicant should be included | Boolean | None | No |
| vacuum | True to indicate if vacuum is required. Default is shrink wrap | Boolean | None | No |
| maximum_number_of_arrays | The maximum number of arrays/panels that can be packed together in one inner package | Integer | None | No |

## Configuration
The "configuration" element type is an "object" and can have the following sub-objects:
### Tolerances
### Impedance
### Stackup
When describing the stackup configuration, you can use the following tags:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| locked | True if the stackup is locked and cannot be altered by the manufacturer. Default is False | Boolean | None | No |
| ordered_outer_layers | True if the outer layers listed are in exact order. Default is True | Boolean | None | No |
| ordered_inner_layers | True if the inner layers listed are in exact order. Default is True | Boolean | None | No |
| file_name | The name of the file that describes the stackup in furter detail | String | None | No |
