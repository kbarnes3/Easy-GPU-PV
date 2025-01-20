param(
[Parameter(Mandatory=$true)]
[string]$VMName
)

if (Get-VMGpuPartitionAdapter -VMName $VMName -ErrorAction SilentlyContinue) {
   Remove-VMGpuPartitionAdapter -VMName $VMName
}
Set-VM -GuestControlledCacheTypes $true -VMName $VMName
Set-VM -LowMemoryMappedIoSpace 1Gb -VMName $VMName
Set-VM -HighMemoryMappedIoSpace 32Gb -VMName $VMName
Add-VMGpuPartitionAdapter -VMName $VMName
