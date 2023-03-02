var location = 'Canada Central'
var lawId='/subscriptions/6c64f9ed-88d2-4598-8de6-7a9527dc16ca/resourceGroups/Guardrails-6eb08c2c/providers/Microsoft.OperationalInsights/workspaces/guardrails-6eb08c2c'
module alertNewVersion 'modules/alert.bicep' = {
    name: 'guardrails-alertNewVersion'
    params: {
      alertRuleDescription: 'Alerts when a new version of the Guardrails Solution Accelerator is available'
      alertRuleName: 'GuardrailsNewVersion'
      alertRuleDisplayName: 'Guardrails New Version Available.'
      alertRuleSeverity: 2
      location: location
      query: 'GR_VersionInfo_CL | summarize total=count() by UpdateAvailable=iff(CurrentVersion_s != AvailableVersion_s, "Yes",\'No\') | where UpdateAvailable == \'Yes\''
      scope: lawId
      autoMitigate: true
      evaluationFrequency: 'PT6H'
      windowSize: 'PT6H'
    }
  }
