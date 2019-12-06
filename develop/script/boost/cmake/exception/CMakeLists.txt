project(boost_exception)

aux_source_directory(../../boost/libs/exception/src SOURCE)

add_library(${PROJECT_NAME} STATIC ${SOURCE})
