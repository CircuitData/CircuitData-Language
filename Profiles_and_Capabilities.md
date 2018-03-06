# The Profile and Capabilities section
Both the Profile and the Capabilities sections allows you to set values that Product information should verified against. Profiles are meant to cover the need to set information for any other than the manufacturer, whereas Capabilities are for the manufacturer to define what it can actually manufacture.

The structure of them both are the same.

Please remember that there is no need to mash everything into one big file - in many cases it would be beneficial to divide it into several small files or streams.

## Structure
Profiles must be placed in the "open_trade_transfer_package -> profiles -> x -> circuitdata" subelement, where "x" is the type of profile. There are three different ways of specifying profiles:
* Default values: "x" is called "defaults". Any information provided here will be treated as supplemental information and should not overwrite any information in a product.
* Values that should be forced: "x" is called "enforced". Any information provided here will be more "worth" than information on the product section.
* Values that are not allowed: "x" is called "restricted". Any information provided here should be tested against the product section to see if unwanted values are being used.

Capabilities must be placed in the "open_trade_transfer_package -> capabilities -> summary -> circuitdata" subelement. Any information provided in the product section can be tested against this section to see if it is compatible and thus within the capability set. *If the product section contains information that is not represented in the profile section, it will be treated as not compatible*.

Capabilities also contains a "materials" subsection where any capability on materials can be listed.

### Example of a profile
```
"profiles": {
  "enforced"
    "circuitdata": {
      "version": 1.0,
      "layers": {
        "soldermask": {
          "flexible": {
            "false": {
              "material": {
                "any": {
                  "count": 2
                }
              }
            }
          }
        }
      }
    }
  }
}
```
The example above would force Soldermask to be present two times (top and bottom) in any non-flexible product it is matched against.

### Example of a capability
```
"capabilities": {
  "summary"
    "circuitdata": {
      "version": 1.0,
      "layers": {
        "soldermask": {
          "count": 2
        }
      }
    }
  }
}
```
The example above would state that the capability is up to two layers of soldermask (top and bottom) in any product it is matched against.

# Structure
To match up with specifications, use the same major groups:
* Sections
* Layers (also including stackup information)
* Processes
* Tolerances
* Logistical
* Configuration

