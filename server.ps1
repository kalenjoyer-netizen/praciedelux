Add-Type -AssemblyName System.Net
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Server running on http://localhost:8080"

$html = [System.IO.File]::ReadAllText("C:\Users\lubie\Desktop\praciedelux\index.html")
$buffer = [System.Text.Encoding]::UTF8.GetBytes($html)

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $context.Response.ContentType = "text/html; charset=utf-8"
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
        $context.Response.Close()
    }
} finally {
    $listener.Stop()
}
