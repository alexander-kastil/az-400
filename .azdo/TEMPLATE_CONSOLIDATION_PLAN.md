# Azure DevOps Template Consolidation Plan

## Current State

### Redundant Templates

1. **Build Image Templates:**
   - `t-build-acr-image.yaml` - Uses ACR build task (checks if image exists before building)
   - `t-build-docker-image.yaml` - Uses Docker@2 task (no existence checks)

2. **Deploy Container Apps Templates:**
   - `t-deploy-container-app.yaml` - Steps-based template (includes create/update logic)
   - `t-deploy-aca.yaml` - Stage-based template with credential fetching

3. **Resource Checking:**
   - `t-check-containers.yaml` - Separate template that checks if image and container app exist

### Current Usage

**Build Image:**

- `azure-load-test.yml` - Uses `t-build-acr-image.yaml` + `t-check-containers.yaml`
- `react-playwright-e2e.yaml` - Uses `t-build-docker-image.yaml` + `t-check-containers.yaml`

**Deploy Container Apps:**

- `react-playwright-e2e.yaml` - Uses `t-deploy-container-app.yaml` (steps)
- `angular-ci-cd-aca.yml` - Uses `t-deploy-aca.yaml` (stages)
- `catalog-cd-aca.yml` - Uses `t-deploy-aca.yaml` (stages)

## Target State

### Consolidated Templates

1. **t-build-docker-image.yaml** (consolidated)
   - Keep: Docker@2 task approach (more flexible for ACR)
   - Add: Embedded resource existence check
   - Add: `override` parameter (default: false)
   - Logic:
     - If override=false and image exists → exit with success
     - Otherwise → build and push image

2. **t-deploy-container-app.yaml** (consolidated)
   - Keep: Steps-based approach (easier for inline scripts)
   - Add: Embedded resource existence check
   - Add: `override` parameter (default: false)
   - Logic:
     - If override=false and container app exists → exit with success
     - Otherwise → create/update container app

3. **Delete:**
   - `t-build-acr-image.yaml` (consolidate into t-build-docker-image.yaml)
   - `t-deploy-aca.yaml` (consolidate into t-deploy-container-app.yaml)
   - `t-check-containers.yaml` (move logic into build/deploy templates)

### Pipeline Updates

1. **azure-load-test.yml**
   - Remove: `t-check-containers.yaml` template reference
   - Update: `t-build-acr-image.yaml` → `t-build-docker-image.yaml` with `override: false`
   - Update: Deploy stage to use `t-deploy-container-app.yaml` with `override: false`

2. **react-playwright-e2e.yaml**
   - Remove: `t-check-containers.yaml` template reference
   - Update: `t-build-docker-image.yaml` with `override: false` parameter
   - Update: `t-deploy-container-app.yaml` with `override: false` parameter

3. **angular-ci-cd-aca.yml**
   - Update: `t-deploy-aca.yaml` → `t-deploy-container-app.yaml` (convert stages to job steps or keep job structure)
   - Add: `override: false` parameter

4. **catalog-cd-aca.yml**
   - Update: `t-deploy-aca.yaml` → `t-deploy-container-app.yaml` (convert stages to job steps or keep job structure)
   - Add: `override: false` parameter

## Implementation Steps

1. Create consolidated `t-build-docker-image.yaml` with:
   - Parameter: `override` (boolean, default: false)
   - Check if image exists in registry
   - Build/push only if override=true or image doesn't exist
   - Return success in both cases

2. Create consolidated `t-deploy-container-app.yaml` with:
   - Parameter: `override` (boolean, default: false)
   - Check if container app exists
   - Deploy only if override=true or app doesn't exist
   - Return success in both cases
   - Handle credential fetching from ACR (from t-deploy-aca.yaml)

3. Update `azure-load-test.yml`:
   - Remove t-check-containers stage
   - Update build stage to use consolidated template
   - Simplify deploy stage logic

4. Update `react-playwright-e2e.yaml`:
   - Remove t-check-containers stage
   - Update build stage
   - Update deploy stage

5. Update `angular-ci-cd-aca.yml`:
   - Convert from stage-based to job-based approach
   - Use consolidated template

6. Update `catalog-cd-aca.yml`:
   - Convert from stage-based to job-based approach
   - Use consolidated template

7. Delete obsolete templates:
   - `t-build-acr-image.yaml`
   - `t-deploy-aca.yaml`
   - `t-check-containers.yaml`

## Benefits

- **Single source of truth** for each operation (build image, deploy app)
- **Consistent behavior** across all pipelines
- **Reduced duplication** and maintenance burden
- **Flexible override flag** for CI/CD scenarios requiring forced rebuild/redeploy
- **Simplified pipeline code** by removing separate check templates
