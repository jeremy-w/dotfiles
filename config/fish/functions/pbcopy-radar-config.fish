function pbcopy-radar-config
	begin
        xcrun swift --version
        echo
        xcrun xcodebuild -version
        echo
        sw_vers
    end | pbcopy
end
