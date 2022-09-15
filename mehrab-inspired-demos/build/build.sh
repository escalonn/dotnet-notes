#!/bin/bash

# .NET build tool for current directory. passes run arguments to app.

# usage: build.sh <COMMANDS>
# example: ../build/build.sh clean "run ../Hello"

clean() {
    find . -iname bin -o -iname obj | xargs rm -rf
}

compile() {
    dotnet build "$@"
}

package() {
    dotnet publish "$@"
}

run() {
    compile --nologo --verbosity quiet -consoleLoggerParameters:NoSummary
    dotnet run --no-build -- "$@"
}

for step in "$@"
do
    $step
done
