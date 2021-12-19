## 1 - NameMe | Daosman naming convention

Each contract name should start with capital letter

Every state variable should be marked as private, 
named with a leading underscore and should only be modified
inside the contract. 

Any external contract willing to modify a state variable 
should use an external function that is designed for that purpose

Every function parameter must be named in camel case

Struct variables must be named with an ending underscore 

If two variables share the same name, the latter variable should be named with 
an ending underscore, if still there's a match, there should be two ending 
underscores after the variable name, if still there's a match, variable name 
must be changed

Internal functions must be named with a leading underscore 

Every function must return a value, in case no value is needed, functions 
must return true

