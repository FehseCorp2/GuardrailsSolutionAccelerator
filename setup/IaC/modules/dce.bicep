@description('Specifies the name of the Data Collection Endpoint to create.')
param dataCollectionEndpointName string

@description('Specifies the location for the Data Collection Endpoint.')
param location string = 'westus2'

resource dataCollectionEndpoint 'Microsoft.Insights/dataCollectionEndpoints@2021-04-01' = {
  name: dataCollectionEndpointName
  location: location
  properties: {
    networkAcls: {
      publicNetworkAccess: 'Enabled'
    }
  }
}

output dataCollectionEndpointId string = dataCollectionEndpoint.id
