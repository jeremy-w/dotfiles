function gh-my-merged-today
     if [ (count $argv) -gt 0 ]
       set day $argv[1]
     else
       set day (date +%F)
     end
     gh search prs --author @me --merged-at $day \
       --sort created --order asc \
       --limit 100 \
       --json number,title,url,repository | \
       jq -r '.[] | "* [\(.title) · Pull Request #\(.number) · \(.repository.nameWithOwner)](\(.url))"'
end
