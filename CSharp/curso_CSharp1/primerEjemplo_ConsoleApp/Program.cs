using Humanizer;

Console.WriteLine("Numero 1: ");
var text = int.Parse(Console.ReadLine());
Console.WriteLine("Numero 2: ");
var text2 = int.Parse(Console.ReadLine());
Console.WriteLine($"text1 = {text.ToWords()}, text2 = {text2.ToWords()}");