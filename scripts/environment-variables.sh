#!/bin/sh -xe
: "${ENVIRONMENT:?There must be a ENVIRONMENT environment variable set}"
: "${LOCATION:?There must be a LOCATION environment variable set}"

export TEAMID=TQYB6VJLUN
export PROVIDER=JamesWOOD1426797195
export GITHUB_REPO=classfitter
export GITHUB_OWNER=classfitter
export PRODUCT_NAME=Podaon
export PRODUCT_NAME_LOWER=podaon

export BUILD_SCHEME="ClassfitteriOS"
export UI_TEST_SCHEME="UITests"
export UNIT_TEST_SCHEME="UnitTests"

if [[ $LOCATION == "CI" ]]; then
    export NODE_ENV=production
    export PATH=/Users/buildservice/.rvm/gems/ruby-2.3.0/bin:/Users/buildservice/.rvm/gems/ruby-2.3.0@global/bin:/Users/buildservice/.rvm/rubies/ruby-2.3.0/bin:/Users/buildservice/.rvm/bin:/Users/buildservice/.nvm/versions/node/v6.5.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin
else
    export WORKSPACE=$PWD
    export NODE_ENV=development
    export BUILD_URL=http://www.fakeurl.com
    export BUILD_NUMBER=0
    export GIT_COMMIT=efdbd257dd5aa178ebcdfc265db22997d781654e
fi

: "${WORKSPACE:?There must be a WORKSPACE environment variable set}"
echo "The WORKSPACE is ${WORKSPACE}"

export BIN_DIRECTORY="${WORKSPACE}/bin/${ENVIRONMENT}"
export ENVIRONMENT_DIRECTORY="${WORKSPACE}/env/${ENVIRONMENT}"
export XCODE_WORKSPACE_DIRECTORY_NAME="ClassfitteriOS"
export XCODE_WORKSPACE_DIRECTORY="${ENVIRONMENT_DIRECTORY}/${XCODE_WORKSPACE_DIRECTORY_NAME}"
export IOS_APP_DIRECTORY_NAME="ClassfitteriOS"
export IOS_APP_DIRECTORY="${XCODE_WORKSPACE_DIRECTORY}/${IOS_APP_DIRECTORY_NAME}"
export XCODE_WORKSPACE_FILE="${XCODE_WORKSPACE_DIRECTORY}/ClassfitteriOS.xcworkspace"
export XCODE_PROJECT_FILE="${XCODE_WORKSPACE_DIRECTORY}/ClassfitteriOS.xcodeproj"
export XCODE_PROJECT_FILE_PBXPROJ="${XCODE_PROJECT_FILE}/project.pbxproj"

if [[ ${ENVIRONMENT} == 'production' ]]; then
    DISPLAY_NAME="${PRODUCT_NAME}"
else
    DISPLAY_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${ENVIRONMENT:0:1})${ENVIRONMENT:1}"
fi
export DISPLAY_NAME

export FIREBASE_DIRECTORY_NAME=Firebase
export FIREBASE_SERVICE_FILE=${XCODE_WORKSPACE_DIRECTORY}/FirebaseServiceAccount.json
export FIREBASE_ANALYTICS_FILE=${XCODE_WORKSPACE_DIRECTORY}/GoogleService-Info.plist
export FIREBASE_SYMBOL_SERVICE_JSON=~/${FIREBASE_DIRECTORY_NAME}/FirebaseServiceAccount-${ENVIRONMENT}.json
export FIREBASE_ANALYTICS_PLIST=~/${FIREBASE_DIRECTORY_NAME}/GoogleService-Info-${ENVIRONMENT}.plist	

export VERSION_FILE="${BIN_DIRECTORY}/version.txt"
export FULL_VERSION_FILE="${BIN_DIRECTORY}/fullversion.txt"

if [[ ${LOCATION} == 'CI' ]] && [[ ${COMMAND} == 'deploy' ]] && [[ ${ENVIRONMENT} == 'production' ]]; then
	echo "Using payload from GitHub"
	: "${payload:?There must be a payload environment variable set}"
