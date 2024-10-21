# Fstyr service Helm Chart
Deploys a generic container

## Installing
First add FSTYR Helm repo to Helm
```console
$ helm repo add fstyr ???
$ helm repo update
```

Create values.yaml file with the parameters specified  

Run Helm command:  
```console
$ helm install web-service fstyr/fstry-service-chart -f myValues.yaml 
```
## Configuration
The following table, lists the configurable parameters.

Parameter | Description                                                                                                                                                                                                                                                                                    | Example
--- |------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| ---
**[Basics](#adding-basics)** |
`fullnameOverride` | Name of the service                                                                                                                                                                                                                                                                                                                                                                                  
`podSecurityContext` | podSecurityContext                                                                                                                                                                                                                                                                             
`podAnnotations` | Annotations for the pod fx prometheus                                                                                                                                                                                                                                                          |                                                                                                                
`imagePullSecrets` | imagePullSecrets                                                                                                                                                                                                                                                                               
`image.repository` | Name of the web-service image                                                                                                                                                                                                                                                                  
`image.tag` | Web-service image tag                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `v1.1.3` 
`replicaCount` | Number of replicas enabled                                                                                                                                                                                                                                        | `8`
`deploymentStrategy` | Enables to set deployment strategy                                                                                                                                                                                                                                                             | `Recreate`
`affinity`                          | Affinity for pod assignment.                                                                                                                                                                                                                                                                   |
`podAffinityPreset`                  | Pod affinity preset. Ignored if `affinity` is set. Allowed values: ``, `soft` or `hard`                                                                                                                                                                                                        | `""`                         |
`podAntiAffinityPreset`              | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: ``,`soft` or `hard`                                                                                                                                                                                                    | `soft`                       |
`nodeAffinityPreset.type`            | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                                      | `""`                         |
`nodeAffinityPreset.key`             | Node label key to match Ignored if `affinity` is set.                                                                                                                                                                                                                                          | `""`                         |
`nodeAffinityPreset.values`          | Node label values to match. Ignored if `affinity` is set.                                                                                                                                                                                                                                      | `[]`
&nbsp; |
**[Deployment](#adding-deployment)** |
`deployment.hostAliases` | hostAliases                                                                                                                                                                                                                                                                                    |
`deployment.containerPort` | Port on web-service                                                                                                                                                                                                                                                                            | `8080`
`deployment.extraContainerPort` | Extra port on deployment                                                                                                                                                                                                                                                                       | `Port1: 8051`
`deployment.configMapMountPaths` | Set value if config map needs to mount on deployment                                                                                                                                                                                                                                           | `/config`
`deplyment.extraVolumeMounts` | Extra volume mounts                                                                                                                                                                                                                                                                            
`deplyment.readinessProbe` | Set values under this to config readiness probe                                                                                                                                                                                                                                                
`deplyment.livenessProbe` | Set values under this to config liveness probe                                                                                                                                                                                                                                                 
`deplyment.commands` | List of cronjob commands                                                                                                                                                                                                                                                                       | `- /bin/bash`
`deplyment.args` | List of arguments to the commands                                                                                                                                                                                                                                                              |
`deployment.priorityClassName` | Deployment priorityClassName |  |
**Deployment - Environment variables** |
`deployment.env` | Map of environment variables                                                                                                                                                                                                                                                                   
`deployment.env.{name}` | Name of the environment variables                                                                                                                                                                                                                                                              
`deployment.env.{name}.value` | Value of the environment variable                                                                                                                                                                                                                                                              
`deployment.env.{name}.type` | Optional: specify type of the environment variables if it should be read from a secret or configmap.<br> One of fieldPath, secretKeyRef, configMapKeyRef                                                                                                                                       | `type: secretKeyRef`
`deployment.env.{name}.fieldPath` | Optional: Value of fieldPath                                                                                                                                                                                                                                                                   
`deployment.env.{name}.name` | Optional: Name of the SecretKeyRef or ConfigMapKeyRef                                                                                                                                                                                                                                          
`deployment.env.{name}.key` | Optional: Key for the SecretKeyRef or ConfigMapKeyRef                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
&nbsp; |
**[initContainers](#adding-initcontainer)** |
`initContainers.<name>.image.repository` | image repo                                                                                                                                                                                                                                                                                     
`initContainers.<name>.image.tag` | image tag                                                                                                                                                                                                                                                                                      
`initContainers.<name>.env` | See: Deployment - Environment variables                                                                                                                                                                                                                                                                                                           
&nbsp; |
**[PodDisruptionBudget](#PodDisruptionBudget)** |
`podDisruptionBudget.minAvailable` | Which is a description of the number of pods from that set that must still be available after the eviction, even in the absence of the evicted pod. minAvailable can be either an absolute number or a percentage.                                                                                                                                                                                                                                                                                     
`podDisruptionBudget.maxUnavailable` | Which is a description of the number of pods from that set that can be unavailable after the eviction. It can be either an absolute number or a percentage.                                                                                                                                                                                      &nbsp; |
**[NetworkPolicy](#PodDisruptionBudget)** |
`netpol.ingress.{name}.namespace` | Namespace traffic is orginating from, if outsite one namespace
`netpol.ingress.{name}.podSelector` | Pod labes to match on orgination pod
`netpol.ingress.{name}.ports` | Port to allow ingres on matcing namspace and/or podSelector | `80: TCP`                                                                                                 
`netpol.egress.dns` | Allow pod to connect to cluster DNS server | `true`          
`netpol.egress.useKafka` | Allow pod to connect to kafka | `true`                                                                                          
`netpol.egress.usePostgres.inNamespace` | Allow pod to connect to postgres in namespace is as value | `example-postgres`
`netpol.egress.{name}.namespace` | Namespace of the revicing pod, if not in own namespace
`netpol.egress.{name}.podSelector` | Pod labes to match on the revicing pod
`netpol.egress.{name}.ports` | Port to allow egress on matcing namspace and/or podSelector
`netpol.egress.{name}.fqdn` | List of FQDN to connect to outsite the cluster. Can only be usted under the same {name} with ports | `- "fstyr.dk"`
&nbsp; |
**[Ingress](#adding-ingress)** |
`ingress.enabled` | Set to true to enable ingress. This also add a network policy thats allow traffik from the ingress-nginx                                                                                                                                                                                                                                                                | `true`
`ingress.annotations` | Annotations for ingress                                                                                                                                                                                                                                                                        |  | Hosts served by the ingress                                                                                                                                                                                                                                                                    | `- host: domain.dk`
`ingress.tls` | TLS config                                                                                                                                                                                                                                                                                     
`extraIngress` | Map of extra ingress                                                                                                                                                                                                                                                                           
`extraIngress.{name}` | Place ingress values under the name value                                                                                                                                                                                                                                                      
&nbsp; |
**[Service](#adding-service)** |
`service.enabled` | Set to false to disable service                                                                                                                                                                                                                                                                | `false`
`service.port` | Port on the service                                                                                                                                                                                                                                                                            | `8080`
`service.targetPort` | Target port                                                                                                                                                                                                                                                                                    | `proxy-port`
`service.annotations` | Annotations for service                                                                                                                                                                                                                                                                        |                                                                                                             |
&nbsp; |
**[Sidecar](#adding-sidecar)** |
`sidecar.{name}` | Name of sidecar                                                                                                                                                                                                                                                                                |
`sidecar.image.repository` | Repository of image                                                                                                                                                                                                                                                                            |
`sidecar.image.tag` | Image tag                                                                                                                                                                                                                                                                                      |
`sidecar.env` | Env variables                                                                                                                                                                                                                                                                                  |
`sidecar.commands` | Commands for sidecar                                                                                                                                                                                                                                                                           |
`sidecar.args` | Arguments for container                                                                                                                                                                                                                                                                        |
`sidecar.containerPort` | Port of container                                                                                                                                                                                                                                                                              |
`sidecar.extraVolumeMounts` | Extra volumes mount. Due to limitations of Helm, two mounts cannot refer to the same volume. This chart allows to ovecome this by adding `_<number>` to the end of the name. Thus, `myEmptyDir_1` and `myEmptyDir_2` (and `myEmptyDir`) will refer to the same volume, with name `myEmptyDir`. |
&nbsp; |
**[Sealed Secret](#adding-sealed-secret)** |
`sealedSecret.{name}` | Name of secret                                                                                                                                                                                                                                                                                 |
`sealedSecret.{name}.type` | Type of the secret - Default Opaque                                                                                                                                                                                                                                                            | `kubernetes.io/tls`
`sealedSecret.{name}.encryptedData` | List of 'Key: Value' pair of the encrypted data                                                                                                                                                                                                                                                | `password: AgBOQOoh7RGqTBPPSG0Ctbf...`
`sealedSecret.{name}.data` | List of 'Key: Value' pair of non-encrypted data | `host: exsample.com`
&nbsp; |
**[ServiceMonitor](#adding-ServiceMonitor)** |
`serviceMonitor.enabled` | Enable service monitor                                                                                                                                                                                                                                                                         |
`serviceMonitor.release` | Value of relese label, to select promethues                                                                                                                                                                                                                                                    |
`serviceMonitor.path` | Path for metric endpoint. Default `/metrics`                                                                                                                                                                                                                                                   |
`serviceMonitor.targetPort` | Port for metric endpoint. Default `deployment.containerPort`                                                                                                                                                                                                                                   |
`serviceMonitor.interval` | Scrape interval. Defalt non, using promethues default                                                                                                                                                                                                                                          |
&nbsp; |
**[PrometheusRule](#adding-PrometheusRule)** |
`prometheusRules.enabled` | Enable PrometheusRule                                                                                                                                                                                                                                                                          |
`prometheusRules.release` | Value of relese label, to select promethues                                                                                                                                                                                                                                                    |
`prometheusRules.rules` | yaml with rules                                                                                                                                                                                                                                                                                |


# Mini guides
There are a few guides, but if it is still not what you're looking for, please direct your attention to the [configuration](#Configuration). Here you will find all the configuration values that can be set.
## Adding Basics
Parameter | Description | Example
--- | --- | ---
**Basics** |
`fullnameOverride` | Name of the service
`podSecurityContext` | podSecurityContext
`podAnnotations` | Annotations for the pod | 
`imagePullSecrets` | imagePullSecrets
`image.repository` | Name of the web-service image
`image.tag` | Web-service image tag
`replicaCount` | Number of replicas | `1`, `2`, `3` ..
`revisionHistoryLimit` | Maximum replicasets that are saved for rollback. | `1`, `2`, `3` ..
`deploymentStrategy` | Enables to set deployment strategy | `Recreate`

> see full configuration [here]( #Configuration)

First of all we need to specify the basics. We need to provide information about the image we wish to deploy.

For `deploymentStrategy`, Kubernetes offers two strategies; `Recreate` or `RollingUpdate` (default).
- `Recreate` : All existing Pods are killed before new ones are created
- `RollingUpdate` : The Deployment updates Pods in a rolling update fashion
> This chart does not support paramaters; `maxUnavailable` and `maxSurge` to control the rolling update process.

> Kubernetes Doc: [Deploymentstrategies](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) \
> You can also achieve other kinds of deploymentstrategies like; canary, blue/green etc [read here](https://blog.container-solutions.com/kubernetes-deployment-strategies)

```yaml
fullnameOverride: mywebapp
podSecurityContext:
  runAsUser: 1000
  runAsGroup: 3000
  fsGroup: 2000
imagePullSecrets:
  - name: someSecret
replicaCount: 4
image:
  repository: kvalitetsit/greatestImageOfAllTime
  tag: 1.1.0

```
## Adding Deployment

 Parameter                                       | Description                                                                                                                                                                                                                                                                                                                                                             | Example                                                                                                                             
-------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------
 `deployment.enabled`                            | Enables the deployment                                                                                                                                                                                                                                                                                                                                                  | `true` or `false`                                                                                                                   
 `deplyment.kind`                                | Set kind - default Deploymeny | `DaemonSet` |                                                                                                                         | 
 `deployment.hostAliases`                        | hostAliases                                                                                                                                                                                                                                                                                                                                                             |
 `deployment.containerPort`                      | Port on web-service                                                                                                                                                                                                                                                                                                                                                     | `8080`                                                                                                                              
 `deployment.extraContainerPort`                 | Extra port on deployment                                                                                                                                                                                                                                                                                                                                                | `Port1: 8051`                                                                                                                       
 `deployment.configMapMountPaths`                | Set value if config map needs to mount on deployment                                                                                                                                                                                                                                                                                                                    | `/config`                                                                                                                           
 `deplyment.extraVolumeMounts`                   | Extra volume mounts                                                                                                                                                                                                                                                                                                                                                     
 `deplyment.readinessProbe`                      | Set values under this to config readiness probe                                                                                                                                                                                                                                                                                                                         
 `deplyment.livenessProbe`                       | Set values under this to config liveness probe                                                                                                                                                                                                                                                                                                                          
 `deplyment.commands`                            | List of cronjob commands                                                                                                                                                                                                                                                                                                                                                | `- /bin/bash`                                                                                                                       
 `deplyment.args`                                | List of arguments to the commands                                                                                                                                                                                                                                                                                                                                       |
 **Deployment - Environment variables**          |
 `deployment.env`                                | Map of environment variables                                                                                                                                                                                                                                                                                                                                            
 `deployment.env.{name}`                         | Name of the environment variables                                                                                                                                                                                                                                                                                                                                       
 `deployment.env.{name}.value`                   | Value of the environment variable                                                                                                                                                                                                                                                                                                                                       
 `deployment.env.{name}.type`                    | Optional: specify type of the environment variables if it should be read from a secret or configmap.<br> One of fieldPath, secretKeyRef, configMapKeyRef                                                                                                                                                                                                                | `type: secretKeyRef`                                                                                                                
 `deployment.env.{name}.fieldPath`               | Optional: Value of fieldPath                                                                                                                                                                                                                                                                                                                                            
 `deployment.env.{name}.name`                    | Optional: Name of the SecretKeyRef or ConfigMapKeyRef                                                                                                                                                                                                                                                                                                                   
 `deployment.env.{name}.key`                     | Optional: Key for the SecretKeyRef or ConfigMapKeyRef                                                                                                                                                                                                                                                                                                                   
 `deployment.envFrom`                            | Map of environment variables                                                                                                                                                                                                                                                                                                                                            
 `deployment.envFrom.configMapRef`               | List of ConfigMaps to read environment variables -from                                                                                                                                                                                                                                                                                                                  | <code>configMapRef:<br>&nbsp;&nbsp;- my-configmap</code>                                                                            
 **Deployment - Volume mounts**                  |
 `deployment.extraVolumeMounts`                  | Extra volume mounts                                                                                                                                                                                                                                                                                                                                                     
 `deployment.extraVolumeMounts.{name}`           | Name of the extra volume mount. This must match the name of 'deployment.extraVolumes.{name}'. Due to limitations of Helm, two mounts cannot refer to the same volume. This chart allows to ovecome this by adding `_<number>` to the end of the name. Thus, `myEmptyDir_1` and `myEmptyDir_2` (and `myEmptyDir`) will refer to the same volume, with name `myEmptyDir`. 
 `deployment.extraVolumeMounts.{name}.mountPath` | Mountpath for the extra volume                                                                                                                                                                                                                                                                                                                                          
 `deployment.extraVolumeMounts.{name}.subPath`   | Subpath for the extra volume                                                                                                                                                                                                                                                                                                                                            
 `deployment.extraVolumes`                       | Extra volumes for the mounts                                                                                                                                                                                                                                                                                                                                            
 `deployment.extraVolumes.{name}`                | Extra volumes for the mounts.<br>This must match the name of 'deployment.extraVolumeMounts.{name}'<br>The value can be one of persistentVolumeClaim or configMap and the value for claimname _must_ match 'pvc.{name}' or a configmap respectively                                                                                                                      | <code>my-storage: &#124;-<br>&nbsp;&nbsp;persistentVolumeClaim:<br>&nbsp;&nbsp;&nbsp;&nbsp;claimName: my-application-storage</code> 

> see full configuration [here]( #Configuration)

First of all we need to specify the basics. We need to provide env-variables, arguments for our container, and also containerports. The image we need to deploy, has already been specified in chapter before [the basics](#adding-basics).
```yaml
deployment:
...
  enabled: true
  containerPort: 1313
  exstraContainerPort: 1314
  args: []
  env:
    someEnvVar1:
      value: goodValue1
    someEnvVar2:
      value: valueForSecrets
```
When that is done, we need to setup our probes. Kubernetes describes the probes as follows;
- *ReadinessProbe* The kubelet uses readiness probes to know **when a container is ready to start accepting traffic**. A Pod is considered ready when all of its containers are ready. One use of this signal is to control which Pods are used as backends for Services. When a Pod is not ready, it is removed from Service load balancers.
- *LivenessProbe* The kubelet uses liveness probes to know **when to restart a container**. For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. Restarting a container in such a state can help to make the application more available despite bugs.
- *StartupProbe* The kubelet uses startup probes to know **when a container application has started**. If such a probe is configured, it disables liveness and readiness checks until it succeeds, making sure those probes don't interfere with the application startup. This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.

> Read more [here](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/).

Now that we know what probes are, lets configure them!

```yaml
deployment:
...
  readinessProbe:
    httpGet:
      path: /
      port: 1313
    initialDelaySeconds: 5
    periodSeconds: 5
    successThreshold: 1
    timeoutSeconds: 1

  livenessProbe:
    httpGet:
      path: /
      port: 1313
```
The service-chart supports all the paramaters that the regular liveness -and readinessprobes supports.

## Set Pod affinity
This chart allows you to set custom Pod affinity using the affinity parameter. Find more information about Pod's affinity in the Kubernetes documentation.

As an alternative, you can use any of the preset configurations for pod affinity, pod anti-affinity, and node affinity. To do so, set the podAffinityPreset, podAntiAffinityPreset, or nodeAffinityPreset parameters.## Adding initcontainer
Parameter | Description | Example
--- | --- | ---
**initContainers** |
`initContainers.<name>.image.repository` | image repo
`initContainers.<name>.image.tag` | image tag
`initContainers.<name>.env` | See: Deployment - Environment variables
`initContainers.<name>.configMapMountPaths` | Set value if config map needs to mount on init container
`initContainers.<name>.extraVolumeMounts` | Extra volume mounts. Due to limitations of Helm, two mounts cannot refer to the same volume. This chart allows to ovecome this by adding `_<number>` to the end of the name. Thus, `myEmptyDir_1` and `myEmptyDir_2` (and `myEmptyDir`) will refer to the same volume, with name `myEmptyDir`.
`initContainers.<name>.extraVolumeMounts.{name}.mountPath` | Mountpath for the extra volume
`initContainers.<name>.extraVolumeMounts.{name}.subPath` | Subpath for the extra volume

> see full configuration [here]( #Configuration)

### Why do we need initcontainers?
Lets say that we wish to add a custom theme to keycloak. The keycloak-app looks at the `/themes` folder to find the available themes. This `/themes` folder is mounted as a persistent volume from the container, to [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), which means that everything we need to do is to add our theme into that folder in the volume.
> The reason why we need to run at every start, is because the persistent volume is mountet to [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) which means that the lifetime of that volume does not exceed the lifetime of the pod.

So an initContainer in this example would inject a theme into the volume `/themes` and thereby provide the instance with the custom theme.

read more about initContainers [here](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/).


### Using initcontainer
#### Image
First of all we need to configure what image and tag we wish to use for our initContainer.
> Remember that initContainers must be able to run to completion!

```yaml
initContainers:
  my-initcontainer:
    image:
      repository: totallyMyUser/my-docker-image
      tag: 1.3.3.7
```

#### Env-variables
Now we define environment variables, in case thats needed
```yaml
env:
  environment:
    value: test
  host:
    value: myhost.com

```
## Adding Ingress
Parameter | Description | Example
--- | --- | ---
**Ingress** |
`ingress.enabled` | Set to false to disable ingress | `false`
`ingress.annotations` | Annotations for ingress | `kubernetes.io/ingress.class: nginx`
`ingress.hosts` | Hosts served by the ingress | `- host: domain.dk`
`ingress.tls` | TLS config
`extraIngress` | Map of extra ingress
`extraIngress.{name}` | Place ingress values under the name value

> see full configuration [here]( #Configuration)

When you find yourself in a position where you wish do deploy an application, that can be reached from the internet, you will need to add an ingress to your app. This ingress will direct traffic from a domain into the service configured.

1. Enable ingress in Configuration
1. Add the appropriate annotations
1. Specify what domain/host that should point to the service
1. Add the tls-part in the example below, if TLS/SSL should be used
    > *Please note that this uses the certificate existing in the secret specified in secretName. (It will not create the certificate)*

```yaml
  ingress:
    enabled: true
    annotations: 
      cert-manager.io/cluster-issuer: letsencrypt-prod
    hosts:
      - host: mydomain.com
        paths:
          - path: /
    tls:
      - hosts:
          - mydomain.com
        secretName: mydomain.com
```
## Adding sealed secret
Parameter | Description | Example
--- | --- | ---
**Sealed Secret** |
`sealedSecret.{name}` | Name of secret |
`sealedSecret.{name}.type` | Type of the secret - Default Opaque | `kubernetes.io/tls`
`sealedSecret.{name}.encryptedData` | List of 'Key: Value' pair of the encrypted data | `password: AgBOQOoh7RGqTBPPSG0Ctbf...`
`sealedSecret.{name}.data` | List of 'Key: Value' pair of non-encrypted data | `host: exsample.com`

> see full configuration [here]( #Configuration)

With sealed secrets it is possible to store your secrets in github with no security-risk. Sounds like something for you? [Follow this guide!](https://doc.hosting.kitkube.dk/deployment/secrets/)
```yaml
sealedSecret:
  my-secret:
    type: Opaque
    encryptedData:
      password: myEncryptedSecretPassword #remember to encrypt value!
      otherPassword: myOtherEncryptedAndMaybeRedundantPassword #remember to encrypt value!
      thirdPassword: encryptedQuestionWhySoManyPasswords? #remember to encrypt value!
    data:
     host: exsample.com
```

## Set securityContext
Parameter | Description                                                                 | Default
--- |-----------------------------------------------------------------------------| ---
**securityContext** |
`securityContext.readOnlyRootFilesystem` | Mounts the container's root filesystem as read-only.                        | `true`
`securityContext.allowPrivilegeEscalation` | Controls whether a process can gain more privileges than its parent process | `false`
`securityContext.runAsNonRoot` | Type of the secret - Default Opaque                                         | `true`
`securityContext.seccompProfile` | Filter a process's system calls.                                            | `RuntimeDefault`
`securityContextAddCapabilities` | Add capabilities, default all droped                               | `-`


It is possible to overwrite the default securityContext and add system capabilities.
```yaml
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  runAsNonRoot: true
  seccompProfile: RuntimeDefault
securityContextAddCapabilities:
   - CAP_CHOWN
   - CAP_SETGID
   - CAP_SETUID
```

The full list of capabilities are found her: https://man7.org/linux/man-pages/man7/capabilities.7.html

## Set ServiceMonitor
Parameter | Description                                                                 | Default
--- |-----------------------------------------------------------------------------| ---
**ServiceMonitor** |
`serviceMonitor.enabled` | Enable service monitor                                                                                                                                                                                                                                                                         |
`serviceMonitor.release` | Value of relese label, to select promethues                                                                                                                                                                                                                                                    |
`serviceMonitor.path` | Path for metric endpoint. Default `/metrics`                                                                                                                                                                                                                                                   |
`serviceMonitor.targetPort` | Port for metric endpoint. Default `deployment.containerPort`                                                                                                                                                                                                                                   |
`serviceMonitor.interval` | Scrape interval. Defalt non, using promethues default                                                                                                                                                                                                                                          |

```yaml
serviceMonitor:
  enabled: true
  release: prometheus
```

## Set PrometheusRule
Parameter | Description                                                                 | Default
--- |-----------------------------------------------------------------------------| ---
**PrometheusRule** |
`prometheusRules.enabled` | Enable PrometheusRule                                                                                                                                                                                                                                                                          |
`prometheusRules.release` | Value of relese label, to select promethues                                                                                                                                                                                                                                                    |
`prometheusRules.rules` | yaml with rules                                                                                                                                                                                                                                                                                |

```yaml
prometheusRules:
  enabled: true
  release: prometheus-stack-infrastructure
  rules:
     - alert: 'CRITICAL: MariaDB backup failed'
       expr: backup_status{job='mariadb_data_storage_backup'} == 1
       labels:
          severity: critical
          component: data-storage-services
          app: mariadb
       annotations:
          summary: 'CRITICAL: MariaDB backup {{$labels.job}} failed'
          description: MariaDB backup {{$labels.job}} failed for namespace {{$labels.kubernetes_namespace}}
    
```