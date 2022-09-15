var which = 3;
new[] { One, Two, Three }[which - 1]();

static int getNumberOfPizzas(int n, int[] a, int[] b) =>
    a.Zip(b, (r, q) => q / r).Min();

static int maxVowel(string s)
{
    int maxCount = 0, currentCount = 0;
    foreach (char c in s.ToUpperInvariant())
        if ("AEIOU".Contains(c)) maxCount = Math.Max(++currentCount, maxCount);
        else currentCount = 0;
    return maxCount;
}

static int findMaximumDivisible(int n)
{
    int result = 0, maxV = 0;
    for (int i = 3; i < n; i++)
    {
        int v = 0;
        for (int j = i; j % 3 is 0; j /= 3) v += 1;
        if (v >= maxV) { maxV = v; result = i; }
    }
    return result;
}

static int[] ReadInts() =>
    Console.ReadLine().Split(' ').Select(int.Parse).ToArray();

static void One()
{
    int n = ReadInts()[0];
    int[] a = ReadInts();
    int[] b = ReadInts();
    int result = getNumberOfPizzas(n, a, b);
    Console.WriteLine(result);
}

static void Two()
{
    string s = Console.ReadLine();
    int result = maxVowel(s);
    Console.WriteLine(result);
}

static void Three()
{
    int n = ReadInts()[0];
    int result = findMaximumDivisible(n);
    Console.WriteLine(result);
}
