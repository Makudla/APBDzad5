using APBDzad5.Models;
using APBDzad5.Services;
using Microsoft.AspNetCore.Mvc;

namespace APBDzad5.Controllers;

[ApiController]
[Route("api/[controller]")]
public class WarehouseController(IWarehouseService warehouseService) : ControllerBase
{
    [HttpPost]
    public async Task<IActionResult> AddProduct(ProductWarehouseDTO productWarehouseDTO)
    {
        try
        {
            var idProductWarehouse = await warehouseService.AddProduct(productWarehouseDTO);
            return Ok(idProductWarehouse);
        }
        catch (Exception e)
        {
            return BadRequest(e.StackTrace);
        }
    }
}