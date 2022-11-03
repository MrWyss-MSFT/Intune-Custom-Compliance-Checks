$SearchString = "*Cumulative Update for Windows 1*"
$Session = New-Object -ComObject "Microsoft.Update.Session"
$Searcher = $Session.CreateUpdateSearcher()
$HistoryCount = $Searcher.GetTotalHistoryCount()
$CUs = $Searcher.QueryHistory(1, $HistoryCount) 
$LCU = $CUs | Where-Object Title -like $SearchString | Where-Object ResultCode -eq 2 | Sort-Object Date | Select-Object -Last 1
$LCUage = (New-TimeSpan -Start $LCU.Date -End (get-date)).Days
$LCUhash = @{
    #'Update Title'       = $LCU.Title.ToString();
    #'Update Date'        = $LCU.Date.ToString();
    'Update Age In Days' = $LCUage;
}
Return $LCUhash | ConvertTo-Json -Compress