# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Document Versioning approach.
- Realistic example files.
- Board area to metrics section.
- UUIDs to layers and processes
- IMS to material groups.
- Unit of Measure to relevant attributes for products.
- `solder_paste` as a valid layer function.
- `additional`, `verified` and `ipc_standard` attributes to materials.
- `capped` and `covered` to hole processes.
- `ipc_a600_class` to standards section.
- `none` option to impedance testing.

### Changed

- Internal references to layers to use UUDs instead of names.
- Limit number of materials to one except for final_finish layers.
- `ipc_slash_sheet` for materials to allow for multiple slash sheets.
- `copper_filled` to `filled` for hole processes.

### Deprecated

### Fixed

- Correct board area unit
- Spelling mistakes with property names.
- Specification of requirements.
- Specification for `layer_attributes`.

### Removed

- Unneeded attributes from layers and processes.
- Duplicate standard `ul`. This is the same as `ul94` and makes it consistent with how UL is named for materials.
- Breakaway method from board. This is present and only makes sense in the array section where it describes how boards within an array are separated from each other and the array itself.
- `v_cut` and `v_groove` from breakaway_method for array. These have the same meaning as `scoring` which is already present.

## [1.0.0] - 2018-03-12
