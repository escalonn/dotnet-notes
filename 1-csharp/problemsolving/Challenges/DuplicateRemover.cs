namespace Challenges;

public class DuplicateRemover
{
    static void Main()
    {
        Console.WriteLine(string.Join(',',
            new DuplicateRemover().RemoveDuplicates(new[] { 1, 2, 2, 2, 5, 4, 2, 1 })));
    }

    // builds a new array
    public int[] RemoveDuplicates(int[] a)
    {
        ArgumentNullException.ThrowIfNull(a);

        var b = new int[a.Length];
        for (int i = 0; i < b.Length; i++)
        {
            int j;
            for (j = i; j > 0 && b[j - 1] > a[i]; j--)
                b[j] = b[j - 1];
            b[j] = a[i];
        }

        return b;
    }
}
