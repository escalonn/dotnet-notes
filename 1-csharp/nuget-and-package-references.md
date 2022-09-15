# Notes for NuGet and Package References topic content

## Material covered elsewhere

Using multiple projects together was covered in the previous module. The previous topic covered MSBuild and the project file.

## Material to cover here

NuGet, our package manager for .NET, for referencing & using code that's not part of the .NET SDK and not part of your codebase, but was published by somebody somewhere else. Define "package," containing one assembly (but sometimes more), and having its own set of dependencies. Justify the need to depend on particular versions of packages, and therefore the existence of dependency version conflicts, and therefore the need for dependency resolution, provided by NuGet. Associates should understand: (1) NuGet the package manager tool integrated in the .NET CLI and Visual Studio, (2) nuget.org, the default central public repository for packages. Anybody can host his own private (or public) NuGet repositories too.

Either before or after that, provide a little historical context, by explaining the Global Assembly Cache in Windows (which associates can look at on their own machines), and the need for developers to manually download the assemblies they needed, and install them into the GAC (which prevented name collisions using "strong names" for assemblies), or else manually manage them in folders alongside their own code. You had to think about where those assemblies would be located both on developer machines, and also on any production machines your app would be running on. NuGet was developed to help automate this process. Later, its configuration was integrated into the project file, and the NuGet tool was integrated into the .NET CLI (and Visual Studio). .NET Core/5+ ignore the GAC and use NuGet for everything. Microsoft publishes lots of code that isn't part of the base class library; they're published on nuget.org. If we manage all dependencies with NuGet, then we never encounter what was once a common occurrence: checkout the code repo on a new machine, try to build, and see errors about not being able to locate assembly references. Now, the first step of build is restore, and restore uses NuGet to find/download all needed assemblies automatically, and without any possible conflicts with other things on the same machine.

Talk about PackageReferences, and the `dotnet add package` or the Package Manager UI in Visual Studio, using some example dependency. Maybe Humanizer.Core for pluralizing words, or something else where the value add of not writing the code yourself is obvious. Maybe this practical example should come before the other material in this topic to better motivate it.

Point out that there are downsides to creating dependencies on other people's code. Bugs or security issues in their code can affect your code. If in the future, a package's maintainer stops updating it to work with new versions of .NET, or makes radical updates to it that are too hard for you to integrate, then it might end up holding you back from updating your code to the new .NET. Or it might just bloat the size of your deployment unnecessarily for one little function you could write yourself. With all this in mind, in a corporate environment there is often little freedom to choose whatever dependencies you want.

Explain `dotnet restore` as being the first step of `dotnet build`, and as an MSBuild target in its own right, using NuGet. Briefly discuss the output of `dotnet restore --verbosity normal` (when `obj/` doesn't yet exist), pointing out the assets file `project.assets.json` that shows NuGet's view of all the dependencies for the project, and the global-packages folder `~/.nuget/packages` where NuGet installs downloaded packages. You'll also see the assemblies from NuGet get copied into the output folder `bin/` during `dotnet build`; the `deps.json` file means that this isn't really necessary for running the app locally, but when we deploy our apps with the help of `dotnet publish`, it's definitely necessary to ship those 3rd-party assemblies side by side with our own, or the app will fail at startup.

## Resources

### References

- https://docs.microsoft.com/en-us/nuget/what-is-nuget
- https://docs.microsoft.com/en-us/dotnet/core/tools/dependencies
- https://docs.microsoft.com/en-us/nuget/reference/msbuild-targets#restore-outputs

# How to train this material

The previous topic is closely tied to this one and the two could be combined or re-ordered in training.
