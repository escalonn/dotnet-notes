using System.Globalization;
using System.Text.RegularExpressions;

namespace Challenges;

public class Capitalizer
{
    // treats string as sequence of char objects, not of displayable characters
    // treats a sequence of word characters (\w in .net regex) as a word
    public string Capitalize(string str)
    {
        ArgumentNullException.ThrowIfNull(str);

        TextInfo textInfo = CultureInfo.CurrentCulture.TextInfo;
        return Regex.Replace(str, @"\w+", m =>
            textInfo.ToTitleCase(m.Value[0].ToString()) + m.Value[1..]);
    }
}
