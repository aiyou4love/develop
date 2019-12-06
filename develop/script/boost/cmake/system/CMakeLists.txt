project(boost_system)

add_definitions(-DBOOST_SYSTEM_STATIC_LINK=1)

aux_source_directory(../../boost/libs/system/src SOURCE)

add_library(${PROJECT_NAME} STATIC ${SOURCE})
