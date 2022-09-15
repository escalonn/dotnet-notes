namespace Challenges;

public class LinkedListStack<T> : IStack<T>
{
    public int Length { get; protected set; }

    protected Frame? Head { get; set; }

    public void Push(T element)
    {
        Head = new(element, Head);
        Length++;
    }

    public T Pop()
    {
        if (Head is null) throw new InvalidOperationException("Stack empty.");
        T element = Head.Data;
        Head = Head.Next;
        Length--;
        return element;
    }

    protected class Frame
    {
        public T Data { get; }
        public Frame? Next { get; }
        public Frame(T data, Frame? next)
        {
            Data = data;
            Next = next;
        }
    }
}
