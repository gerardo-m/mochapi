# MOCHAPI

## Current Tasks
  
- Add a boolean type m_variable
  - ~~Add the migration.~~
  - ~~Add the type to the variables view.~~
  - ~~Make the value a dropdown if the type is boolean~~
- Add IS_EQUAL and IS_NOT_EQUAL operation to Conditions
  - Completely re-write the conditions feature
    - ~~Add a base expression operation class~~
    - ~~Add a class for every operation, the negation will be in the same class~~
    - ~~The concrete operation classes will contain info for the form rendering 
    and what is allowed in every instance~~
    - ~~The concrete operation will have the number of operands.~~
    - ~~Nested conditions will not yet be added, but should be taken into
    consideration.~~
  - ~~Add functionality for IS_EQUAL operation~~
- Add autosave to all fields in Editing Endpoint
- Add autosave to all fields in Editing Project
- Improve Status code selector behavior in responses
  - When clicked it should select the content to replace when
  starting typing.
- Fix info endpoint not searching any endpoint that doesn't use GET method
- Fix curl command not taking into account the url preffix
- Fix tab not working in variable name, probably because of whitespace being ignored
- Fix operation in conditions not accepting blank value