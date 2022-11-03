$BLStatus = Get-BitLockerVolume -MountPoint C | Select-Object EncryptionMethod, VolumeStatus, ProtectionStatus, EncryptionPercentage 
$Hash = @{
    'EncryptionMethod'      = $BLStatus.EncryptionMethod.ToString();
    'EncryptionPercentage'  = $BLStatus.EncryptionPercentage.ToString();
    'ProtectionStatus'      = $BLStatus.ProtectionStatus.ToString();
    'VolumeStatus'          = $BLStatus.VolumeStatus.ToString();
}
return $Hash | ConvertTo-Json -Compress