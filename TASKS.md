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
  
- ~~Release v0.1.0~~
- Add a field to copy a curl command per endpoint
  - ~~Show the complete url~~
  - ~~Add curl format~~
  - ~~Add a button to clipboard~~
- Show parameter values in endpoints
  - ~~Implement stimulus controller~~
  - ~~Implement controller endpoint to return the list of params~~
- Implement Plain response replacing values with parameter values
- Release v0.2.0