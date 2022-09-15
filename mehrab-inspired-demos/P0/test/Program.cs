// example: dotnet run --project ../test

using System.Reflection;
using P0;

Console.WriteLine("Running P0 tests...");
int passed = 0, failed = 0;
IEnumerable<MethodInfo> testMethods = typeof(UnitTests).GetMethods()
    .Where(m => m.GetCustomAttributes(typeof(UnitTestAttribute)).Any());
foreach (MethodInfo method in testMethods)
{
    try
    {
        object? tests = Activator.CreateInstance(typeof(UnitTests));
        method.Invoke(obj: tests, parameters: Array.Empty<object>());
        passed++;
        Console.WriteLine($"Test {method.Name} passed!");
    }
    catch (TargetInvocationException ex)
    {
        failed++;
        Console.Error.WriteLine(
            $"Test {method.Name} failed: {ex.InnerException}");
    }
}
Console.WriteLine($"Passed: {passed}, Failed: {failed}");

/// <summary>
/// Marks a method in the UnitTests class as a unit test for P0Tests
/// </summary>
[AttributeUsage(AttributeTargets.Method)]
class UnitTestAttribute : Attribute { }

/// <summary>
/// Contains unit tests for P0 with the UnitTestAttribute meant to be invoked
/// with reflection.
/// </summary>
class UnitTests
{

    [UnitTest]
    public void TestConstructor()
    {
        _ = new Scrabble();
    }

    [UnitTest]
    public void TestAlphabetize()
    {
        string expected = "act";
        string actual = Scrabble.Alphabetize("cat");
        if (expected != actual)
            throw new Exception("Fail");
    }

    [UnitTest]
    public void TestDictionaryScan()
    {
        using FileStream file =
            File.Open("../data/words_alpha.txt", FileMode.Open);
    }
}
