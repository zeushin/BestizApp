#check project setting before build

-Add libxml2 includes to your project

Menu Project->Edit Project Settings
Search for setting "Header Search Paths"
Add a new search path "${SDKROOT}/usr/include/libxml2"
Enable recursive option
-Add libxml2 library to to your project

Menu Project->Edit Project Settings
Search for setting "Other Linker Flags"
Add a new search flag "-lxml2"