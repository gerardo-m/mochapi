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
- ~~Review the new way models are saved. Make sure they~~
~~don't create a new instance when refreshing~~.
- ~~Change response to request relation to has_many. When
asking for a response just return the first one to avoid
errors~~
- ~~Fix the routing to endpoints and the scope to a single 
project. The collection routes should have the projects
in the path, the member ones don't~~
- ~~Create expressions model and table.~~
- ~~Create new partials for the response.~~
- ~~Fix Endpoints showing all endpoints regardles of the
selected project.~~
- ~~Implement adding a new response, removing a response~~
- ~~Implement expressions(conditions) in edit view~~
- ~~Implement apply conditions to return the adequate response~~
- ~~Figure out the mechanic for the operation solving.~~
- ~~Add "headers" special variable to add the headers in the 
response if necessary~~
  - ~~Add headers variables to the solve method in response~~
  - ~~Think of a way to structure requests~~
- ~~Replace ParsedPath custom class with addressable gem~~
- ~~Change IS_A operation to IS_A_NUMBER~~
- ~~Add the rest of the http methods~~
- ~~Test~~

- Release v0.3.0