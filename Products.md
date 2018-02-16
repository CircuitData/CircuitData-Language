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
The sections part allows you to divide the product you are describing into several sections and then allow the layers to appear in one or more of them. A single section product needs to contain at least one section. Like this example:
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
The "processes" element type is an "array". Processes include everything which is done to one or more layers. An example of one hole process could be:
```
"processes": [
  {
    "function": "hole",
    "attributes": {
      "number_of_holes": 60,
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
* coin_attachment
* holes
  * Potential attributes:
    * number_of_holes ( type is "integer". Describes the number of holes in the process )
    * type ( type is "string". Describes the type of hole. Choices are "through", "blind", "buried", "back_drill", "via")
    * plated ( type is "boolean". True to indicate plated holes )
    * finished_size ( type is "number". The finished size of the holes in micrometers )
    * tool_size ( type is "number". The size of the tool to be used in micrometers )
    * layer_start ( type is "string". Must refer to the name of a layer in the layers section )
    * layer_stop ( type is "string". Must refer to the name of a layer in the layers section )
    * depth ( type is "number". Indicates the depth of the holes in micrometers )
    * method ( type is "string". How the via is made. Can be either "routing, "drilling" or "laser", where default is "drilling" )
    * minimum_designed_annular_ring ( type is "number". The minimum designed annular ring in micrometers )
    * press_fit ( type is "boolean". True if the holes are for press fit )
    * copper_filled ( type is "boolean". True if the holes are to be copper filled )
    * staggered ( type is "boolean". True if the holes are staggered )
    * stacked ( type is "boolean". True if the holes are staggered )
    * alivh ( type is "boolean". True if ALIVH holes )
    * castellated ( type is "boolean". True if plated half holes )
    * protection ( type is "string". According to IPC-4761. Choices are "1", "2", "3", "4a", "4b", "5", "6a", "6b")

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
### Markings
Markings on the board can happen on several layers, including legends and soldermasks. This section allows you to sum up these markings and attach them to layers.

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| layers | List one or more layers by name that includes markings | Array of strings | None | No |
| date_code | Possible values are "YY" for year, "WW" for week "-" and "LOT" (alias "BATCH"). E.g. "YYWW-LOT" or "LOT-YYWW". If no marking, set "NONE" | String | None | No |
| manufacturer_identification | Manufacturer identification | Boolean | None | No |
| standards | Possible values are the ones listed in the subelement [standards](#standards) but typical will be "ul" and "rohs" | Array of strings | None | No |
| serial_number | Serial number should be added in the markings. Default is false | Boolean | None | No |
| serial_number_format | Format of the serial number expressed as a "regular expression" but needs to have x amount of digits in it. | String | None | No |
| serial_number_start | The number to start the serial number from. Will have to replace the digits from the "serial_number_format" above | Integer | None | No |
| serial_number_increase_by | The increase in number from "serial_number_start" with each product | Integer | None | No |
### Standards
All standards that the finished product needs to be compliant with must be defined here.

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| comply_with | List one or more standards that the product must comply with. Choices are "ul", "c_ul", "rohs", "ul94", "esa", "itar", "dfars", "mil_prf_55110", "mil_prf_50884", "mil_prf_31032", "as9100", "nadcap", "rw_en45545_2_2013", "rw_nf_f_16_101", "rw_uni_cei_11170_3", "rw_nfpa_130" | Array of strings | None | No |
| ipc_6010_class | According to Table 4-2 /4-3. Choices are "1", "2", "3" | Integer | None | No |
| ipc_6010_compliance_level | Choices are "full", "factory_standard", "aabus" | String | None | No |
| ipc_6010_copper_plating_thickness_level | Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Integer | None | No |
| ipc_6010_annular_ring_level | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Integer | None | No |
| ipc_6010_conductor_spacing_level | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Integer | None | No |
| ipc_6010_conductor_width_level | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Integer | None | No |
| ipc_6012_class | Requirements according to IPC 6012 class. Choices are "1", "2", "3", "3A" (Class 3 Autmotive addendum), "3M" (Class 3 Medical addendum), "3S" | String | None | No |
| ipc_6013_class | Requirements according to IPC 6013 for flexible or rigid-flex boards. Choices are "1", "2", "3" | String | None | No |
| ipc_6018 | IPC-6018 Microwave End Product Board Inspection and Test | Boolean | None | No |
### Testing
Describe the requirements for testing of the finished board.

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| netlist | 100% Netlist testing according to IPC-D-356, ODB++ or IPC2581 | Boolean | None | No |
| allow_generate_netlist | Allow Netlist to be generated from Gerber or other file format if needed | Boolean | None | No |
| hipot | HiPot Test (Dielectric Withstanding Voltage Test) | Boolean | None | No |
| 4_wire | Use 4 wired test | Boolean | None | No |
| ist | Use IST testing | Boolean | None | No |
| impedance | Choices are "controlled", "calculated", "follow_stackup" | String | None | No |
### Country Of Origin
Country of Origin is the country where the Printed Circuit Board is/can be manufactured.

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| iso_3166_1_alpha_3 | A three letter string representation of the Country of origin according too ISO 3166-1. | String | None | No |
| iso_3166_1_alpha_2 | A two letter string representation of the Country of origin according too ISO 3166-1. | String | None | No |
| nato_member | Indicates if the COO is a NATO member state | Boolean | None | No |
| eu_member | Indicates if the COO is a European Union member state. | Boolean | None | No |

### allowed_modifications
Changes/fabrication decisions that are allowed to make to the files provided.

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| dead_pad_removal | Non Functioning Pad removal. | Boolean | None | No |
| add_copper_balancing | Adding copper balancing pattern. | Boolean | None | No |
| add_copper_balancing_on_array | Adding copper balancing pattern on array/panel frame. | Boolean | None | No |
| add_tear_drops | Adding Tear Drops. | Boolean | None | No |
