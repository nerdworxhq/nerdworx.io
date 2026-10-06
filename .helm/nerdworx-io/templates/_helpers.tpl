{{/*
Expand the name of the chart.
*/}}
{{- define "nerdworx-io.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
Uses the deployment name from values so it matches the HTTPRoute backendRef.
*/}}
{{- define "nerdworx-io.fullname" -}}
{{- .Values.deploymentNameWeb | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nerdworx-io.labels" -}}
app: {{ include "nerdworx-io.fullname" . }}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
