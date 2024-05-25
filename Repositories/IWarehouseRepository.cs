using APBDzad5.Models;

namespace APBDzad5.Repositories;

public interface IWarehouseRepository
{
    Task<int> GetOrderIdByProductWarehouse(Order order);
    Task<decimal> GetPriceByProductId(int idProduct);
    Task<bool> CheckIfWarehouseExists(int idWarehouse);
    Task AddProductToWarehouse(ProductWarehouse productWarehouse);
    Task AddProductToWarehouseByProcedure(ProductWarehouseDTO productWarehouseDTO);
    Task<int> GetLastCreatedProductWarehouseId();
}