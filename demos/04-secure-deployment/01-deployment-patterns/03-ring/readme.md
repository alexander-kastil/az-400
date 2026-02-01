# Ring based Deployment

In this demo, we will learn how to deploy the same application to different environments using ring based deployment.

Ring based deployment is a deployment pattern where the application is deployed to different environments in a sequential manner. This pattern is useful when you want to test the application in different environments before deploying it to production.

We could have different rings like:

- Ring 1: 10% of users
- Ring 2: 25% of users
- Ring 3: 65% of users

A more common approach is to implement rings using services like:

- Azure App Configuration (Feature Flags)
- Launch Darkly