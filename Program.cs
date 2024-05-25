using APBDzad5.Repositories;
using APBDzad5.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IWarehouseService, WarehouseService>();
builder.Services.AddTransient<IWarehouseRepository, WarehouseRepository>();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();