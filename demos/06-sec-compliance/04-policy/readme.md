# Azure Policy

Azure Policy is a governance service that helps enforce organizational standards and assess compliance at scale. It creates guardrails around Azure resources, automatically validating and remediating violations before they create security or cost issues. Using policy definitions, you define rules for resource properties, locations, tagging, and more—then assign them at management group, subscription, or resource group scope where they automatically cascade to all contained resources.

## What It Demonstrates

This demo shows how Azure Policy enforces location restrictions, preventing deployments to unauthorized regions. The practical example uses [create-rg.azcli](create-rg.azcli) to show what happens when you attempt to deploy resources to disallowed regions—policy blocks the operation and provides clear feedback about why the deployment failed.

## How Azure Policy Works

Azure Policy operates at four scope levels:

- **Management Group** — Apply policies across multiple subscriptions for organization-wide governance
- **Subscription** — Enforce policies across all resources in a single subscription
- **Resource Group** — Target specific sets of resources grouped for projects or workloads
- **Resource** — Apply policies to individual resources like web apps or storage accounts

When you assign a policy, Azure automatically evaluates all matching resources against the policy rules. Resources found non-compliant can be automatically remediated, or compliance can be tracked for manual review. Policy definitions use JSON syntax to define the conditions and effects—for example, "deny deployment to regions outside of westeurope and eastus" or "require all resources to have specific tags."

## Interactive Demo Script

The [create-rg.azcli](create-rg.azcli) script demonstrates policy enforcement in action:

```azcli
env=dev
grp=az400-$env
loc=westeurope

az group create -n $grp -l $loc

# This deployment FAILS if policy restricts "brazilsouth" region
az storage account create -l brazilsouth -n $acct -g $grp --sku Standard_LRS

# This deployment SUCCEEDS - allowed region
az storage account create -l $loc -n $acct -g $grp --sku Standard_LRS
```

When the first storage account deployment targets an unauthorized region (brazilsouth), Azure Policy blocks it. The second deployment succeeds because it uses an allowed region (westeurope). This demonstrates how policy acts as an automated guardrail, catching violations at deployment time.

## Common Use Cases

**Enforce Allowed Locations** — Restrict deployments to specific regions for compliance, cost control, or latency management.

**Mandate Tagging Strategy** — Require all resources to have consistent tags for tracking, billing, and organization. Non-compliant resources can be auto-remediated.

**Disallow Expensive Resources** — Block deployments of high-cost services (e.g., P-series SQL databases) to prevent cost surprises.

**Require Diagnostic Logging** — Ensure all resources send logs to a Log Analytics workspace for monitoring and security incident investigation.

**Enforce Encryption Standards** — Require encryption at rest, encryption in transit, or specific key versions for sensitive workloads.

## Tools & Resources

[Azure Policy Overview](https://docs.microsoft.com/en-us/azure/governance/policy/) — Core governance documentation with policy definitions, assignments, and best practices.

[Azure Policy Samples](https://github.com/Azure/azure-policy) — Community-contributed policy definitions and patterns for common scenarios.

[Enforce Cloud Governance Policies](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/govern/enforce-cloud-governance-policies) — Best practices for scaling policy enforcement across your organization.
