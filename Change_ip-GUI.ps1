Add-Type -AssemblyName Microsoft.VisualBasic
Add-Type -AssemblyName System.Windows.Forms 
$NewIP = [Microsoft.VisualBasic.Interaction]::InputBox('Enter this machines new IP Address', 'New IP Address', "NewIPAddr")
$NewSub = [Microsoft.VisualBasic.Interaction]::InputBox('Enter this machines new Subnet Mask', 'New Subnet Mask', "NewSubMask")
$NewGat = [Microsoft.VisualBasic.Interaction]::InputBox('Enter this machines new Gateway Address', 'New Gateway Address', "NewGatewayAddr")
[reflection.assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Windows.Forms.Application]::EnableVisualStyles()
##Here you would input the necessary DNS addresses so your workstation can talk to the network. 
netsh.exe int ipv4 set dnsservers "Ethernet" source=static address=x.x.x.x register=both validate=yes
netsh.exe int ipv4 add dnsservers "Ethernet" address=x.x.x.x
netsh.exe int ipv4 add dnsservers "Ethernet" address=x.x.x.x
netsh.exe int ipv4 set address name="Ethernet" Source='static' address=$NewIP mask=$NewSub gateway=$NewGat gwmetric=1 store=persistent
##Uncomment this section if you want to disable IPV6 Addressing. 
<## --netsh.exe interface teredo set state disabled
netsh.exe interface ipv6 6to4 set state state=disabled undoonstop=disabled
netsh.exe interface ipv6 isatap set state state=disabled --##>