# The Materials section
This section allows you to specify materials that are being referenced in the other sections, such as products or capabilities. Without being referenced, this section just becomes a holder for transferring material information.

## Structure
Placed in the "open_trade_transfer_package -> custom -> materials -> circuitdata" subelement, you can list one or more materials. Each element should be named and must should contain a tag with the version number of the CircuitData language being used.
### Examle
```
"materials": {
  "circuitdata": {
    "osp": {
      "function": "final_finish",
      "version": 1.0,
      "group": "osp"
    }
  }
}
```

## Tags
The following main tags are available:

| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| function | The function of the material. Choices are: "conductive", "dielectric", "soldermask", "stiffener", "final_finish" | string | None | Yes |
| group | The group will list the main choice of materials. The choices are different based on the function. The the list [below](#groups) | string | None | Yes |
| manufacturer | The brand that manufacture the material | string | None | No |
| name | The name of the material. Could very well be the same as the tag that holds the material | string | None | No |
| flexible | True to indicate if this material is flexible | Boolean | None | No - default is "false" |
| link | A link to a datasheet or webpage giving more information | string | None | No |
| remark | A piece of text giving further information on the material | string | None | No |
| additional | More text to describe the material | string | None | No |
| accept_equivalent | If used in profiles or products, a "true" here indicates that equivalent material is accepted | boolean | None | No |
| ul94 | The UL94 flame retardant capablities. Choices are "v-0", "v-1", "hb" | string | None | No |
| attributes | Holds additional attributes. Read more [here](#attributes) | object | None | No |

## Groups
The following groups are available:
For "final_finish":
* c_bare_copper
* isn
* iag
* enig
* enepig
* osp
* ht_osp
* g
* GS
* t_fused
* tlu_unfused
* dig
* gwb-1_ultrasonic
* gwb-2-thermosonic
* s_hasl
* b1_lfhasl

For "dielectric":
* FR1
* FR2
* FR3
* FR4
* FR5
* G-10
* G-11
* CEM-1
* CEM-2
* CEM-3
* CEM-4
* CEM-5
* ceramic
* polyimide
* aramid
* acrylic
* LCP
* PEN
* PET

For "soldermask":
* LPISM
* DFISM
* LDISM

For "conductive":
* stainless_steel
* copper
* aluminum
* silver
* gold
* carbon
* silver_platinum
* silver_paladium
* gold_platinum
* platinum

## Tags
The following attributes are available:
For "dielectric":
| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| ipc_slash_sheet |  | Array of Integers | None | No |
| tg_min |  | integer | Celcius | No |
| td_min |  | integer | Celcius | No |
| resin | Choises are: "epoxy", "bt", "cyanate_ester", "phenolic", "polyester", "polyimide", "ppe", "hydrocarbon", "ptfe", "thermoplastic" | string | None | No |
| resin_content |  | number | Percent | No |
| flame_retardent | Choices are: "phosphor", "red_phosphor", "bromine", "chlorine", "antimony_oxide", "rohs_compliant_bromine" | String | None | No |
| woven_reinforcement |  | Boolean | None | No |
| filler | Could be several. Choices are: "ceramic", "kaolin", "organic", "inorganic", "glass" | Array of strings | None | No |
| reinforcement | Choices are "e-glass", "s-glass", "ne-glass", "l-glass", "quartz", "aramid", "paper" | String | None | No |
| thickness |  | Number | micrometers | No |
| dk |  | number | None | No |
| cti |  | number | None | No |
| frequency |  | number | Gigahertz | No |
| df |  | number | Minutes | No |
| t260 |  | number | Minutes | No |
| t280 |  | number | Minutes | No |
| t300 |  | number | Minutes | No |
| mot |  | number | Celcius | No |
| z_cte |  | number | Percent | No |
| z_cte_before_tg |  | number | Percent | No |
| z_cte_after_tg |  | number | Percent | No |
| dielectric_breakdown |  | number | kV | No |
| water_absorption |  | number | Percent | No |
| thermal_conductivity |  | number | W/mK | No |
| volume_resistivity |  | number | megaOhm/centimeter | No |
| electric_strength |  | number | kV/mm | No |
| foil_roughness | Choices are "S", "L", "V" | string | None | No |

For "soldermask":
| Tags          | Description           | [Type](/README.md#about-types-and-how-to-use-them) | Uom | Required |
|:------------- |:----------------------|:----------------------------------------:|:---:|:--------:|
| ipc_sm_840_class | Choices are "T", "H", "TF", "HF" | string | None | No |
| finish | Choices are "matte", "glossy", "semi_glossy" | string | None | No |
