# Notes for .NET Implementations topic content

## Material covered elsewhere

The overall commonalities of .NET implementations were covered in the last topic.

## Material to cover here

The high-level history of .NET, beginning with .NET Framework, including Mono, .NET Core, and now ".NET" (5+).

Also mention UWP, some abandoned 3rd-party implementations from back in the day, and the current 3rd-party implementation nanoFramework.

Briefly talk about AOT compilation since Mono supports it and UWP uses it exclusively with .NET Native, point out this is pretty different from the normal way we learned last topic with IL in assemblies and JIT compilation.

Mention Unity uses Mono for games and Xamarin uses it for mobile dev.

Talk about .NET Standard, try to foresee the many misunderstandings that can be had about it and use clear language.

Most important takeaway is the difference between .NET Framework and .NET Core/5+. Mention that usage of either is about half and half, with .NET Framework declining, especially for new applications, but that code will be running in .NET Framework for a long time because porting it can sometimes be hard.

They should understand what development scenarios .NET (Core/5+) is particularly better than .NET Framework at.

They should also distinguish the C# language version and the .NET version.

## Resources

### References

- https://docs.microsoft.com/en-us/dotnet/core/introduction
- https://docs.microsoft.com/en-us/dotnet/fundamentals/implementations
- https://docs.microsoft.com/en-us/dotnet/standard/net-standard
- https://docs.microsoft.com/en-us/dotnet/standard/glossary
- https://docs.microsoft.com/en-us/dotnet/standard/choosing-core-framework-server

### Some notes

some terms here are increasingly deemphasized in the docs so they don't need to be as prominent as they are here anymore
```
.NET Standard - not an implementation
    versioned set of APIs that are implemented by the
        Base Class Library of a .NET implementation
    libraries can compile targeting .NET Standard and
        the same assembly can be used by any .NET implementation
        compatible with that version of .NET Standard.
    for example: an assembly compiled targeting .NET Standard 2.0
        can be used by .NET Core 2.0+, including .NET 5+,
            and also .NET Framework 4.6 or 4.7+.
        the tradeoff is you can't use all the C# features or
            BCL APIs that some of those runtimes might support, only the ones
            in .NET Standard 2.0.

implementations:
    .NET Framework
        from 2002, original implementation, Windows-only
        deprecated in favor of .NET 6+, but still very common in legacy code.
        still supported with bugfixes and security fixes.
        final version 4.8 released 2019, supporting C# 7.3.
        gets updates from Windows Update
        CLR common language runtime (VES)
            a virtual machine that runs intermediate language
            JIT just in time compiler
                gets assembly, compiles to machine code on the fly
            memory management / garbage collection
            exception handling
            thread management
        FCL framework class library (Standard Libraries)
        implements .NET Standard 2.0, but won't go any further than that
    .NET Core
        from 2016, redesigned and architecturally simplified successor to .NET Framework
        open source, cross-platform, better support for DevOps, command-line, container scenarios
        gets updates from manual installs / NuGet
        .NET Framework frameworks were gradually ported to or redesigned for Core
            (like EF Core, EF 6, ASP.NET Core, WinForms, WPF), finished though
        final version 3.1 released 2019
            (or, latest version is just .NET 6, depending on perspective)
        CoreCLR (VES)
            the CLR for Core
            has a JIT as well, RyuJIT
            all the features of the CLR
        CoreFX (Standard Libraries)
    .NET
        the latest version of .NET Core, rebranded to encourage more migration from .NET Framework,
        now that it's a lot more complete than it used to be.
        latest version 6 released 2021, supporting C# 10.0.
    Mono
        from 2004, open source, cross-platform (Unix)
            originally reverse-engineered from .net framework
            but only some frameworks were implemented
        3rd party at first, adopted by microsoft from 2016
        Mono runtime (VES)
        more support for AOT compilation (alternative to JIT), but JIT too
        used by Xamarin for mobile
            runtimes for iOS, Android, Mac
        used by Unity for games
    UWP
        for windows 10/xbox apps
        uses .NET Native AOT compiler & runtime (VES)
        CoreFx (Standard Libraries), same as .NET Core/5
    older kinda abandoned implementations:
        .NET Compact Framework (Windows Phone)
        Micro Framework (embedded) (new 3rd party successor nanoFramework)
        Portable.NET (hostile 3rd party GNU version)
```

# How to train this material

Lecture, since associates won't know what details are important to the big picture.
