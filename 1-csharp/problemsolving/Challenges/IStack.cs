namespace Challenges;

public interface IStack<T>
{
    int Length { get; }
    T Pop();
    void Push(T element);
}
