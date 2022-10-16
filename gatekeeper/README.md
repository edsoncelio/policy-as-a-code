# Demo - Gatekeeper
Política para requerer a label `gatekeeper` em namespaces.

1. Instalar o helm chart:
```shell
$ helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
$ helm install gatekeeper/gatekeeper --name-template=gatekeeper --namespace gatekeeper-system --create-namespace

```
2. Aplicar o template:
```shell
$ k apply -f templates/requiredLabels_template.yaml
```

3. Aplicar a regra (constraint):
```shell
$ k apply -f constraints/requiredLabels.yaml
```

4. Testar um exemplo com erro:
```shell
$ k apply -f examples/wrong_ns.yaml
```
A saída deve ser algo assim:
```shell
$ Error from server (Forbidden): error when creating "bad_ns.yaml": admission webhook "validation.gatekeeper.sh" denied the request: [ns-must-have-gk] you must provide labels: {"gatekeeper"}
```

5. Testar um exemplo funcionando:
```shell
$ k apply -f examples/working_ns.yaml
```

6. Removendo os CRDs:
```shell
$ k delete crd -l gatekeeper.sh/system=yes
```


Mais exemplos em https://github.com/open-policy-agent/gatekeeper/tree/master/demo.