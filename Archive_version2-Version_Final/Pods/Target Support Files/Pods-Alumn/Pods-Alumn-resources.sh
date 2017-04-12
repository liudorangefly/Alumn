#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

realpath() {
  DIRECTORY="$(cd "${1%/*}" && pwd)"
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\""
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "$RESOURCE_PATH")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH"
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "DateTools/DateTools/DateTools.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/JSBadgeView/JSBadgeView.bundle"
  install_resource "LeanChatLib/LeanChatLib/Resources/AddGroupMemberBtn@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/AddGroupMemberBtnHL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/avator@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellBlueSelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellGraySelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellNotSelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellRedSelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ContactsPanelDotRect@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_friend@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_newmessage@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_photo@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_scan@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_voip@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/defaultSettings.plist"
  install_resource "LeanChatLib/LeanChatLib/Resources/face@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/face_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/Fav_Cell_Loc@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/group_icon.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-background.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-background@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-flat.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-flat@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-field-cover.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-field-cover@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/keyborad@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/keyborad_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/loudReceive.caf"
  install_resource "LeanChatLib/LeanChatLib/Resources/messageSendFail@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MessageVideoPlay@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MoreFunctionFrame@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/msg_chat_voice_unread.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/msg_chat_voice_unread@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/multiMedia@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/multiMedia_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MultiSelectedPanelBkg@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MultiSelectedPanelConfirmBtnbKG@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/placeholderImage@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/receive.caf"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying000@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying001@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying002@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying003@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordCancel@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingBkg@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal001@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal002@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal003@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal004@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal005@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal006@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal007@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal008@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SearchIcon@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/send.caf"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying000@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying001@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying002@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying003@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_friendcard@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_location@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_myfav@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_openapi@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_pic@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_video@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_videovoip@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_voiceinput@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_voipvoice@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_wxtalk@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/voice@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/VoiceBtn_Black@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/VoiceBtn_BlackHL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/voice_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Receiving_Cavern@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Receiving_LeanChat@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Receiving_Solid@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Sending_Cavern@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Sending_LeanChat@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Sending_Solid@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/emoticons"
  install_resource "LeanChatLib/LeanChatLib/Resources/en.lproj"
  install_resource "LeanChatLib/LeanChatLib/Resources/SECoreTextView.bundle"
  install_resource "LeanChatLib/LeanChatLib/Resources/zh-Hans.lproj"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "DateTools/DateTools/DateTools.bundle"
  install_resource "$PODS_CONFIGURATION_BUILD_DIR/JSBadgeView/JSBadgeView.bundle"
  install_resource "LeanChatLib/LeanChatLib/Resources/AddGroupMemberBtn@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/AddGroupMemberBtnHL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/avator@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellBlueSelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellGraySelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellNotSelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/CellRedSelected@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ContactsPanelDotRect@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_friend@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_newmessage@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_photo@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_scan@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/contacts_add_voip@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/defaultSettings.plist"
  install_resource "LeanChatLib/LeanChatLib/Resources/face@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/face_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/Fav_Cell_Loc@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/group_icon.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-background.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-background@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-flat.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-bar-flat@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-field-cover.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/input-field-cover@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/keyborad@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/keyborad_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/loudReceive.caf"
  install_resource "LeanChatLib/LeanChatLib/Resources/messageSendFail@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MessageVideoPlay@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MoreFunctionFrame@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/msg_chat_voice_unread.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/msg_chat_voice_unread@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/multiMedia@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/multiMedia_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MultiSelectedPanelBkg@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/MultiSelectedPanelConfirmBtnbKG@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/placeholderImage@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/receive.caf"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying000@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying001@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying002@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying003@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/ReceiverVoiceNodePlaying@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordCancel@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingBkg@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal001@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal002@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal003@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal004@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal005@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal006@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal007@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/RecordingSignal008@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SearchIcon@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/send.caf"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying000@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying001@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying002@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying003@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/SenderVoiceNodePlaying@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_friendcard@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_location@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_myfav@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_openapi@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_pic@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_video@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_videovoip@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_voiceinput@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_voipvoice@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/sharemore_wxtalk@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/voice@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/VoiceBtn_Black@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/VoiceBtn_BlackHL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/voice_HL@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Receiving_Cavern@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Receiving_LeanChat@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Receiving_Solid@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Sending_Cavern@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Sending_LeanChat@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/weChatBubble_Sending_Solid@2x.png"
  install_resource "LeanChatLib/LeanChatLib/Resources/emoticons"
  install_resource "LeanChatLib/LeanChatLib/Resources/en.lproj"
  install_resource "LeanChatLib/LeanChatLib/Resources/SECoreTextView.bundle"
  install_resource "LeanChatLib/LeanChatLib/Resources/zh-Hans.lproj"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
