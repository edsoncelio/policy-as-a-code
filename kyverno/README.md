# Demo - Kyverno
Política para validar a label `app.kubernetes.io/name` nos pods.

1. Instalar o helm chart:
```shell
$ helm repo add kyverno https://kyverno.github.io/kyverno/
$ helm install kyverno kyverno/kyverno -n kyverno --create-namespace

```
2. Aplicar a política:
```shell
$ k apply -f validateNameLabel.yaml
```

4. Testar um exemplo com erro:
```shell
$ k create deployment nginx --image=nginx
```
A saída deve ser algo assim:
```shell
$ error: failed to create deployment: admission webhook "validate.kyverno.svc-fail" denied the request:

policy Deployment/default/nginx for resource violation:

require-labels:
  autogen-check-for-labels: 'validation error: label ''app.kubernetes.io/name'' is
    required. rule autogen-check-for-labels failed at path /spec/template/metadata/labels/app.kubernetes.io/name/'
```

5. Testar um exemplo funcionando:
```shell
$ k run nginx --image nginx --labels app.kubernetes.io/name=nginx
```

6. Removendo as policies:
```shell
$ k delete cpol --all
```

Mais exemplos em https://github.com/open-policy-agent/gatekeeper/tree/master/demo.