# Notes for Common Language Infrastructure topic content

## Material covered elsewhere

The high-level introductory basics of .NET code being compiled into assemblies and executed in a runtime are covered in previous modules. The associate has heard of the CLR and some of its features.

Laying out the individual .NET implementations, plus .NET Standard, and focusing on their differences, is the task of the next topic.

Garbage collection is covered in the last topic in this module.

## Material to cover here

The commonalities in (most) all .NET implementations, the standardization that allows for flexibility in source language, target architecture, runtime architecture, different implementations of the toolchain, etc.

In particular: the CLR (including JIT and other features), the base class library, the Common Type System, and assemblies. Mention (without need for details) the portable executable (PE) format for assemblies, the metadata in the assemblies, and the IL in the assemblies.

Associates should learn that several important features of C# are not restricted to C# or to .NET 6, but shared with other languages like F# and other .NET implementations. They should appreciate that a new language could be developed tomorrow and plug into all this infrastructure, or a new operating system or CPU architecture, and more-or-less only one component in the .NET toolchain has to be replaced while all the others can be reused.

Give an example of a recently new feature in C# which required changes to the runtime and the IL, and an example of a recently new feature in C# which is only an abstraction in C# and disappears once you get to the IL (like record types). Point out that there are a few things IL supports that C# has no syntax for, but other languages do.

Mention the term Common Language Infrastructure somewhere, but it doesn't need to be something they're evaluated on.

### Example evaluation questions

- why can the same .NET assemblies execute on both Windows and Mac computers?
- if you design a new .NET language based on C#, what will you definitely have to implement? (just a compiler to IL, nothing else)

## Resources

### References

- https://docs.microsoft.com/en-us/dotnet/standard/glossary
- https://docs.microsoft.com/en-us/dotnet/standard/clr
- https://docs.microsoft.com/en-us/dotnet/standard/assembly/ (not many details needed)
- https://docs.microsoft.com/en-us/dotnet/standard/metadata-and-self-describing-components (not many details needed)
- https://docs.microsoft.com/en-us/dotnet/standard/common-type-system (CLS not really needed)
- https://docs.microsoft.com/en-us/dotnet/standard/framework-libraries, https://docs.microsoft.com/en-us/dotnet/standard/runtime-libraries-overview (these pages overlap)
- https://docs.microsoft.com/en-us/dotnet/csharp/tour-of-csharp/#net-architecture (good summary in this section)

### Some notes

some terms here are increasingly deemphasized in the docs so they don't need to be as prominent as they are here anymore
```
CLI common language infrastructure specification
the standardized set of things all .NET implementations have.
    VES virtual execution system, aka the runtime.
        the execution environment for a .NET application
    Standard Libraries
        includes:
        BCL base class library
            common data types for numbers, strings, etc.
            exceptions, attributes, collections, delegates, I/O, threads
        also reflection, networking, parallel programming
    CTS common type system
        defines classes, structs, enums, interfaces, delegates,
        access modifiers, inheritance, value/reference types, etc.
```

# How to train this material

Since there's a lot of interrelated abstractions, this topic should involve plenty of lecture and/or guided group discussion. Conceptual diagrams would be helpful. Possibly some parts could be left to asynchronous learning, but it's hard for associates to know what level of detail is useful.

There's plenty of arguably non-essential detail in this topic, but associates need some foundation to be able to confidently answer questions like the example evaluation questions given.
