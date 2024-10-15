{{/* vim: set filetype=mustache: */}}

{{/*
Return a soft nodeAffinity definition
{{ include "common.affinities-extras.nodes.soft" (dict "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "common.affinities-extras.nodes.soft" -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - preference:
      matchExpressions:
        - key: {{ .key }}
          operator: In
          values:
            {{- range .values }}
            - {{ . | quote }}
            {{- end }}
    weight: 1
{{- end -}}

{{/*
Return a hard nodeAffinity definition
{{ include "common.affinities-extras.nodes.hard" (dict "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "common.affinities-extras.nodes.hard" -}}
requiredDuringSchedulingIgnoredDuringExecution:
  nodeSelectorTerms:
    - matchExpressions:
        - key: {{ .key }}
          operator: In
          values:
            {{- range .values }}
            - {{ . | quote }}
            {{- end }}
{{- end -}}

{{/*
Return a nodeAffinity definition
{{ include "common.affinities-extras.nodes" (dict "type" "soft" "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "common.affinities-extras.nodes" -}}
  {{- if eq .type "soft" }}
    {{- include "common.affinities-extras.nodes.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "common.affinities-extras.nodes.hard" . -}}
  {{- end -}}
{{- end -}}

{{/*
Return a soft podAffinity/podAntiAffinity definition
{{ include "common.affinities-extras.pods.soft" (dict "component" "FOO" "extraMatchLabels" .Values.extraMatchLabels "context" $) -}}
*/}}
{{- define "common.affinities-extras.pods.soft" -}}
{{- $component := default "" .component -}}
{{- $extraMatchLabels := default (dict) .extraMatchLabels -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
      labelSelector:
        matchLabels: {{- (include "service.selectorLabels-extras" (dict "root" .context "name" .name)) | nindent 10 }}
          {{- range $key, $value := $extraMatchLabels }}
          {{ $key }}: {{ $value | quote }}
          {{- end }}
      namespaces:
        - {{ .context.Release.Namespace | quote }}
      topologyKey: kubernetes.io/hostname
    weight: 1
{{- end -}}

{{/*
Return a hard podAffinity/podAntiAffinity definition
{{ include "common.affinities-extras.pods.hard" (dict "component" "FOO" "extraMatchLabels" .Values.extraMatchLabels "context" $) -}}
*/}}
{{- define "common.affinities-extras.pods.hard" -}}
{{- $component := default "" .component -}}
{{- $extraMatchLabels := default (dict) .extraMatchLabels -}}
requiredDuringSchedulingIgnoredDuringExecution:
  - labelSelector:
      matchLabels: {{- (include "service.selectorLabels" .context) | nindent 8 }}
        {{- range $key, $value := $extraMatchLabels }}
        {{ $key }}: {{ $value | quote }}
        {{- end }}
    namespaces:
      - {{ .context.Release.Namespace | quote }}
    topologyKey: kubernetes.io/hostname
{{- end -}}

{{/*
Return a podAffinity/podAntiAffinity definition
{{ include "common.affinities-extras.pods" (dict "type" "soft" "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "common.affinities-extras.pods" -}}
  {{- if eq .type "soft" }}
    {{- include "common.affinities-extras.pods.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "common.affinities-extras.pods.hard" (dict "context" .context "name" .name) -}}
  {{- end -}}
{{- end -}}