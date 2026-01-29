# Blue-Green Deployment Pattern

This demo showcases a **blue-green deployment** strategy for the React application running on **Azure Container Apps** with **Azure DevOps pipelines**.

## Overview

Blue-green deployment is a release technique that minimizes downtime and risk by running two identical production environments:

- **GREEN** - Current production (lightgreen background)
- **BLUE** - New version (lightblue background)

Traffic switches between environments after validation, enabling quick rollback if issues arise.

## Demonstrations

### 1. Basic Blue-Green Pipeline

- **File**: [.azdo/blue-green.yaml](../../../.azdo/blue-green.yaml)
- **Stages**:
  1. Build React app
  2. Deploy GREEN revision (lightgreen background)
  3. Manual approval gate
  4. Update CSS: change `background-color` to `lightblue`
  5. Build and deploy BLUE revision
  6. Switch 100% traffic to BLUE
  7. Optional cleanup of GREEN

### 2. Blue-Green with Approval Gate

- **Environment**: `aca-blue-green-approval` (created in Azure DevOps)
- **Approvers**: DevOps team, Release manager
- **Timeout**: 7 days
- **Gate Checks**:
  - GREEN deployment is healthy and stable
  - Application functionality verified
  - Performance metrics acceptable
  - Ready to proceed with BLUE deployment

### 3. Ring Deployment (Future)

- Canary pattern with gradual traffic shift
- 10% → 25% → 50% → 100% traffic to BLUE
- Error rate and latency monitoring between rings
- Automatic or manual promotion

## Quick Start

### Prerequisites

- Azure DevOps project: `az-400`
- Service connection: `wi-az400-dev` (workload identity federation)
- Azure Container Apps environment: `az400acaenv`
- Resource group: `az400-dev`
- Container registry: `az400acrdev`

### Setup

#### 1. Create Azure DevOps Environment

```bash
# In Azure DevOps: Project Settings > Pipelines > Environments
# Create new environment: aca-blue-green-approval
# Configure approvers (optional)
```

#### 2. Import Pipeline

```bash
# Option A: Via Azure DevOps UI
# - Go to Pipelines > Create Pipeline
# - Select GitHub (or local repo)
# - Choose existing YAML: .azdo/blue-green.yaml

# Option B: Via Azure CLI
az pipelines create \
  --name "04-01-react-blue-green-aca" \
  --yaml-path .azdo/blue-green.yaml \
  --org https://dev.azure.com/integrationsonline \
  --project az-400
```

#### 3. Run Pipeline

```bash
# Trigger manually in Azure DevOps or via CLI
az pipelines run \
  --name "04-01-react-blue-green-aca" \
  --org https://dev.azure.com/integrationsonline \
  --project az-400
```

#### 4. Monitor Deployment

- Watch build logs for React build and Docker image creation
- Verify GREEN deployment completes
- **Approve blue deployment** in Azure DevOps (Approval Gate stage)
- Monitor BLUE deployment and traffic switch
- Access application at: `https://react-blue-green.[region].azurecontainerapps.io`

## Pipeline Stages Explained

### Stage 1: Build React App

```yaml
- Install Node.js 22.x
- npm ci (clean install)
- npm run lint
- npm run build → dist/
- Publish artifacts
```

**Output**: Build artifacts ready for Docker image creation.

### Stage 2: Deploy GREEN Revision

```yaml
- Build Docker image tagged "green-{BuildId}"
- Push to ACR
- Create or update container app
- Route 100% traffic to GREEN revision
```

**Background Color**: `lightgreen` (original)

**Verification**: Application accessible via public FQDN

### Stage 3: Approval Gate

```yaml
- Manual approval required
- 7-day timeout
- Review checklist:
  - Is GREEN healthy?
  - Is functionality verified?
  - Are metrics acceptable?
  - Ready for BLUE?
```

**Decision Point**: Proceed to BLUE deployment or reject/cancel

### Stage 4: Update CSS & Build BLUE

```yaml
- Update App.css: lightgreen → lightblue
- npm ci & npm run build (with new CSS)
- Build Docker image tagged "blue-{BuildId}"
- Push to ACR
```

**Background Color**: `lightblue` (updated)

### Stage 5: Deploy & Switch Traffic to BLUE

```yaml
- Deploy BLUE revision to ACA
- Wait for revision to reach "Running" state
- Switch ingress traffic: 100% to BLUE revision
- GREEN revision remains inactive but available for rollback
```

**Result**: All traffic now flows to BLUE (lightblue background)

### Stage 6: Cleanup & Reporting

```yaml
- List all revisions
- Optional: Deactivate GREEN revision
- Print deployment summary
```

