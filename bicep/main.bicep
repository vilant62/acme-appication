targetScope = 'resourceGroup'

param image string
param imageTag string
param appName string

var location = 'northeurope'

resource farmapp 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: '${appName}-serverfarm'
  location: location
  properties: {
    workloadProfiles: [
      { name: 'Consumption', workloadProfileType: 'Consumption' }
    ]
  }
}

resource containerapp 'Microsoft.App/containerApps@2024-03-01' = {
  name: appName
  location: location
  properties: {
    managedEnvironmentId: farmapp.id
    configuration: {
      ingress: {
        external: true
        targetPort: 8080
        allowInsecure: false
        transport: 'auto'
      }
    }
    template: {
      containers: [
        {
          name: 'evision-app'
          image: '${image}:${imageTag}'
        }
      ]
      scale: {
        minReplicas: 0
        maxReplicas: 1
      }
    }
  }
}

output containerAppUrl string = containerapp.properties.configuration.ingress.fqdn
