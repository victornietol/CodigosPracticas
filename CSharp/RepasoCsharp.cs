using System.Text.Json;

// formas de crear un objeto
Sale sale = new Sale(14, "super");
var sale1 = new Sale(14, "super"); // este var no es como el de JS, este solo indica que es del mismo tipo que del objeto que se instancia
Sale sale2 = new(14, "super");

var message = sale.GetInfo();
Console.WriteLine(message);


var saleTax = new SaleWithTax(10, "super", 12.5m);
Console.WriteLine(saleTax.GetInfo());

Console.WriteLine(saleTax.GetTax());

Console.WriteLine(saleTax.GetAll());


// Generics
var numbers = new MyList<int>(4);
var names = new MyList<string>(4);
var cars = new MyList<Car>(2);
numbers.AddItem(1);
numbers.AddItem(2);
numbers.AddItem(3);
numbers.AddItem(4);
numbers.AddItem(5);
names.AddItem("Name1");
names.AddItem("Name2");
names.AddItem("Name3");
names.AddItem("Name4");
names.AddItem("Name5");
cars.AddItem(new Car("Car1", 10));
cars.AddItem(new Car("Car2", 20));
cars.AddItem(new Car("Car3", 30));

Console.WriteLine(numbers.GetContent());
Console.WriteLine(names.GetContent());
Console.WriteLine(cars.GetContent());


// Serializacion y Deserializacion
var per1 = new People("javier", 35);
string json = JsonSerializer.Serialize(per1);
Console.WriteLine(json);
string myJson = @"{
    ""Name"": ""javier"",
    ""Age"": 35
}";
People? per2 = JsonSerializer.Deserialize<People>(myJson);
Console.WriteLine(per2?.Name);



// Programacion funcional
Console.WriteLine(Sub(2, 1));
DateTime date = new DateTime(2023, 10, 1);
Console.WriteLine(GetTomorrow(date));
int Sub(int a, int b)
{
    return a - b;
}
DateTime GetTomorrow(DateTime date)
{
    return date.AddDays(1);
}
var show = Show;
Some(show, "Mensaje enviado");
string Show(string text)
{
    return text.ToUpper();
}
void Some(Func<string, string> fn, string text)
{
    Console.WriteLine("Hace algo al inicio");
    Console.WriteLine(fn(text));
    Console.WriteLine("Hace algo al final");
}




// Funciones anonimas (lambda)
Func<int, int, int> sub = (a, b) => a - b;
Func<int, int> some = a => a * 2;
Func<int, int> some2 = a=> {
    a = a + 1;
    return a * 4;
};
Some2((a, b) => a + b, 5);
void Some2(Func<int, int, int> fn, int number)
{
    var result = fn(number, number);
}



// LINQ
string[] namesLINQ =
{
    "Javier", "Hector", "David", "Susana", "Ana"
};
var namesResult = from n in namesLINQ
                  where n.Length > 3
                  orderby n descending
                  select n;
var namesResult2 = namesLINQ.Where(n=> n.Length > 3)
                            .OrderByDescending(n => n)
                            .Select(d=>d);
foreach(var name in namesResult)
{
    Console.WriteLine(name);
}



// Clase que implementa interfaces
class Sale : INumber, ISave
{   
    public decimal Number { get; set; } // Requerido por la interface INumber

    public decimal Total { get; set; }
    private decimal _some;
    protected string ExampleSuper;

    public Sale(decimal total, string exampleSuper) {
        Total = total;
        _some = 8;
        ExampleSuper = exampleSuper;
    }

    public virtual string GetInfo() // virtual indica que se puede sobreescribir el comportamiento
    {
        return "El total es " + Total;
    }

    public void Save() // Implementacion de la interface ISave
    {
        Console.WriteLine("Se guardo.");
    }
}


// Herencia
class SaleWithTax : Sale
{
    private decimal Tax { get; set; }

    public SaleWithTax(decimal total, string exampleSuper, decimal example) : base(total, exampleSuper) // Asi se incializa el valor para el constructor del padre
    {
        Tax = example;
    }

    public decimal GetTax()
    {
        return Tax;
    }

    public string GetAll()
    {
        return "Total=" + base.Total.ToString() +
            ", ExampleSuper=" + base.ExampleSuper +
            ", Example=" + Tax;
    }

    public override string GetInfo()
    {
        return "El total en SaleWithTax es = " + base.Total;
    }
    
    // sobrecarga de metodos
    public string Message()
    {
        return "Default message";
    }

    public string Message(string message)
    {
        return message;
    }
}



// Interface
interface INumber
{
    decimal Number { get; set; }
}

interface ISave
{
    public void Save();
}




// Generics
public class MyList<T>
{
    private List<T> _list;
    private int _limit;

    public MyList(int limit)
    {
        _limit = limit;
        _list = new List<T>();
    }

    public void AddItem(T item) 
    {
        if (_list.Count < _limit)
        {
            _list.Add(item);
        }
    }

    public string GetContent()
    {
        string content = "";

        foreach (var item in _list)
        {
            content += item + ", ";
        }

        return content;
    }
}

public class Car
{
    public string Name { get; set; }
    public decimal Price { get; set; }

    public Car(string name, decimal price)
    {
        Name = name;
        Price = price;
    }

    public override string ToString() 
    {
        return "Car {" + "Name=" + Name +
            ", Price=" + Price + "}";
    }
}



// Serializacion y Deserializacion
public class People
{
    public string Name { get; set; }
    public int Age { get; set; }

    public People(string name, int age) { 
        Name = name;
        Age = age;
    }
}