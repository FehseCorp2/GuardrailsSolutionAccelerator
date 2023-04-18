param parentname string

resource featuresTable 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  name: '${parentname}/NewVersionInfoTable_CL'
  properties: {
    totalRetentionInDays: 31
    plan: 'Analytics'
    schema: {
        name: 'NewVersionInfoTable_CL'
        columns: [
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
              type: 'bool'
            }
            {
              name: 'TimeGenerated'
              type: 'datetime'
            }
        ]
    }
    retentionInDays: 31
  }  
}
