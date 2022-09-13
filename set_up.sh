#!/bin/bash

echo "----------------------------------------------------------------------------------------"

PROJECT_NAME="DesignPatterns"
PROJECT_ROOT_DIR=$(pwd)
BUILD_DIR="${PROJECT_ROOT_DIR}/build"
PROGRAM_BIN="${BUILD_DIR}/${PROJECT_NAME}"

echo "--Variables"
echo "PROJECT_NAME      :   ${PROJECT_NAME}"
echo "PROJECT_ROOT_DIR  :   ${PROJECT_ROOT_DIR}"
echo "BUILD_DIR         :   ${BUILD_DIR}"
echo "PROGRAM_BIN       :   ${PROGRAM_BIN}"
echo
echo "--Functions"
echo "my_build          :   Build code."
echo "my_run            :   Run program."
echo "my_clear          :   Remove build dir."
echo "----------------------------------------------------------------------------------------"

function my_build() {

	if [[ ! -d ${BUILD_DIR} ]]
	then
	 	pushd ${PROJECT_ROOT_DIR} 1> /dev/null;

		meson setup ${BUILD_DIR}
		
	 	popd 1> /dev/null;
	fi

	pushd ${BUILD_DIR} 1> /dev/null

	ninja

	popd 1> /dev/null
}

function my_run() {
	pushd ${BUILD_DIR} 1> /dev/null

	${PROGRAM_BIN}

	popd 1> /dev/null
}

function my_clear() {
	rm -Rf ${BUILD_DIR}
}
