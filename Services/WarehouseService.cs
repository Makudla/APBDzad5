using System.Data;
using APBDzad5.Models;
using APBDzad5.Repositories;

namespace APBDzad5.Services;

public class WarehouseService(IWarehouseRepository warehouseRepository) : IWarehouseService
{
    public async Task<int> AddProduct(ProductWarehouseDTO productWarehouseDTO)
    {
        var order = new Order
        {
            IdProduct = productWarehouseDTO.IdProduct,
            Amount = productWarehouseDTO.Amount,
            CreatedAt = productWarehouseDTO.CreatedAt
        };

        var idOrder = await warehouseRepository.GetOrderIdByProductWarehouse(order);
        var price = await warehouseRepository.GetPriceByProductId(productWarehouseDTO.IdProduct);
        var warehouseExists = await warehouseRepository.CheckIfWarehouseExists(productWarehouseDTO.IdWarehouse);

        if (!warehouseExists) throw new DataException("Warehouse with given id does not exist");

        var productWarehouse = new ProductWarehouse
        {
            IdProduct = productWarehouseDTO.IdProduct,
            IdWarehouse = productWarehouseDTO.IdWarehouse,
            IdOrder = idOrder,
            Amount = productWarehouseDTO.Amount,
            Price = productWarehouseDTO.Amount * price,
            CreatedAt = productWarehouseDTO.CreatedAt
        };

        await warehouseRepository.AddProductToWarehouse(productWarehouse);
        return await warehouseRepository.GetLastCreatedProductWarehouseId();
    }

    public async Task<int> AddProductByProcedure(ProductWarehouseDTO product)
    {
        await warehouseRepository.AddProductToWarehouseByProcedure(product);
        return await warehouseRepository.GetLastCreatedProductWarehouseId();
    }
}