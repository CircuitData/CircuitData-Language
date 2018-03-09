# How do I describe

## Table of contents

* [Stackups](#describe-stackups)
* [Conductive layers](#conductive-layers-such-as-copper-or-silver)
* [Final finish](#final-finish)
* [Dielectrics](#dielectrics)
* [Soldermask](#soldermask)
* [Legend](#legend)
* [Stiffener](#stiffener)
* [Coverlay](#coverlay)
* [Peelable mask](#peelable-mask)
* [Peelable tape](#peelable-tape)
* [Conductive carbon print](#conductive-carbon-print)
* [Silver print](#silver-print)
* [Inner packaging](#inner-packaging)
* [Board thickness and size](#board-thickness-and-size)
* [Customer panel](#customer-panel)
* [Depth routing](#depth-routing)
* [Counterboring](#counterboring)
* [Countersink](#countersink)
* [Punching](#punching)
* [Plated edges](#plated-edges)
* [Plated slots](#plated-slots)
* [Plated castellated holes](#plated-castellated-holes)
* [Coin attachment](#coin-attachment)
* [Selective plated pads](#selective-plated-pads)
* [Hard gold edge connectors](#hard-gold-edge-connectors)
* [Markings](#markings)
* [Standards](#standards)
* [](#)
* [](#)


## Describe stackups
Aliases: "Stack up", "stackups", "buildup", "build up"
### as a specification
We generally use "layers" as a way of describing stackups in CircuitData. You'll find that in addition to the usual parts of a stackup (dielectrics and conductive layers), there are several more functions that are defined as layers here. If you have a "free stackup", meaning that the manufacturer is free to choose the materials the have in stock as long as they comply with the demands specified, or you want to set a specific stackup that are not to deviate from. You can use the options set under the ["configuration"](/Howto.md#configuration) and ["stackup"](/Howto.md#stackup) object. In here, you will be able to set if the stackup is locked and thus cannot be changed. You can also specify if the order of the layers (both inner and outer) is ordered properly. Unordered layers will often be the consequence of exports from systems that don't have a total overview of all the layers, so please pay attention to this.

## Conductive layers such as copper or silver
Aliases:
### as a specification
You describe both rigid and flexible conductive layers under the layers section of a product. Each layer must be represented by one item, so a four layer board should have four items under layers with the function being "conductive". You also need to describe the material, e.g. copper. A conductive layer can have a lot of attributes, so make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes).


## Final finish
Aliases: "Surface finish", "finish", "surfacefinish", "finalfinish"
### as a specification
You describe one or more final finishes under the layers section of a product. Each final finish must be represented by one item with the function being "final_finish". You also need to describe the material, e.g. ENIG. A layer of final finish can have a lot of attributes, so make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes).

## Dielectrics
Aliases: "laminates", "dielectricum"
### as a specification
Dielectrics are defined as layers. It is very important that you also define a material and refer to that in the layers. Make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes).

## Soldermask
Aliases: "solder mask", "solder resist"
### as a specification
Soldermasks are defined as layers. It is very important that you also define a material and refer to that in the layers. Make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes). To just define a top or bottom soldermask, or e.g. two on top, make sure that you place the order number of the layer inn accordance with the conductive layers.

## Legend
Aliases: "silk screen", "silkscreen"
### as a specification
Legends are defined as layers. Make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes). To just define a top or bottom legend, make sure that you place the order number of the layer inn accordance with the conductive layers. The color of the legend and the thickness is set on the layer and its attributes.

## Stiffener
Aliases:
### as a specification
Stiffeners are defined as layers. Make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes). Make sure that you place the order number of the layer inn accordance with the conductive layers to get the correct placement.

## Coverlay
Aliases:
### as a specification
Coverlays are defined exactly like a [Soldermask](#soldermask) but with the "flexible" tag set to "true".

## Peelable mask
Aliases:
### as a specification
Peelable masks are defined as layers. Make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes). Make sure that you place the order number of the layer inn accordance with the conductive layers to get the correct placement.

## Peelable tape
Aliases: "kapton", "kapton tape"
### as a specification
Peelable masks are defined as layers. Make sure that you read the [documentation](/Products.md#layer-functions-and-their-attributes). Make sure that you place the order number of the layer inn accordance with the conductive layers to get the correct placement.

## Conductive carbon print
Aliases:
### as a specification
Conductive carbon print is defined as a [conductive layer](#conductive-layers-such-as-copper-or-silver) with a material set to "carbon".

## Silver print
Aliases:
### as a specification
Silver print is defined as a [conductive layer](#conductive-layers-such-as-copper-or-silver) with a material set to "silver".

## Inner packaging
Aliases:
### as a specification
All requirements for the inner packaging of the finished products can be defined in the ["logistical"](/Products.md#logistical) object under the ["inner_packaging"](/Products.md#inner-packaging) object.

## Board thickness and size
Aliases: "PCB"
### as a specification
The size and thickness of the board/PCB is set under the ["metrics"](/Products.md#metrics) object in the ["board"](/Products.md#board) object.

## Customer panel
Aliases: "array", "panel", "circuit board"
### as a specification
All attributes and processes of/on the array/custom panel is set under the ["metrics"](/Products.md#metrics) object in the ["array"](/Products.md#array) object.

## Depth routing
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "depth_routing".

## Counterboring
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "counterboring".

## Countersink
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "countersink".

## Punching
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "punching".

## Plated edges
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "plated_edges".

## Plated slots
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "plated_slots".

## Plated castellated holes
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "hole" and "castellated" set to true.

## Coin attachment
Aliases:
### as a specification
Defined as a [process](/Products.md#process-functions-and-their-attributes) with the function set to "coin_attachment".

## Selective plated pads
Aliases:
### as a specification
Defined as a [layer](/Products.md#layer-functions-and-their-attributes) with the function set to "hard_gold" and a placement attribute of "selective_pads"

## Hard gold edge connectors
Aliases:
### as a specification
Defined as a [layer](/Products.md#layer-functions-and-their-attributes) with the function set to "hard_gold" and a placement attribute of "edge_connectors"

## Markings
Aliases: "lot-code", "lot number", "datecode", "serial number"
### as a specification
Placed in the "configuration" part, this describes the markings needed. Generally you will find LOT/Batch codes here and also serial numbers. Markings are tied up to [layers](/Products.md#layer-functions-and-their-attributes) by the name of the layer.

## Standards
Aliases:
### as a specification
Placed in the "configuration" part, this describes the standards that the finished product needs to be comply with. Check out [this](/Products.md#standards) for potential standards. Please note that if you want to have Halogen Free material, you can add "iec_61249-2-21" to the required standard
