@description('Specifies the name of the Data Collection Rule to create.')
param dataCollectionRuleName string

@description('Specifies the location in which to create the Data Collection Rule.')
param location string

@description('Specifies the Azure resource ID of the Log Analytics workspace to use.')
param workspaceResourceId string

@description('Specifies the Azure resource ID of the Data Collection Endpoint to use.')
param endpointResourceId string

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: dataCollectionRuleName
  location: location
  properties: {
    dataCollectionEndpointId: endpointResourceId
    streamDeclarations: {
      'Custom-NewVersionInfoTable_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'datetime'
          }
          {
            name: 'DeployedVersion_s'
            type: 'string'
          }
          {
            name: 'AvailableVersion_s'
            type: 'string'
          }
          {
            name: 'ReportTime_s'
            type: 'string'
          }
          {
            name: 'UpdateNeeded_b'
            type: 'boolean'
          }
        ]
      }
    }
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'guardrails'

        }
      ]
    }
    dataFlows: [
      {
        streams: [
          'Custom-NewVersionInfoTable_CL'
        ]
        destinations: [
          'guardrails'
        ]
        // transformKql: 'source | extend jsonContext = parse_json(AdditionalContext) | project TimeGenerated = Time, Computer, AdditionalContext = jsonContext, CounterName=tostring(jsonContext.CounterName), CounterValue=toreal(jsonContext.CounterValue)'
        //outputStream: 'Custom-MyTable_CL'
      }
    ]
  }
}

output dataCollectionRuleId string = dataCollectionRule.id
output dcrimmutableId string = dataCollectionRule.properties.immutableId

