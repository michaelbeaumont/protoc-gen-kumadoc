{{- define "field" }}

- `{{ .Name | camelcase | untitle }}` ({{ if .IsRequired }}required{{ else }}optional{{ end }}{{ if .IsRepeated }}, repeated{{ end }}){{ if .ShortDescription }} - {{ .ShortDescription }}{{ end }}
{{- if and .Description (not .HideDescription) }}
{{ nindent 4 .Description -}}
{{ end -}}
{{ if and .IsEmbed (eq .Package .ComponentPackage) }}
{{ nindent 4 "Child properties:" }}
{{- range .Embed.Fields }}{{ include "field" . | indent 4 }}{{ end -}}
{{ end -}}
{{ if .IsEnum }}
{{ nindent 4 "Supported values:" }}
{{- range .Enum }}
{{ nindent 4 "-" }} `{{ . }}`
{{- end -}}
{{ end -}}
{{ end -}}

{{- define "message" }}
{{- indent 0 "## " }}{{ .Name }}
{{- range .Fields }}{{ template "field" . }}{{ end }}
{{ end -}}

{{- if .Header }}{{ .Header }}{{ end -}}
{{- range .Messages }}{{ template "message" . }}{{ end }}
