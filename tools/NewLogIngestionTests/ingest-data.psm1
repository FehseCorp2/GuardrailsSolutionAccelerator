function New-LogWrite {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $dceurl,
        [string] 
        $dcrImmutableId,
        [string]
        $streamName,
        [string] 
        $data
    )
    #Add-Type -AssemblyName System.Web 
    $bearerToken=(Get-AzAccessToken -resourceUrl "https://monitor.azure.com//.default").Token

    $body = $data;
    $uri = "$dceurl/dataCollectionRules/$dcrImmutableId/streams/$($streamName)?api-version=2021-11-01-preview"
    $headers = @{"Authorization"="Bearer $bearerToken";"Content-Type"="application/json"};
    #$uri
    Invoke-RestMethod -Uri $uri -Method "Post" -Body $body -Headers $headers
    #$uploadResponse
}
