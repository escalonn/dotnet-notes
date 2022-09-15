namespace Challenges;

public class AnagramChecker
{
    // treats string as sequence of char objects, not of displayable characters
    public bool IsAnagram(string first, string second) =>
        first.OrderBy(c => c).SequenceEqual(second.OrderBy(c => c));
}
