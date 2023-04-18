param location string
param dcepointname string
param dcrrulename string
param workspaceResourceId string

var parentname = split(workspaceResourceId, '/')[8]

module dce 'dce.bicep' = {
  name: 'dce'
  params: {
    dataCollectionEndpointName: dcepointname
    location: location
  }
}
module dcr 'dcr.bicep' = {
  name: 'dcr'
  params: {
    dataCollectionRuleName: dcrrulename
    location: location
    endpointResourceId: dce.outputs.dataCollectionEndpointId
    workspaceResourceId: workspaceResourceId
  }
  dependsOn: [
    dce
    table
  ]
}

module table 'table.bicep' = {
  name: 'table'
  params: {
    parentname: parentname
  }
}
output dceEnpoint string = dce.outputs.dataCollectionEndpointId
output dceimmutableId string = dcr.outputs.dcrimmutableId
