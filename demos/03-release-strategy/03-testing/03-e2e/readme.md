# End-to-End Testing with Playwright

This demo showcases automated end-to-end (E2E) testing for the **React Food Shop** application using [Playwright](https://playwright.dev/). The tests run against a containerized React app deployed to Azure Container Apps, validating user interactions, UI rendering, and application behavior in a production-like environment.

## What is Playwright?

[Playwright](https://playwright.dev/) is a modern browser automation framework that:

- **Cross-browser testing**: Run tests on Chromium, Firefox, and WebKit
- **Realistic testing**: Automates real browser interactions (clicks, typing, navigation)
- **Developer experience**: Simple API with excellent debugging tools and IDE integration
- **Performance**: Parallel test execution with built-in retries and timeouts
- **Reporting**: HTML reports with screenshots and video recordings on failure

## Pipeline Architecture

The [react-playwright-e2e.yaml](/.azdo/react-playwright-e2e.yaml) pipeline demonstrates a complete CI/CD workflow:

1. **Build Stage**: Containerizes the React app in Azure Container Registry
2. **Deploy Stage**: Deploys the container to Azure Container Apps
3. **Test Stage**: Installs Playwright, retrieves the deployed app URL, and runs E2E tests
4. **Reporting**: Publishes test results and generates HTML reports

## Quick Start - Local Development

### Prerequisites

Install Node.js 22.x or higher, then install Playwright:

```bash
npm install --save-dev @playwright/test
npx playwright install
```

### Run Tests Locally

Navigate to the React app and run tests:

```bash
cd src/react/react-devops

# Run tests headless (default)
npm run test:e2e

# Run tests with visible browser
npm run test:e2e:headed

# Debug mode with step-through execution
npm run test:e2e:debug

# View HTML report from last run
npm run test:e2e:report
```

### Test Configuration

The [playwright.config.ts](../../src/react/react-devops/playwright.config.ts) file configures:

- **Base URL**: `http://localhost:4173` (auto-starts dev server)
- **Timeout**: 30 seconds per test
- **Retries**: On-first-failure with screenshots and videos
- **Browsers**: Chromium (add Firefox/WebKit in projects array)

### Example Test

Tests are located in `e2e/playwright/` and use a simple, readable API:

```typescript
import { test, expect } from '@playwright/test'

test.describe('App E2E', () => {
    test('renders heading text', async ({ page }) => {
        await page.goto('/')
        await expect(page.getByRole('heading', { level: 1, name: 'React Food Shop' })).toBeVisible()
    })

    test('increments count on button click', async ({ page }) => {
        await page.goto('/')
        const button = page.getByRole('button', { name: 'Click Me!' })
        const paragraph = page.locator('p')

        await expect(paragraph).toContainText('Button clicked 0 times')
        await button.click()
        await expect(paragraph).toContainText('Button clicked 1 times')
    })
})
```

## Artifacts

- [react-playwright-e2e.yaml](/.azdo/react-playwright-e2e.yaml) — Azure Pipelines workflow for automated E2E testing with Playwright
- [t-playwright-tests.yaml](/.azdo/templates/t-playwright-tests.yaml) — Reusable pipeline template for running Playwright tests
- [playwright.config.ts](../../src/react/react-devops/playwright.config.ts) — Playwright configuration with browser settings and test discovery
- [app.e2e.spec.ts](../../src/react/react-devops/e2e/playwright/app.e2e.spec.ts) — Example test suite validating React Food Shop functionality
