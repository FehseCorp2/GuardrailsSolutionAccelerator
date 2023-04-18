function ingest-data {
param (
    [Parameter(Mandatory = $true)]
    [string]
    $dceurl,
    [string] 
    $dcdImmutableId,
    [string]
    $streamName,
    [string] 
    $data
) 
$body = $data;
$uri = "$dceurl/dataCollectionRules/$dcrImmutableId/streams/$($streamName)?api-version=2021-11-01-preview"
Invoke-AzRestMethod -Uri $uri -Method "Post" -Payload $body
}
