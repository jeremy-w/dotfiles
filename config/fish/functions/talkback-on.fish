# Defined in - @ line 1
function talkback-on --description 'alias talkback-on=adb shell settings put secure enabled_accessibility_services http://com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService'
	adb shell settings put secure enabled_accessibility_services http://com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService $argv;
end
