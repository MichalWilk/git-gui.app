on run
	set gitDocURL to "https://git-scm.com/book/en/v1/Getting-Started-Installing-Git"
	set brewInstallCommand to "/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
	try
		do shell script "command -v /usr/local/bin/git"
		tell application "Terminal"
			do script with command "/usr/local/bin/git gui; exit"
		end tell
	on error theGitError
		if theGitError is "The command exited with a non-zero status." then
			set theAlertText to "Git not found"
			set theAlertMessage to "Git not found in /usr/local/bin. Would you like to see install instructions or just install git through Homebrew?"
			display alert theAlertText message theAlertMessage as critical buttons {"Cancel", "Show", "Install"} default button "Install" cancel button "Cancel"
			if button returned of result = "Install" then
				try
					do shell script "command -v /usr/local/bin/brew"
					tell application "Terminal"
						activate
						do script with command "brew install git; /usr/local/bin/git gui; exit"
					end tell
				on error theBrewError
					if theBrewError is "The command exited with a non-zero status." then
						tell application "Terminal"
							activate
							do script with command brewInstallCommand & "; brew install git; /usr/local/bin/git gui; exit"
						end tell
					else
						set theAlertText to "Error"
						set theAlertMessage to theBrewError
						display alert theAlertText message theAlertMessage as critical buttons {"OK"} cancel button "OK"
					end if
				end try
			else
				if button returned of result = "Show" then
					open location gitDocURL
				end if
			end if
		else
			set theAlertText to "Error"
			set theAlertMessage to theGitError
			display alert theAlertText message theAlertMessage as critical buttons {"OK"} cancel button "OK"
		end if
	end try
end run