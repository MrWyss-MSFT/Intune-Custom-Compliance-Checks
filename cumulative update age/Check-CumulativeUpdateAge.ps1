Function Get-CUs {
    $Session = New-Object -ComObject "Microsoft.Update.Session"
    $Searcher = $Session.CreateUpdateSearcher()
    $HistoryCount = $Searcher.GetTotalHistoryCount()
    $AllUpdates = $Searcher.QueryHistory(1, $HistoryCount)
    Foreach ($CU in $AllUpdates) {
        If (($CU.Categories.count -eq 0) -and ($CU.Title -like "*(KB*)")) {
            new-object psobject -property  @{Title = $CU.Title; Date = $CU.Date }
        }
    }
}

$LCU = Get-CUs | Sort-Object Date | Select-Object -Last 1
$LCUage = 0
If ($LCU.count -ne 0) {
    $LCUage = (New-TimeSpan -Start $LCU.Date -End (get-date)).Days
}

$LCUhash = @{
    #'Update Title'       = $LCU.Title.ToString();
    #'Update Date'        = $LCU.Date.ToString();
    'Update Age In Days' = $LCUage;
}
Return $LCUhash | ConvertTo-Json -Compress