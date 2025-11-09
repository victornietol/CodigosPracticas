var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

// los middleware se establecen un cierto orden especifico
app.UseHttpsRedirection();

app.UseAuthorization();

//app.UseWelcomePage(); // custom middleware

app.UseTimeMiddleware(); // custom

app.MapControllers();

app.Run();
