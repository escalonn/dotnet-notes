namespace P0;

public class Scrabble
{
    public static string Alphabetize(IEnumerable<char> x) =>
        string.Concat(x.OrderBy(c => c));
}
