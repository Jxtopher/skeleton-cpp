## > Doxygen ##################################################################
find_package(Doxygen)
if (DOXYGEN_FOUND)
    configure_file(Doxyfile.in Doxyfile)

    set(DOXYGEN_INPUT ${CMAKE_BINARY_DIR}/Doxyfile)
    set(DOXYGEN_OUTPUT ${APIDOC_DIR}/html/index.html)

    add_custom_target(doc
    COMMAND ${CMAKE_COMMAND} -E echo_append "Building API Documentation..."
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT} > /dev/null
    COMMAND ${CMAKE_COMMAND} -E echo "Done."
    )

    install(DIRECTORY ${CMAKE_BINARY_DIR}/doc/html 
        DESTINATION share/doc/${CMAKE_PROJECT_NAME})
endif (DOXYGEN_FOUND)
## < Doxygen
