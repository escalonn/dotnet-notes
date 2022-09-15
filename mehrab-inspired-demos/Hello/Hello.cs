// Hello world HTTP server, listens on port 5000

// usage: dotnet Hello.dll
//        dotnet run

using System.Net;
using System.Net.Sockets;
using System.Security;

string text = "Hello, World!";
// assumes text is ASCII; 1 char = 1 UTF-8 byte
string http =
    "HTTP/1.1 200 OK\r\n" +
    $"Content-Length: {text.Length}\r\n" +
    "Content-Type: plain/text\r\n" +
    "\r\n" +
    text;
IPEndPoint endpoint = new(address: IPAddress.Any, port: 5000);

try
{
    using Socket listener =
        new(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
    listener.Bind(endpoint);
    listener.Listen();

    while (true)
    {
        using Socket handler = listener.Accept();
        using NetworkStream stream = new(socket: handler);
        using StreamWriter writer = new(stream);
        writer.Write(http);
    }
}
catch (Exception ex) when
    (ex is SocketException or SecurityException or IOException)
{
    Console.Error.WriteLine("Oops!");
    return 1;
}
