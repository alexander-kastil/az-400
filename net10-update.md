# .NET 10 pipeline updates

## Summary

- Updated all .azdo pipeline YAMLs and shared templates that install or declare .NET SDK to use version `10.0.x`.
- Left triggers unchanged and did not modify application source under src/services.

## Files updated

- .azdo/catalog-ci-cd.yml
- .azdo/catalog-ci-cd-app-cfg.yml
- .azdo/catalog-ci-cd-workload-identity.yml
- .azdo/catalog-cd-cd-work-item-gate.yml
- .azdo/catalog-ci-mend.yml
- .azdo/catalog-ci managed-pool.yml
- .azdo/catalog-ci-sonar-cloud.yml
- .azdo/catalog-ci-test-template.yml
- .azdo/catalog-ci-unittest-deploy.yml
- .azdo/catalog-ci.yml
- .azdo/orders-ci docker-img.yml
- .azdo/orders-ci.yml
- .azdo/provision-tf.yml
- .azdo/provision-webapp-bicep.yml
- .azdo/templates/t-net-build.yaml
- .azdo/food-app-common-ci-cd-artifacts.yml
- src/services/order-service/dockerfile
- src/services/prime-service/dockerfile

## Notes

- All `UseDotNet` tasks now request SDK `10.0.x`; display labels updated in shared template.
- No trigger blocks were changed.
