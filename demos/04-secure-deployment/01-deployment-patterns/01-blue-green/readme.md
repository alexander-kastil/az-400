# Blue-Green Deployment

Blue-green deployment runs two identical production environments. **GREEN** serves current traffic while **BLUE** receives new versions. After validation, traffic switches instantly to blue, enabling quick rollback if issues arise.

The [04-01-blue-green-react-aca](/.azdo/blue-green-react-aca.yaml) pipeline demonstrates this pattern:

- Deploys new version to BLUE environment
- Runs approval gate for validation
- Updates CSS to distinguish BLUE from GREEN
- Switches 100% traffic to BLUE
- Retains GREEN for quick rollback

**Key Benefit**: Zero-downtime deployments with instant rollback capability.
