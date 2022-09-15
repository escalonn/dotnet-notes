// example: ../../build/build.sh "run ../data/words_alpha.txt cat"

// if (File.ReadLines(args[0])
//         .GroupBy(s => string.Concat(s.OrderBy(c => c)))
//         .ToDictionary(g => g.Key, g => g.ToList())
//         .TryGetValue(string.Concat(args[1].OrderBy(c => c)), out var group))
//     Console.WriteLine(string.Join(", ", group));

using Microsoft.Data.Sqlite;
using P0;

string dictionary = args[0];

string tiles = args[1];

Dictionary<string, List<string>> groups = File.ReadLines(path: dictionary)
    .GroupBy(Scrabble.Alphabetize)
    .ToDictionary(g => g.Key, g => g.ToList());

IEnumerable<List<string>> matches = PowerSet(tiles)
    .Select(Scrabble.Alphabetize)
    .Where(groups.ContainsKey)
    .OrderByDescending(s => s.Length)
    .Select(s => groups[s]);

foreach (List<string> group in matches)
    Console.WriteLine(string.Join(separator: ", ", values: group));

// CreateDatabase();

using SqliteConnection connection = new("Data Source=../data/scrabble.db");
try
{
    connection.Open();
    using SqliteCommand command = new("SELECT * FROM words;", connection);
    using SqliteDataReader reader = command.ExecuteReader();
    reader.Read();
    Console.WriteLine($"Word of the day: {reader.GetString(1)}");
}
catch (SqliteException)
{

}

// if (groups.TryGetValue(tiles, out HashSet<string>? group))
//     Console.WriteLine(string.Join(", ", group));

// foreach (HashSet<string> group in groups.Values.Where(g => g.Count >= 2))
//     Console.WriteLine(string.Join(", ", group));

static IEnumerable<IEnumerable<T>> PowerSet<T>(IEnumerable<T> set) =>
    Enumerable.Range(0, (int)Math.Pow(2, set.Count()))
        .Select(b => set.Where((x, i) => ((1 << i) & b) != 0));

// static void CreateDatabase()
// {
//     using SqliteConnection connection = new("Data Source=../data/scrabble.db");
//     try
//     {
//         using SqliteCommand command =
//             new(File.ReadAllText("schema.sql"), connection);
//         connection.Open();
//         command.ExecuteNonQuery();
//     }
//     catch (SqliteException ex)
//     {
//         Console.Error.WriteLine(ex);
//     }
// }
