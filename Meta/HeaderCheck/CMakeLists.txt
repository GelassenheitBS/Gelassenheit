execute_process(COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/generate_all.py" "${GELASSENHEIT_ARCH}" OUTPUT_VARIABLE SOURCES_STRING)
string(REPLACE "\n" ";" SOURCES_LIST ${SOURCES_STRING})

add_library(HeaderCheck OBJECT ${SOURCES_LIST})
