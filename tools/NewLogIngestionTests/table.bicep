param parentname string

resource guardrailscompliance 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  name: '${parentname}/guardrailscompliance_CL'
  properties: {
    totalRetentionInDays: 31
    plan: 'Analytics'
    schema: {
        name: 'guardrailscompliance_CL'
        columns: [
            {
                name: 'ADLicenseType_s'
                type: 'string'
            }
            {
              name: 'Comments_s'
              type: 'string'
            }
            {
              name: 'ComplianceStatus_b'
              type: 'string'
            }
            {
              name: 'ControlName_s'
              type: 'string'
            }
            {
              name: 'DisplayName_s'
              type: 'string'
            }
            {
              name: 'DocumentName_s'
              type: 'string'
            }
            {
              name: 'Id_g'
              type: 'string'
            }
            {
              name: 'Id_s'
              type: 'string'
            }
            {
              name: 'ItemName_s'
              type: 'string'
            }
            {
              name: 'itsgcode_s'
              type: 'string'
            }
            {
              name: 'MitigationCommands_s'
              type: 'string'
            }
            {
              name: 'Name_g'
              type: 'string'
            }
            {
              name: 'Name_s'
              type: 'string'
            }
            {
              name: 'ReportTime_s'
              type: 'string'
            }
            {
              name: 'Required_s'
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
