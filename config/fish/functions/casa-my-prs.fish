function casa-my-prs
    gh search prs --sort created --order asc --author '@me' --state open --owner Casa-Company --json title,url,repository,number --template '
{{- range . -}}
- {{.repository.name}} #{{.number}}: [{{.title}}]({{.url}})
{{end}}'
end
