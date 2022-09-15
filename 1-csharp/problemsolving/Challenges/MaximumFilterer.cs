namespace Challenges;

public class MaximumFilterer
{
    public int[] FilterMaximum(int[] a)
    {
        ArgumentNullException.ThrowIfNull(a);
        if (a.Length is 0) throw new ArgumentException(
            message: "Array contains no elements.",
            paramName: nameof(a));
        int max = a.Max();
        return a.Where(x => x == max).ToArray();
    }
}
