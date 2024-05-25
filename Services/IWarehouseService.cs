using APBDzad5.Models;

namespace APBDzad5.Services;

public interface IWarehouseService
{
    Task<int> AddProduct(ProductWarehouseDTO productWarehouseDTO);
    Task<int> AddProductByProcedure(ProductWarehouseDTO productWarehouseDTO);
}