# Hyper-V

Outdated:
[Windows 10 Hyper-V: Setting up Networking Shared and Bridged Options](https://smudj.wordpress.com/2015/05/14/windows-10-hyper-v-setting-up-networking-shared-and-bridged-options/)


https://smudj.wordpress.com/2016/03/10/adding-nat-to-hyper-v-in-windows-10-and-higher/

```powershell
Parameter Set: NetAdapterName
New-VMSwitch [-Name] <String> -NetAdapterName <String[]> [-AllowManagementOS <Boolean> ] [-CimSession <Microsoft.Management.Infrastructure.CimSession[]> ] [-ComputerName <String[]> ] [-Credential <System.Management.Automation.PSCredential[]> ] [-EnableEmbeddedTeaming <Nullable [System.Boolean]> ] [-EnableIov <Boolean]> ] [-EnablePacketDirect <Nullable [System.Boolean]> ] [-MinimumBandwidthMode <VMSwitchBandwidthMode> {Default | Weight | Absolute | None} ] [-NATSubnetAddress <System.String> ] [-Notes <String> ] [-Confirm] [-WhatIf] [ <CommonParameters>]

Parameter Set: NetAdapterInterfaceDescription
New-VMSwitch [-Name] <String> -NetAdapterInterfaceDescription <String[]> [-AllowManagementOS <Boolean> ] [-CimSession <Microsoft.Management.Infrastructure.CimSession[]> ] [-ComputerName <String[]> ] [-Credential <System.Management.Automation.PSCredential[]> ] [-EnableEmbeddedTeaming <Nullable [System.Boolean]> ] [-EnableIov <Boolean]> ] [-EnablePacketDirect <Nullable [System.Boolean]> ] [-MinimumBandwidthMode <VMSwitchBandwidthMode> {Default | Weight | Absolute | None} ] [-NATSubnetAddress <System.String> ] [-Notes <String> ] [-Confirm] [-WhatIf] [ <CommonParameters>]

Parameter Set: SwitchType
New-VMSwitch [-Name] <String> -SwitchType <VMSwitchType> {Private | Internal | External} [-CimSession <Microsoft.Management.Infrastructure.CimSession[]> ] [-ComputerName <S
```