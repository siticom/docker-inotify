# docker-inotify

Docker image designed to run as Kubernetes sidecar for reloading changed files (e.g. certificates).

Example:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: demo
spec:
  shareProcessNamespace: true
  containers:
    - name: app
      image: <Image>
      volumeMounts:
        - name: tls
          mountPath: /run/secrets/app-tls
    - name: cert-reloader
      image: ghcr.io/siticom/docker-inotify
      env:
        - name: FILE
          value: /run/secrets/app-tls/tls.crt
        - name: BINARY
          value: app
        # either BINARY or PID can be defined
        # - name: PID
        #   value: "10"
      volumeMounts:
        - name: tls
          mountPath: /run/secrets/app-tls
  volumes:
    - name: tls
      secret:
        secretName: app-tls
```
