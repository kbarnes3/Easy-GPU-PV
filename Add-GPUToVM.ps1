param(
[Parameter(Mandatory=$true)]
[string]$VMName
)

if (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\HyperV)) {
    New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\HyperV
}

Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\HyperV -Name "RequireSecureDeviceAssignment" -Type DWORD -Value 0
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\HyperV -Name "RequireSupportedDeviceAssignment" -Type DWORD -Value 0

if (Get-VMGpuPartitionAdapter -VMName $VMName -ErrorAction SilentlyContinue) {
   Remove-VMGpuPartitionAdapter -VMName $VMName
}
Set-VM -GuestControlledCacheTypes $true -VMName $VMName
Set-VM -LowMemoryMappedIoSpace 1Gb -VMName $VMName
Set-VM -HighMemoryMappedIoSpace 32Gb -VMName $VMName
Add-VMGpuPartitionAdapter -VMName $VMName

Write-Host "GPU-PV configured for $VMName"
