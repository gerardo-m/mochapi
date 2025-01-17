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
  
- Change the way models are saved, when hitting new they
should be saved.
  - ~~Try projects to save when hitting new~~
  - ~~Extract to a concerns if possible~~
  - Repeat for endpoints
- Add "headers" special variable to add the headers in the 
response if necessary
  - Add headers variables to the solve method in response
  - Think of a way to structure requests

- Release v0.3.0