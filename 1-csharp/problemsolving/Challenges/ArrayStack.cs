namespace Challenges;

public class ArrayStack<T> : IStack<T>
{
    public int Length => Top;

    protected int Top { get; set; }

    protected T[] Items { get; set; } = new T[1];

    public void Push(T element)
    {
        if (Top >= Items.Length)
        {
            var newArray = new T[Items.Length * 2];
            Array.Copy(Items, newArray, Items.Length);
            Items = newArray;
        }
        Items[Top++] = element;
    }

    public T Pop()
    {
        if (Top is 0) throw new InvalidOperationException("Stack empty.");
        return Items[Top--];
    }
}
