# MOCHAPI

## What do we need for the v1?

- Manage projects and endpoints
- Endpoints should parse path
- Config responses to endpoints
- Responses:
  - Plain: just text
  - Json: Should validate the text is valid json
  - Json with variables: replace values with variables


## Current Tasks

- Add response to endpoint
  - ~~Compact endpoint form~~
  - ~~Add dropdown for response type~~
  - ~~Create partial for response~~
  - ~~Save response along the endpoint~~
  - ~~Repeat in the edit/update view~~

- Delegate the request to the response object
  - ~~Implement the model~~
  - ~~Call the method from the controller~~

- Handle path parameters
  - ~~Parse endpoint path~~
  - ~~Validate path from request to the saved path~~

- Improve UI
  - ~~Improve projects pages~~
  - ~~Improve endpoints pages~~

- Write tests
  - Write model tests
  - Write controller tests?
  - Write tests for lib/
  - Write system tests
  
- Release v0.1.0