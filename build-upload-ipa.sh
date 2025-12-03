#!/usr/bin/env bash

showHelp() {
cat << EOF
Usage: ./build-upload-ipa.sh [-a <AWS profile>] [-p <project ID>] [-b] [-h]
Archive, build, and upload the demo app to AWS

-h      Display help

-a      Specify the AWS profile to use for uploading the IPA file

-p      Specify the ID of the AWS Device Farm project to upload the IPA to

-b      Only build the IPA and skip uploading to AWS

EOF
exit 0
}

BUILD_ONLY=false
AWS_PROFILE=
AWS_DEVICE_FARM_PROJECT_ID=

while getopts "a:p:bh" arg;
do
  case "${arg}" in
    h)
      showHelp
      ;;
    a)
      AWS_PROFILE="--profile ${OPTARG}"
      ;;
    p)
      AWS_DEVICE_FARM_PROJECT_ID="${OPTARG}"
      ;;
    b)
      BUILD_ONLY=true
      ;;
    *)
      echo Unsupported option: $1
      showHelp
      ;;
  esac
done
shift $((OPTIND-1))

BUILD_SETTINGS=`xcodebuild -project bbnativeplayerkit-demo.xcodeproj -showBuildSettings -json`
MARKETING_VERSION=`jq -r '.[0].buildSettings.MARKETING_VERSION' <<< $BUILD_SETTINGS`
BUILD_VERSION=`jq -r '.[0].buildSettings.CURRENT_PROJECT_VERSION' <<< $BUILD_SETTINGS`

VERSION_NAME="${MARKETING_VERSION//./_}($BUILD_VERSION)"

xcodebuild archive \
  -workspace bbnativeplayerkit-demo.xcworkspace \
  -scheme bbnativeplayerkit-demo \
  -configuration Release \
  -destination="generic/platform=iOS" \
  -sdk iphoneos \
  -archivePath ./build/bbnativeplayerkit-demo-$VERSION_NAME.xcarchive

xcodebuild -exportArchive \
  -archivePath ./build/bbnativeplayerkit-demo-$VERSION_NAME.xcarchive \
  -exportOptionsPlist  ./ExportOptions.plist \
  -exportPath ./build/bbnativeplayerkit-demo-$VERSION_NAME.ipa

mv ./build/bbnativeplayerkit-demo-$VERSION_NAME.ipa/bbnativeplayerkit-demo.ipa ./build/bbnativeplayerkit-demo-$VERSION_NAME.ipa/bbnativeplayerkit-demo-$VERSION_NAME.ipa

if $BUILD_ONLY ; then
  exit
fi

AWS_PROFILE_DETAILS=`aws sts get-caller-identity $AWS_PROFILE`
AWS_ACCOUNT_ID=`jq -r '.Account' <<< $AWS_PROFILE_DETAILS`

DEVICE_FARM_UPLOAD=`aws devicefarm create-upload \
  --project-arn arn:aws:devicefarm:us-west-2:$AWS_ACCOUNT_ID:project:$AWS_DEVICE_FARM_PROJECT_ID \
  --name bbnativeplayerkit-demo-$VERSION_NAME.ipa \
  --type IOS_APP \
  --region us-west-2 \
  $AWS_PROFILE`
DEVICE_FARM_UPLOAD_URL=`jq -r '.upload.url' <<< $DEVICE_FARM_UPLOAD`
curl -T ./build/bbnativeplayerkit-demo-$VERSION_NAME.ipa/bbnativeplayerkit-demo-$VERSION_NAME.ipa "$DEVICE_FARM_UPLOAD_URL"
