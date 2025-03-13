Background
================

The ACME company wants the candidate to deploy their new super duper web application to AWS
or Azure. The company employs some pretty interesting developers and they can on occasion play
russian roulette on the instances. The candidate should keep this in mind (Don't ask why they have
access to production).

Dependencies
-----

The application has no dependencies.

Problem 1
-----

Use any tool to be able to create a repeatable and predictable product deployment.
Restrictions
There are no restrictions and the candidate should see this as an opportunity to showcase their
ability to perform repeatable and predictable deployments to one of the cloud providers listed
(AWS/Azure).
Verification
The deployment can be verified by issuing a web request to http://{ip}:8080/success

Problem 2
----

The application has been updated and the candidate is required to deploy a new version of the
application and take into consideration that downtime should be minimized.

----

Solution 1
----

Use Azure Container App
-----

[![Deployment](https://github.com/vilant62/acme-appication/actions/workflows/deployment.yaml/badge.svg)](https://github.com/vilant62/acme-appication/actions/workflows/deployment.yaml)

[Application link](https://acme-super-app.calmwater-5ff97f3e.northeurope.azurecontainerapps.io/success)

Azure Container Apps provides a streamlined approach for creating consistent and reliable deployments using GitHub Actions. The deployment process is defined in the GitHub Actions workflow file [deployment.yaml](.github/workflows/deployment.yaml). This workflow encompasses a single job that performs three key tasks: building a Docker container, pushing it to the registry, and deploying it to Azure Cloud.
The deployment configuration utilizes Azure Bicep, a domain-specific language for declaratively deploying Azure resources. The [main.bicep](./bicep/main.bicep) file, defines all the necessary resources required to run the application. This approach allows a more manageable and reproducible infrastructure-as-code setup.

Solution 2
----

Use multiple revisions for containers in Container App
----

The Azure container app provides a build-in functionality of gradual rollouts and easier rollbacks if issues arise. The zero-downtime deployment workflow:

- Redirect traffic to the latest active revision by name, avoiding the "latest" revision alias
- Deploy a new revision without traffic
- Wait for the new revision to be fully provisioned and healthy
- Gradually shift traffic to the new revision