else
	echo "Using dev payload"
	export payload=`cat ${WORKSPACE}/scripts/deploymentPayload.json`
fi

export PAYLOAD_FILE="${BIN_DIRECTORY}/payload.json"
export GITHUB_STATUS_NAME="${COMMAND}_${ENVIRONMENT}"

export STATUS_FILE="${BIN_DIRECTORY}/status.txt"
export BUNDLE_IDENTIFIER_BASE="com.podaon.ios"

export BUNDLE_IDENTIFIER="${BUNDLE_IDENTIFIER_BASE}-${ENVIRONMENT}"
export VENDOR_ID=${BUNDLE_IDENTIFIER}

if [[ ${COMMAND} == 'deploy' ]] || [[ ${COMMAND} == 'export' ]] || [[ ${COMMAND} == 'archive' ]] || [[ ${COMMAND} == 'build' ]]; then
    export COMPILE_TYPE=release
else
    export COMPILE_TYPE=debug
fi

export PROVISIONING_PROFILE_NAME="${ENVIRONMENT}-${COMPILE_TYPE}"

echo "The BUNDLE_IDENTIFIER AND VENDOR_ID are ${BUNDLE_IDENTIFIER}"
echo "The PROVISIONING_PROFILE_NAME is ${PROVISIONING_PROFILE_NAME}"

if [[ ${ENVIRONMENT} == 'production' ]]; then
    export APPLEID=1159838083
    export GOOGLE_APP_ID=1:785675090007:ios:3cd6ed1bd536e6dd
fi
if [[ ${ENVIRONMENT} == 'beta' ]]; then
    export APPLEID=1159838089
    export GOOGLE_APP_ID=1:785675090007:ios:ee7283f955dd5540
fi
if [[ ${ENVIRONMENT} == 'development' ]]; then
    export APPLEID=1159838102
    export GOOGLE_APP_ID=1:142144125321:ios:d2cea722aa24f417
fi
if [[ ${ENVIRONMENT} == 'test' ]]; then
    export APPLEID=1159838093
    export GOOGLE_APP_ID=1:1071308776983:ios:01c2ebec2e00b55b
fi

export ARCHIVE_DIR="${BIN_DIRECTORY}/archive"
export ARCHIVE_FILE_NAME="ClassfitteriOS"
export EXPORT_DIR="${BIN_DIRECTORY}/export"
export EXPORT_CHECK_DIR="${BIN_DIRECTORY}/export_check"
export UPLOAD_DIR="${BIN_DIRECTORY}/upload"
export ITSMP_FILE=${UPLOAD_DIR}/mybundle.itmsp
export UPLOAD_CHECK_DIR="${BIN_DIRECTORY}/upload_check"
export COVERAGE_DIR="${BIN_DIRECTORY}/coverage"

export UNIT_TEST_RESULTS_FOLDER="${BIN_DIRECTORY}/test-unit-results"
export UI_TEST_RESULTS_FOLDER="${BIN_DIRECTORY}/test-ui-results"
export TEST_RESULTS_FILE="${BIN_DIRECTORY}/results.xml"
export OCUNIT2JUNIT_FOLDER="${WORKSPACE}/test-reports"

if [[ ${LOCATION} == 'CI' ]]; then
    if [[ ${COMMAND} == 'test-ui' ]]; then
        DESTINATION="platform=iOS Simulator,name=iPhone SE,OS=10.0"
    else
        DESTINATION="platform=iOS Simulator,name=iPhone 6,OS=10.0"
    fi
else
    if [[ ${COMMAND} == 'test-ui' ]]; then
        DESTINATION="platform=iOS Simulator,name=iPhone 6s,OS=10.0"
    else
        DESTINATION="platform=iOS Simulator,name=iPhone 5,OS=10.0"
    fi
fi

export DESTINATION

