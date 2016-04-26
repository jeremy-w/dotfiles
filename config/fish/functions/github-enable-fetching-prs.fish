function github-enable-fetching-prs
	git config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"
end
