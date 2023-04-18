$resourcegroup='guardrails-6eb08c2c'
# Write-Output "Creating bicep parameters file for this deployment."
# $templateParameterObject = @{
#     'location' = "canadacentral"
#     'dcepointname' = 'lawdce1'
#     'dcrrulename' = 'collectcustomlogs2'
#     'workspaceResourceId' = '/subscriptions/6c64f9ed-88d2-4598-8de6-7a9527dc16ca/resourceGroups/Guardrails-6eb08c2c/providers/Microsoft.OperationalInsights/workspaces/log-cac-6eb08c2c'
# }

# $output=New-AzResourceGroupDeployment -ResourceGroupName $resourcegroup -Name "testdeployment$(get-date -format "ddmmyyHHmmss")" `
#         -TemplateParameterObject $templateParameterObject -TemplateFile .\sol.bicep
# $output

Add-Type -AssemblyName System.Web
### Step 0: Set variables required for the rest of the script.

# information needed to authenticate to AAD and obtain a bearer token
# $tenantId = "6eb08c2c-7812-4ccd-9229-dc1d47f31f6f" #Tenant ID the data collection endpoint resides in
# $appId = "4db9abf8-7669-48db-8b65-b68d34f40be1" #Application ID created and granted permissions
# $appSecret = "zecretpazzword" #Secret created for the application

# information needed to send data to the DCR endpoint
$dceEndpoint = "https://lawdce1-3rg4.canadacentral-1.ingest.monitor.azure.com" #the endpoint property of the Data Collection Endpoint object
$dcrImmutableId = "dcr-41b80d8990a44614a646c64063f63b9d" #the immutableId property of the DCR object
$streamName = "Custom-NewVersionInfoTable_CL" #name of the stream in the DCR that represents the destination table


### Step 1: Obtain a bearer token used later to authenticate against the DCE.

# $scope= [System.Web.HttpUtility]::UrlEncode("https://monitor.azure.com//.default")   
# $body = "client_id=$appId&scope=$scope&client_secret=$appSecret&grant_type=client_credentials";
# $headers = @{"Content-Type"="application/x-www-form-urlencoded"};
# $uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

#$bearerToken = (Invoke-RestMethod -Uri $uri -Method "Post" -Body $body -Headers $headers).access_token

#$bearerToken = Get-AzAccessToken -ResourceTypeName "AadGraph"
### Step 2: Create some sample data. 

$currentTime = Get-Date ([datetime]::UtcNow) -Format O
$staticData = @"
[
{
    "TimeGenerated": "$currentTime",
    "DeployedVersion_s": "v1.0.0",
    "AvailableVersion_s": "v1.0.1",
    "ReportTime_s" : "$currentTime",
    "UpdateNeeded_b": "true"
}
]
"@;
#000000000-0000-0000-00000000000000000

### Step 3: Send the data to the Log Analytics workspace via the DCE.

$body = $staticData;
# $headers = @{"Authorization"="Bearer $bearerToken";"Content-Type"="application/json"};
$uri = "$dceEndpoint/dataCollectionRules/$dcrImmutableId/streams/$($streamName)?api-version=2021-11-01-preview"

Invoke-AzRestMethod -Uri $uri -Method "Post" -Body $body 

# $uploadResponse = Invoke-RestMethod -Uri $uri -Method "Post" -Body $body -Headers $headers
# $uploadResponse