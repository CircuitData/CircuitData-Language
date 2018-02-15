# CircuitData structure for products

| L1 | L2 | L3 | L4 | L5 | L6 | L7 | L8 | L9 | L10 |
|----|----|----|----|----|----|----|----|----|-----|
| open_trade_transfer_package| | | | | | | | | |
| | circuitdata | | | | | | | | |
| | | products | | | | | | | |
| | | | *Product_X* | | | | | |
| | | | | sections | | | | | | |
| | | | | | name | | | | | |
| | | | | | in_x | | | | | |
| | | | | | in_y | | | | | |
| | | | | | size_x | | | | | |
| | | | | | size_y | | | | | |
| | | | | | mm2 | | | | | |
| | | | | layers | | | | | | |
| | | | | | order| | | | | |
| | | | | | name | | | | | |
| | | | | | function | | | | | |
| | | | | | flexible | | | | | |
| | | | | | materials | | | | | |
| | | | | | sections | | | | | |
| | | | | | thickness | | | | | |
| | | | | | tolerance_minus| | | | | |
| | | | | | tolerance_plus | | | | | |
| | | | | | sub_material_thickness | | | | | |
| | | | | | | *material* | | | | |
| | | | | | | | min_thickness | | | |
| | | | | | | | max_thickness | | | |
| | | | | | coverage | | | | | |
| | | | | | layer_attributes | | | | | |
| | | | | | | minimum_track_width | | | | |
| | | | | | | minimum_spacing_width | | | | |
| | | | | | | conductive_function | | | | |
| | | | | | | polarity | | | | |
| | | | | | | color | | | | |
| | | | | | | heating_operations | | | | |
| | | | | processes | | | | | | |
| | | | | | function | | | | | |
| | | | | | process_attributes | | | | | |
| | | | | | | number_of_holes | | | | |
| | | | | | | type | | | | |
| | | | | | | plated | | | | |
| | | | | | | finished_size | | | | |
| | | | | | | tool_size | | | | |
| | | | | | | layer_start | | | | |
| | | | | | | layer_stop | | | | |
| | | | | | | depth | | | | |
| | | | | | | method | | | | |
| | | | | | | minimum_designed_annular_ring | | | | |
| | | | | | | press_fit | | | | |
| | | | | | | copper_filled | | | | |
| | | | | | | stacked | | | | |
| | | | | | | staggered | | | | |
| | | | | | | alivh | | | | |
| | | | | | | castellated | | | | |
| | | | | | | protection | | | | |
| | | | | metrics | | | | | | | |
| | | | | | board | | | | | | |
| | | | | | | size_x | | | | | |
| | | | | | | size_y | | | | | |
| | | | | | | thickness | | | | | |
| | | | | | array | | | | | | |
| | | | | | | size_x | | | | | |
| | | | | | | size_y | | | | | |
| | | | | | | boards_x | | | | | |
| | | | | | | boards_y | | | | | |
| | | | | | | boards_total | | | | | |
| | | | | | | border_left | | | | | |
| | | | | | | border_right | | | | | |
| | | | | | | border_top | | | | | |
| | | | | | | border_bottom | | | | | |
| | | | | | | board_spacing_x | | | | | |
| | | | | | | board_spacing_y | | | | | |
| | | | | | | fiducials_number | | | | | |
| | | | | | | fiducials_size | | | | | |
| | | | | | | fiducials_shape | | | | | |
| | | | | | | breakaway_method | | | | | |
| | | | | | | mouse_bites | | | | | |
| | | | | | | tooling_holes_number | | | | | |
| | | | | | | tooling_holes_size | | | | | |
| | | | | | | x_outs_allowed | | | | | |
| | | | | | | x_outs_max_percentage_on_array | | | | |
| | | | | | | transplant_board_allowed | | | | | |
| | | | | | | weight | | | | | |
| | | | | logistical | | | | | | |
| | | | | | inner_packaging | | | | | |
| | | | | | | ipc_1601_section_4_2_2_type | | | | |
| | | | | | | hic | | | | |
| | | | | | | esd | | | | |
| | | | | | | desiccant | | | | |
| | | | | | | vacuum | | | | |
| | | | | | | maximum_number_of_arrays | | | | |
| | | | | configuration | | | | | | |
| | | | | | tolerances | | | | | |
| | | | | | | | | | | |
| | | | | | impedance | | | | | |
| | | | | | | | | | | |
| | | | | | stackup | | | | |
| | | | | | | locked | | | |
| | | | | | | ordered_outer_layers | | | |
| | | | | | | ordered_inner_layers | | | |
| | | | | | | file_name | | | | |
| | | | | | markings | | | | |
| | | | | | | layers | | | |
| | | | | | | date_code | | | |
| | | | | | | manufacturer_identification | | | |
| | | | | | | standards | | | | |
| | | | | | | serial_number | | | | |
| | | | | | | serial_number_format | | | | |
| | | | | | | serial_number_start | | | | |
| | | | | | | serial_number_increase_by | | | | |
| | | | | | standards | | | | |
| | | | | | | comply_with | | | | |
| | | | | | | ipc_6010_class | | | | |
| | | | | | | ipc_6010_compliance_level | | | | |
| | | | | | | ipc_6010_copper_plating_thickness_level | | | | |
| | | | | | | ipc_6010_annular_ring_level | | | | |
| | | | | | | ipc_6010_conductor_spacing_level | | | | |
| | | | | | | ipc_6010_conductor_width_level | | | | |
| | | | | | | ipc_6012_class | | | | |
| | | | | | | ipc_6013_class | | | | |
| | | | | | | ipc_6018 | | | | |
| | | | | | testing | | | | |
| | | | | | | netlist | | | | |
| | | | | | | allow_generate_netlist | | | | |
| | | | | | | hipot | | | | |
| | | | | | | 4_wire | | | | |
| | | | | | | ist | | | | |
| | | | | | | impedance | | | | |
| | | | | | country_of_origin | | | | |
| | | | | | | iso_3166_1_alpha_3 | | | | |
| | | | | | | iso_3166_1_alpha_2 | | | | |
| | | | | | | nato_member | | | | |
| | | | | | | eu_member | | | | |
