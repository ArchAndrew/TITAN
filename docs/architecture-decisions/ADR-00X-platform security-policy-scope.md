***ADR-00X: Platform Security Policy Scope***

* Security policies should apply to tenant workloads by default.
* Core platform namespaces (kube-system, gatekeeper-system,         monitoring, argocd) are excluded from workload-level admission policies unless there is a deliberate, tested exception.
* Infrastructure components that require privileged access must be explicitly accommodated.