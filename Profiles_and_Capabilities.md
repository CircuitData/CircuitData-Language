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
          "count": 2
        }
      }
    }
  }
}
```
The example above would force Soldermask to present two times (top and bottom) in any product it is matched against.

### Example of a profile
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
The sections part in the "Products" section contains one or more objects in an array. In profiles and Capabilities, we have to treat this very differently, as each individual layer in the products should be compared to what could possibly be a single object in a profile or capability. Thus, we have this structure:
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
