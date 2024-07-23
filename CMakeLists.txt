cmake_minimum_required(VERSION 3.16)
project(Union-2D)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

if (WIN32)
    set(CMAKE_CXX_FLAGS "-mwindows")
endif()

if(CMAKE_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Debug"))
    add_definitions(-DBUILD_TYPE_DEBUG)
endif()

# Find the Qt library
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Gui Core Network Svg Quick Xml)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Gui Core Network Svg Quick Xml)

include_directories(${CMAKE_SOURCE_DIR}/src)

#生成ts文件的文件夹
set(TS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/translations")

set(TS_FILES
    "${TS_DIR}/language_zh_CN.ts"
    "${TS_DIR}/language_en.ts"
)

#模拟更新和发布的命令代码
find_program(LUPDATE_EXECUTABLE lupdate)
find_program(LRELEASE_EXECUTABLE lrelease)
find_program(LCONVERT_EXECUTABLE lconvert)

#生成ts和qm文件
foreach(_ts_file ${TS_FILES})
    execute_process(COMMAND ${LUPDATE_EXECUTABLE} -recursive ${CMAKE_CURRENT_SOURCE_DIR} -ts ${_ts_file})
endforeach()

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/translations")
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/themes")
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/configs")
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/codedemo")

FILE(GLOB HEADERS
    ${CMAKE_SOURCE_DIR}/src/*.h
    ${CMAKE_SOURCE_DIR}/src/model/*.h
)

FILE(GLOB SOURCES
    ${CMAKE_SOURCE_DIR}/src/*.cpp
    ${CMAKE_SOURCE_DIR}/src/model/*.cpp
)

set(PROJECT_SOURCES
    ${HEADERS}
    ${SOURCES}
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_resources(qrc_FILES ${CMAKE_CURRENT_SOURCE_DIR}/qml.qrc)
    qt_add_executable(Union-2D ${PROJECT_SOURCES} ${qrc_FILES} ${CMAKE_CURRENT_SOURCE_DIR}/app_icon.rc)
else()
    qt5_add_resources(qrc_FILES ${CMAKE_CURRENT_SOURCE_DIR}/qml.qrc)
    add_executable(Union-2D ${PROJECT_SOURCES} ${qrc_FILES} ${CMAKE_CURRENT_SOURCE_DIR}/app_icon.rc)
endif()

target_link_libraries(Union-2D PUBLIC
    Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Svg
    Qt${QT_VERSION_MAJOR}::Network Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Xml
)

execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/themes ${CMAKE_CURRENT_BINARY_DIR}/themes)
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/configs ${CMAKE_CURRENT_BINARY_DIR}/configs)
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/codedemo ${CMAKE_CURRENT_BINARY_DIR}/codedemo)