## Architecture Diagram

```
┌──────────────────────────────────────────────────────────┐
│           Azure Container Apps: react-blue-green         │
├──────────────────────────────────────────────────────────┤
│                                                            │
│  ┌─────────────────┐         ┌─────────────────┐        │
│  │   GREEN         │         │    BLUE         │        │
│  │  Revision       │         │  Revision       │        │
│  │  (lightgreen)   │         │ (lightblue)     │        │
│  │                 │         │                 │        │
│  │  Image:         │         │  Image:         │        │
│  │  green-{ID}     │         │  blue-{ID}      │        │
│  │                 │         │                 │        │
│  │  Traffic: 0%    │◄────────│  Traffic: 100%  │        │
│  └─────────────────┘         └─────────────────┘        │
│           ▲                            ▲                 │
│           │ (After approval+CSS update) │                │
│           │ (After deactivation)       │                │
│           └────────────────────────────┘                │
│                                                            │
│  External Ingress (FQDN): react-blue-green.xxx...       │
└──────────────────────────────────────────────────────────┘
```

## Rollback Strategy

If BLUE deployment has issues:

1. **Quick Rollback**: Switch traffic back to GREEN (30 seconds)

   ```bash
   az containerapp ingress traffic set \
     -n react-blue-green \
     -g az400-dev \
     --revision-weights "green-{ID}=100"
   ```

2. **Deactivate BLUE**: Disable BLUE revision

   ```bash
   az containerapp revision deactivate \
     -n react-blue-green \
     -g az400-dev \
     -r blue-{ID}
   ```

3. **Investigate**: Review BLUE logs and fix issues

4. **Redeploy**: Run pipeline again with fixes

## Monitoring & Validation

### During GREEN Deployment

- Check application loads with lightgreen background
- Verify no console errors
- Test interactive elements (buttons, cards)

### During Approval Gate

- Review Azure Monitor metrics
- Check Application Insights error rates
- Verify response times acceptable

### During Traffic Switch

- Monitor error rate spike (should be minimal)
- Watch response time changes
- Confirm lightblue background appears

### Post-Deployment

```bash
# Get application URL
az containerapp show -n react-blue-green -g az400-dev \
  --query "properties.configuration.ingress.fqdn"

# List all revisions and traffic
az containerapp revision list -n react-blue-green -g az400-dev \
  -o table

# View traffic distribution
az containerapp ingress traffic show -n react-blue-green -g az400-dev
```

## Configuration Reference

See [PLAN.md](./PLAN.md) for:

- Detailed architecture
- Configuration values from `deploy.json`
- CSS changes
- Implementation notes
- References and links

## Best Practices

1. **Approval Gate**: Always require human approval before switching production traffic
2. **Gradual Rollout**: Consider canary pattern (10% → 25% → 50% → 100% traffic)
3. **Health Checks**: Implement proper health endpoints in React app
4. **Monitoring**: Set up alerts for error rates, latency, and resource usage
5. **Revision Retention**: Keep 2-3 revisions for quick rollback
6. **Testing**: Run smoke tests on BLUE before full traffic switch
7. **Documentation**: Track why each approval was granted/denied

## Troubleshooting

### Pipeline Fails at Build Stage

- Check Node.js version compatibility
- Verify npm dependencies installable
- Review lint errors in build output

### GREEN Deployment Fails

- Check ACR credentials and permissions
- Verify ACA environment exists and is healthy
- Review container app creation parameters

### Approval Gate Timeout

- Increase timeout in pipeline YAML (timeoutInMinutes)
- Ensure approvers are configured in environment
- Check Azure DevOps notifications

### BLUE Deployment Fails

- Verify CSS update was successful
- Check Docker image build logs
- Review ACR push errors

### Traffic Switch Fails

- Confirm BLUE revision is in "Running" state
- Check revision name spelling
- Verify ingress configuration supports multiple revisions

## Next Steps

1. Run the pipeline and observe green deployment
2. Approve blue deployment in approval gate
3. Verify lightblue background after traffic switch
4. Explore gradual traffic shifting (canary pattern)
5. Add automated health checks and smoke tests
6. Integrate with Azure Monitor for continuous monitoring

## References

- [PLAN.md](./PLAN.md) - Detailed implementation plan
- [.azdo/blue-green.yaml](../../../.azdo/blue-green.yaml) - Pipeline YAML source
- [Azure Container Apps Revisions](https://learn.microsoft.com/en-us/azure/container-apps/revisions)
- [Blue-Green Deployment Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/blue-green-deployment)
- [Azure DevOps Environments & Approvals](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments)
- [React App Source](../../../src/react/react-devops)
