// .NET language server, displays errors and warnings in real time

// usage: dotnet LanguageServer.dll [PROJECT|SOLUTION]
//        dotnet run -- [PROJECT|SOLUTION]
// example: dotnet run --project ../LanguageServer -- .

using System.Diagnostics;

string project = args[0];
string directory =
    File.Exists(args[0]) ? Directory.GetParent(args[0])!.FullName : args[0];
// assumes source directory contains only one solution or project
// enables warnings, silences output besides errors and warnings
ProcessStartInfo dotnetStartInfo = new()
{
    FileName = "dotnet",
    Arguments = $"build \"{project}\" --nologo --verbosity quiet "
        + "-property:WarningLevel=9999 -consoleLoggerParameters:NoSummary",
    RedirectStandardOutput = true
};
Build();
using FileSystemWatcher watcher =
    new(path: directory) { IncludeSubdirectories = true };

while (true)
{
    watcher.WaitForChanged(WatcherChangeTypes.All);
    Build();
}

void Build()
{
    Console.Clear();
    using Process dotnet = Process.Start(dotnetStartInfo)!;
    Console.Write(dotnet.StandardOutput.ReadToEnd());
}
