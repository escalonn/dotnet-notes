namespace Challenges;

public class FibonacciGenerator
{
    public int GetFibonacciNumber(int n)
    {
        if (n < 0) throw new ArgumentOutOfRangeException(
            paramName: nameof(n),
            actualValue: n,
            message: "N must be nonnegative.");
        var f = new List<int>(n) { 0, 1 };
        return Recurse(n);

        int Recurse(int n)
        {
            if (n >= f.Count) f.Add(Recurse(n - 1) + Recurse(n - 2));
            return f[n];
        }
    }
}
