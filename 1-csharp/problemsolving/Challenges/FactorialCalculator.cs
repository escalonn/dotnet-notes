namespace Challenges;

public class FactorialCalculator
{
    private static readonly int[] _factorial = new[] {
        1,
        1,
        2,
        6,
        24,
        120,
        720,
        5040,
        40320,
        362880,
        3628800,
        39916800,
        479001600,
        1932053504
    };

    public int Factorial(int n)
    {
        if (n < 0) throw new ArgumentOutOfRangeException(
            paramName: nameof(n),
            actualValue: n,
            message: "N must be nonnegative.");
        if (n >= _factorial.Length) throw new OverflowException(
            "Factorial operation resulted in an overflow.");
        return _factorial[n];
    }
}
