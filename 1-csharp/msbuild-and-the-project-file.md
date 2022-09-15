# Notes for MSBuild and the Project File topic content

## Material covered elsewhere

Creating and using projects and project references were covered in the previous module, from a "practical" perspective that didn't consider the implementation details. Associates have seen the project file, and know at a high level that it controls "project type" (console app, class library) and project references. Using the .NET CLI to build and publish projects and using solutions were also covered in the previous module.

NuGet, package references, and `dotnet restore` are covered in the next topic.

## Material to cover here

The place of MSBuild in the toolchain, and what responsibilities it has. There should be some understanding of what kind of complexity is "between" `dotnet build` and the C# compiler. Explain the building blocks of MSBuild, properties, items, tasks, targets, and imports. There should be an understanding that this tool dates back to the earliest days of .NET Framework, so it has many options it needs to support that we don't necessarily care about modifying in common development scenarios. Mention that we can set MSBuild properties with `-p:` in .NET CLI commands, and bypass most of the CLI entirely by running `dotnet msbuild`. Mention that MSBuild handles the difference between Release and Debug configurations.

Associates should understand everything in the project files that they have worked with until now: the XML MSBuild format, project SDK, target framework, implicit usings, nullable, output type, project references. Also, `LangVersion`.

Run `dotnet build --verbosity normal` (when `bin/` doesn't yet exist) and find the part of the output for the "CoreCompile" target. This is the command MSBuild constructed to compile the C# code, based on the rules of the project SDK (Microsoft.NET.Sdk) combined with the rest of the things defined in your own project file. `csc.dll` is Roslyn, the modern C# compiler. You can see many DLLs referenced automatically that are part of the base class library. If you set `dotnet build`'s verbosity to detailed, you can see the full set of targets built, and find the MSBuild project files they're all defined in. This build system is very customizable; by setting the right properties or defining your own targets with the right names like "AfterBuild".

Some of the files created by `dotnet build` in the output folder `bin/` should be touched on briefly. Associates should know roughly what most of these files are for, that MSBuild reads the project file to produce them, and the importance of the project SDK for all the default behavior. Because of the relevance of NuGet, this does overlap somewhat with the next topic. The deps.json file lists assembly dependencies for the runtime, since it might need to dynamically locate them, although usually they are copied to the output folder side by side with your own assemblies. The runtimeconfig.json file tells .NET which runtime and which sets of assemblies in it need to be loaded. This folder's assembly appears as a dll (to run like `dotnet App.dll`), and also wrapped in an executable file that can be run directly to do the same thing. The .pdb file (aka symbol file) makes it possible for the debugger to work with the assembly by correlating each part of the assembly with the line of C# source code it came from.

Show an example of a project file, perhaps from an open-source codebase online, that configures additional behavior beyond the defaults. Or something like [this page](https://docs.microsoft.com/en-us/visualstudio/msbuild/walkthrough-creating-an-msbuild-project-file-from-scratch) showing project files that don't rely on a project SDK. The details aren't important, just an appreciation for the scope of the tool.

A key takeaway is that creating projects through the .NET CLI, changing project properties in the Visual Studio GUI, etc. are just convenient shortcuts for something that can be written by hand. The differences between project templates all come down to what's written in the project file and what's written in the C# files. Associates shouldn't be scared of modifying the project file.

## Resources

### References

- https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild
- https://docs.microsoft.com/en-us/visualstudio/msbuild/build-process-overview
- https://docs.microsoft.com/en-us/dotnet/core/project-sdk/overview
- https://docs.microsoft.com/en-us/dotnet/standard/frameworks
- https://stackoverflow.com/a/53889766
- https://github.com/dotnet/sdk/blob/main/documentation/specs/runtime-configuration-file.md
- https://docs.microsoft.com/en-us/nuget/consume-packages/managing-the-global-packages-and-cache-folders (concerning the global-packages folder)

The different properties like `OutputType` and `LangVersion` are documented in various reference pages; they can be found by searching.

# How to train this material

This topic is relatively low priority and could be abbreviated if time pressure required. The following topic is closely tied to this one and the two could be combined or re-ordered in training.
