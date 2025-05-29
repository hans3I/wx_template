cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(wx_cmake_template_core LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include FetchContent module
include(FetchContent)

# Set wxWidgets version
set(WXWIDGETS_VERSION "3.2.8")

# Check if wxWidgets is installed
find_package(wxWidgets QUIET)

if(NOT wxWidgets_FOUND)
    message(STATUS "wxWidgets not found. Installing wxWidgets...")

    # Fetch wxWidgets
    FetchContent_Declare(
        wxWidgets
        GIT_REPOSITORY https://github.com/wxWidgets/wxWidgets.git
        GIT_TAG v${WXWIDGETS_VERSION}
    )

    FetchContent_MakeAvailable(wxWidgets)

    # Set wxWidgets_INCLUDE_DIRS and wxWidgets_LIBRARIES after installation
    set(wxWidgets_INCLUDE_DIRS "${wxWidgets_SOURCE_DIR}/include")
    set(wxWidgets_LIBRARIES "${wxWidgets_BINARY_DIR}/lib/libwx_baseu.a;${wxWidgets_BINARY_DIR}/lib/libwx_gtk3u.a")  # Adjust based on your needs
    set(wxWidgets_FOUND TRUE)
else()
    message(STATUS "wxWidgets found.")
endif()

# Ensure main.cpp is included
set(SRCS main.cpp)

# Include wxWidgets configuration
include(${wxWidgets_USE_FILE})

if(APPLE)
    add_executable(main MACOSX_BUNDLE ${SRCS})
    set_target_properties(main PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist)
else()
    add_executable(main WIN32 ${SRCS})  # Removed main.exe.manifest
endif()

target_link_libraries(main PRIVATE ${wxWidgets_LIBRARIES})