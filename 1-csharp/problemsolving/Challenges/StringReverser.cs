namespace Challenges;

public class StringReverser
{
    // treats string as sequence of char objects, not of displayable characters
    public string Reverse(string str)
    {
        ArgumentNullException.ThrowIfNull(str);
        return new(str.Reverse().ToArray());
    }
}
