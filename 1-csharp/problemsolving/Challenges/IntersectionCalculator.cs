namespace Challenges;

public class IntersectionCalculator
{
    public int[] Intersection(int[] a, int[] b)
    {
        ArgumentNullException.ThrowIfNull(a);
        ArgumentNullException.ThrowIfNull(b);
        return a.Intersect(b).ToArray();
    }
}
