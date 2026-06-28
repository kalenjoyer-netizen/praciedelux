$code = @"
using System;
using System.Net;
using System.Text;
using System.IO;

class Server {
    static void Main() {
        var listener = new HttpListener();
        listener.Prefixes.Add("http://localhost:3000/");
        listener.Start();
        Console.WriteLine("Server running on http://localhost:3000");
        
        byte[] buffer = File.ReadAllBytes("C:\\Users\\lubie\\Desktop\\praciedelux\\index.html");
        
        while (true) {
            var ctx = listener.GetContext();
            ctx.Response.ContentType = "text/html; charset=utf-8";
            ctx.Response.ContentLength64 = buffer.Length;
            ctx.Response.OutputStream.Write(buffer, 0, buffer.Length);
            ctx.Response.Close();
        }
    }
}
"@

Add-Type -TypeDefinition $code -OutputAssembly "C:\Users\lubie\Desktop\praciedelux\server.exe" -OutputType ConsoleApplication
Write-Host "Compiled. Starting server on port 3000..."
& "C:\Users\lubie\Desktop\praciedelux\server.exe"
