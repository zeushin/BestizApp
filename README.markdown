#checking your project setting before to build

-Add libxml2 includes to your project

1. Menu Project->Edit Project Settings
2. Search for setting "Header Search Paths"
3. Add a new search path "${SDKROOT}/usr/include/libxml2"
4. Enable recursive option


-Add libxml2 library to to your project

1. Menu Project->Edit Project Settings
2. Search for setting "Other Linker Flags"
3. Add a new search flag "-lxml2"