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
  
- ~~Fix available path variables not showing.~~
- Remove show only views from the flow.
  - ~~Merge the show view into the edit view for projects.~~
  - ~~Change the links in projects.~~
  - ~~Add a delete button in the projects view.~~
  - ~~Merge the show view into the edit view for endpoints.~~
  - ~~Change the links in endpoints.~~
  - ~~Add a delete button in the endpoints view.~~
- ~~Make the content a code box.~~
  - ~~Add a library to handle formatting~~
  - ~~Figure out how to make it work with a form~~
- Fix endpoints edit view
  - ~~Not saving first time~~
  - Copy curl command not updating
- Add headers to responses
- Add darkmode.
- Release 0.4.0