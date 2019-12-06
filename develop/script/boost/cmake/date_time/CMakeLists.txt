project(boost_date_time)

add_definitions(-DDATE_TIME_INLINE)

set(SOURCE ../../boost/libs/date_time/src/gregorian/greg_month.cpp
	../../boost/libs/date_time/src/gregorian/greg_weekday.cpp
	../../boost/libs/date_time/src/gregorian/date_generators.cpp)

add_library(${PROJECT_NAME} STATIC ${SOURCE})