## Sections
To understand sections, you should read [this document](https://www.circuitdata.org/t/18phm5).
The sections part in the "Products" section contains one or more objects in an array. In profiles and Capabilities we only have one object, and all objects in the product will be matched against this one. We also add one more tag called "count". This will limit the amount of objects that can be present in the product section.

Potential tags are:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| count         | How many sections can be present | integer | None | No |
| mm2           | The maximum square millimetre size one section can have | number | None | Yes |


Like this example:
```
"sections": {
  "count": 1,
  "mm2": 400
}

```

## Layers
The layers part in the "Products" section contains one or more objects in an array. In profiles and Capabilities, we have to treat this very differently, as each individual layer in the products should be compared to what could possibly be a single object in a profile or capability. Thus, we have this structure:
* layers
  * function
    * flexible
      * "true"/"false"/"any"
        * material
          * "any"/name of material
            * count
            * thickness
            * tolerance_minus
            * tolerance_pluss
            * minimum_track_width
            * minimum_spacing_width
            * function (when the layer function is "conductive")
            * polarity
            * color
            * heating_operations
            * placement

Please note that the "additional_attributes" are placed directly under the material section, not under an additional "additional_attributes".

### Example
```
"layers": {
  "soldermask": {
    "flexible": {
      "true": {
        "material": {
          "any": {
            "count": 2,
            "thickness": {
              "reverse": false,
              "value_type": "range_of_numbers",
              "value": "8..40"
            }
          }
        }
      },
      "false": {
        "material": {
          "any": {
            "count": 2,
            "thickness": {
              "reverse": false,
              "value_type": "range_of_numbers",
              "value": "20..50"
            }
          }
        }
      }
    }
  }
}
```
## Processes
The process part in the "Products" section contains one or more objects in an array. In profiles and Capabilities, we have to treat this very differently, as each individual process in the products should be compared to what could possibly be a single object in a profile or capability. Thus, we have this structure:

* process
  * function
    * hole_type ( type is "string". Describes the type of hole. Choices are "through", "blind", "buried", "back_drill", "via")
      * "through"/"blind"/"buried"/"back_drill"/"via"
        * plated ( type is "boolean". True to indicate plated holes )
        * tool_size ( type is "range of numbers". The size of the tool to be used in micrometers )
        * depth ( type is "range of numbers". Indicates the depth of the holes in micrometers )
        * method ( type is "array of strings". How the via is made. Can be either "routing, "drilling" or "laser", where default is "drilling" )
        * minimum_designed_annular_ring ( type is "number". The minimum designed annular ring in micrometers )
        * press_fit ( type is "boolean". True if the holes are for press fit )
        * copper_filled ( type is "boolean". True if the holes are to be copper filled )
        * staggered ( type is "boolean". True if the holes are staggered )
        * stacked ( type is "boolean". True if the holes are staggered )
        * alivh ( type is "boolean". True if ALIVH holes )
        * castellated ( type is "boolean". True if plated half holes )
        * protection ( type is "array of strings". According to IPC-4761. Choices are "1", "2", "3", "4a", "4b", "5", "6a", "6b")

### Example
```
"processes": {
  "holes": {
    "hole_type": {
      "via": {
        "stacked": {
          "reverse": false,
          "value_type": "boolean",
          "value": "true"
        }
      }
    }
  }
}
```

## Metrics
The "metrics" element type is an "object" and can have the following sub-objects:
### Board
In specifications, Boards are one PCB. In capabilities and profiles, you can set choices that will be matched agains the specification. The following potential tags are available:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| size_x | Minimum/maximum size of the board in the X-axis | Number range | millimeters | Yes |
| size_y | Minimum/maximum size of the board in the Y-axis | Number range | millimeters | Yes |
| breakaway_method | The method of creation of the breakaways Use only if delivered without an array. Potential values are "routing", "punching" | Array of strings | None | No |
| thickness | Minimum/maximum finished thickness of the board | Number range | millimeters | Yes |

### Array
Array (or custom panel) describes the panel that contains several boards. The following potential tags are available:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| size_x | Minimum/maximum size of the array in the X-axis | Number range | millimeters | Yes |
| size_y | Minimum/maximum size of the array in the Y-axis | Number range | millimeters | Yes |
| boards_x | Minimum/maximum number of boards in the array in the X-axis | Integer range | None | No |
| boards_y | Minimum/maximum number of boards in the array in the Y-axis | Integer range | None | No |
| boards_total | Maximum number of boards in the panel. This is not the preferred method of stating the number, "boards_x" and "boards_y" should be used | Integer | None | No |
| border_left | Minimum/maximum size of the left side boarder between the edge and the board  | Number range | millimeters | No |
| border_right | Minimum/maximum size of the right side boarder between the edge and the board  | Number range | millimeters | No |
| border_top | Minimum/maximum size of the top side boarder between the edge and the board  | Number range | millimeters | No |
| border_bottom | Minimum/maximum size of the bottom side boarder between the edge and the board range | Number | millimeters | No |
| board_spacing_x | Minimum/maximum size of the space between the boards in the x-direction | Number range | millimeters | No |
| board_spacing_y | Minimum/maximum size of the space between the boards in the y-direction | Number range | millimeters | No |
| fiducials_number | Minimum/maximum number of fiducials on the array | Integer range | None | No |
| fiducials_size | Minimum/maximum size of the fiducials | Number range | millimeters | No |
| fiducials_shape | The shape of the fiducials. Potential values are "donut", "circle", "plus" and "diamond" | Array of string | None | No |
| breakaway_method | One or more methods of creation of the breakaways on the array. Potential values are "routing", "scoring", "punching", "v_cut", "v_grove", "jump_scoring" | Array of string | None | No |
| mouse_bites | True if there should be "mouse bites" to allow easy break away of the boards | Boolean | None | No |
| tooling_holes_number | Minimum/maximum number of tooling holes on the array | Integer range | None | No |
| tooling_holes_size | Minimum/maximum size of the tooling holes | Number range | millimeters | No |
| x_outs_allowed | Manufacturer can deliver arrays with defect boards as long as these are clearly marked as defect (X'ed out) | Boolean | None | No |
| x_outs_max_percentage_on_array | The maximum number of defective and clearly marked as such boards that are allowed on on panel | Number | percentage | No |
| transplant_board_allowed | Inserting boards from one panel to another to remove x-outs allowed | Boolean | None | No |

## Logistical
The "logistical" element type is an "object" and can have the following sub-objects:
### Inner packaging
In describing the inner packaging of several products together before they are put in an outer package and shipped, there are several options to be set. They are all wrapped into a "inner_packing" object. Potential tags are:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| ipc_1601_section_4_2_2_type | Choices are "a", "b", "c" or "d". Please refer to the IPC document for description | Aray of strings | millimeters | No |
| hic | True to include a HIC (Humidity Indicator Card) in the inner packaging | Boolean | None | No |
| esd | True to force the use of electrostatic discharge compatible material | Boolean | None | No |
| dessicant | True if a dessicant should be included | Boolean | None | No |
| vacuum | True to indicate if vacuum is required. Default is shrink wrap | Boolean | None | No |
| maximum_number_of_arrays | Minimum/maximum number of arrays/panels that can be packed together in one inner package | Integer range | None | No |

## Configuration
The "configuration" element type is an "object" and can have the following sub-objects:

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
| ipc_6010_class | According to Table 4-2 /4-3. Choices are "1", "2", "3" | Array of integers | None | No |
| ipc_6010_compliance_level | Choices are "full", "factory_standard", "aabus" | Array of strings | None | No |
| ipc_6010_copper_plating_thickness_level | Used either if ipc_6010_class is set to 2 and you want to add copper plating thickness demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Array of integer | None | No |
| ipc_6010_annular_ring_level | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Array of integers | None | No |
| ipc_6010_conductor_spacing_level | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | array of integers | None | No |
| ipc_6010_conductor_width_level | Used either if ipc_6010_class is set to 2 and you want to add annular ring demands from class 3, or the other way round - class 3 is set but you can accept demands from class 2. Choices are "2", "3" | Array of integers | None | No |
| ipc_6012_class | Requirements according to IPC 6012 class. Choices are "1", "2", "3", "3A" (Class 3 Autmotive addendum), "3M" (Class 3 Medical addendum), "3S" | Array of string | None | No |
| ipc_6013_class | Requirements according to IPC 6013 for flexible or rigid-flex boards. Choices are "1", "2", "3" | Array of string | None | No |
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
| impedance | Choices are "controlled", "calculated", "follow_stackup" | Array of strings | None | No |
### Country Of Origin
Country of Origin is the country where the Printed Circuit Board is/can be manufactured.

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| iso_3166_1_alpha_3 | A three letter string representation of the Country of origin according too ISO 3166-1. | Array of strings | None | No |
| iso_3166_1_alpha_2 | A two letter string representation of the Country of origin according too ISO 3166-1. | Array of strings | None | No |
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
| resize_vias | Allow the manufacturer to resize vias to e.g. accomplish a required standard | Boolean | None | No |
