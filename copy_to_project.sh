#!/bin/bash

# Check argument count
if [ "$#" -ne 2 ]; then
    echo "Copies all the required files to the given directory, renaming the project to 'project_name'."
    echo "Usage: copy_to_project.sh directory project_name"
    exit 1
fi

# Check if directory exists
if [ ! -d "$1" ]; then
    echo "Error: the directory $1 does not exist."
    exit 1
fi

# Get script directory
BASEDIR="$(dirname "$(realpath "$0")")"

# Copy necessary files and directories
echo "Copying .vscode directory..."
cp -r "$BASEDIR/.vscode" "$1/.vscode"

echo "Copying .gitignore..."
cp "$BASEDIR/.gitignore" "$1/"

echo "Copying CMakeLists.txt..."
cp "$BASEDIR/CMakeLists.txt" "$1/"

echo "Copying LICENSE..."
cp "$BASEDIR/LICENSE" "$1/"

echo "Copying README.md..."
cp "$BASEDIR/README.md" "$1/"

echo "Copying main.cpp..."
cp "$BASEDIR/main.cpp" "$1/" || {
    echo "Error: main.cpp could not be copied. Please check if it exists in the source directory."
}

# Replace "wx_cmake_template" with project name in all files
echo "Replacing project name in files..."
find "$1" -type f ! -path "$1/.git/*" ! -path "$1/build/*" -exec sed -i "s/wx_cmake_template/$2/g" {} +

echo "All files processed successfully."