{{/*
Expand the name of the chart.
*/}}
{{- define "rollout-test.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rollout-test.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rollout-test.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rollout-test.labels" -}}
helm.sh/chart: {{ include "rollout-test.chart" . }}
{{ include "rollout-test.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "rollout-test.labels-green" -}}
helm.sh/chart: {{ include "rollout-test.chart" . }}-green
{{ include "rollout-test.selectorLabels-green" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}-green
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}-green
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rollout-test.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rollout-test.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "rollout-test.selectorLabels-green" -}}
app.kubernetes.io/name: {{ include "rollout-test.name" . }}-green
app.kubernetes.io/instance: {{ .Release.Name }}-green
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rollout-test.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rollout-test.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
