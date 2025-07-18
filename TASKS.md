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
  
- Add status code to responses
  - ~~Add status code to response model~~
  - ~~Add status code select to the view~~
  - ~~Implement autosave~~
  - ~~Add status code to the call controller~~
- Add variables
  - ~~Design the model. Should be able to belong to a project or to an endpoint~~
  - Add variables to the endpoint view
  - Validate that the variables can't be repeated, verify in the project as well
- Add the variables to the conditions
- Add an admin api endpoint to configure stuff
  - Add an endpoint to set a variable.
- ~~Fix code box not set to dark mode when initiated in dark mode.~~
- Fix ValueInterchangeable to work the same as VariableHolder with class instance variables