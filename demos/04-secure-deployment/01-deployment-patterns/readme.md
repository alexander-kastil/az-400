# Deployment Patterns

Safe deployment patterns minimize downtime and enable quick rollback. This section covers blue-green, canary, and ring-based strategies for releasing updates to production.

## Patterns

|                                  |                                                                                      |
| -------------------------------- | ------------------------------------------------------------------------------------ |
| [01-blue-green](./01-blue-green) | Two identical environments with instant traffic switching for zero-downtime releases |
| [02-canary](./02-canary)         | Gradual rollout to small user subset before full deployment                          |
| [03-ring](./03-ring)             | Staged deployment across rings with progressive traffic increase                     |

## Links & Resources

[Progressively expose releases using deployment rings](https://learn.microsoft.com/en-us/azure/devops/migrate/phase-rollout-with-rings) — Multi-stage release strategies

[Canary deployment strategy for Kubernetes deployments](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/kubernetes/canary-demo?view=azure-devops&tabs=yaml) — Gradual rollout patterns
