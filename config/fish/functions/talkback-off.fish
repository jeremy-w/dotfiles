# Defined in - @ line 1
function talkback-off --description 'alias talkback-off=adb shell settings put secure enabled_accessibility_services http://com.android.talkback/com.google.android.marvin.talkback.TalkBackService'
	adb shell settings put secure enabled_accessibility_services http://com.android.talkback/com.google.android.marvin.talkback.TalkBackService $argv;
end
