namespace Challenges;

public static class Utility
{
    public static void Print(int[] a)
    {
        ArgumentNullException.ThrowIfNull(a);
        Console.WriteLine(ToString(a));
    }

    public static string ToString<T>(T[] a)
    {
        ArgumentNullException.ThrowIfNull(a);
        return $"[{string.Join(", ", a)}]";
    }
}
