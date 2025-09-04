# Change Log

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.5.0] - 2025-09-02

### Added

- Status code now can be set for individual responses.
- Variables:
  - Can be Integer, Decimal or Text
  - Can be defined at project or endpoint level.
  - Endpoints inherit project variables.
  - Endpoints can overwrite project variables.
  - Variables can be used as the parameters to set conditions
  or content in responses.
- Admin API
  - Info endpoint to get ids from the project and endpoint.
  - Endpoints to set variables.
  - Endpoints to delete variables.

### Changed

- Url preffix from project is now applied when matching 
urls

### Fixed

- Code box, not starting in dark mode when the site started in
dark mode
- The remember value used for the condition values fixed.
- Removed unused code references

## [0.4.0] - 2025-06-15

### Added

- Light code editor for the content in the plain response.
- Headers to responses.
- Dark mode.

### Changed

- Removed all show views from the flow of the application. Only 
edit views are now displayed.

### Fixed

- Available variables in endpoint form now are showing and updating
correctly according to standard RFC 6570
- Resolved bug where the curl code was throwing an error when the 
path was empty

## [0.3.0] - 2025-03-29

### Added

- Projects and endpoints are now saved with default values when clicking
"New"
- Endpoints now can have multiple responses, there is always a default
response
- Expressions: are now conditions for secondary responses in the Endpoint
edit view
- Headers can now be used in responses and conditions
- All rails supported http methods are now supported

### Changed

- All resources are now shallow nested. Changes in routing
- Response path format now adheres to RFC 6570

### Fixed

- Minor bug fixes

## [0.2.0] - 2025-01-12

### Added 

- Field in the endpoints view to copy curl command
- Path parameters are now shown while editing endpoint's path
- Path parameters are now replaced in response

## [0.1.1] - 2025-01-01

### Changed

- Disabled force ssl
- Disabled turbo prefetch

### Fixed

- Database config to work correctly in dev and prod

## [0.1.0] - 2024-12-31

### Added

- Manage projects and endpoints
- Endpoints parse path parameters
- Endpoints return saved responses

### Changed

- N/A

### Fixed

- N/A