CREATE PROCEDURE AddProductToWarehouse @IdProduct INT,
                                       @IdWarehouse INT,
                                       @Amount INT,
                                       @CreatedAt DATETIME
AS
BEGIN
    DECLARE @IdProductFromDb INT, @IdOrder INT, @Price DECIMAL(5, 2);
    SELECT TOP 1 @IdOrder = o.IdOrder
    FROM dbo.[Order] o
             LEFT JOIN dbo.Product_Warehouse pw ON o.IdOrder = pw.IdOrder
    WHERE o.IdProduct = @IdProduct
      AND o.Amount = @Amount
      AND pw.IdProductWarehouse IS NULL
      AND o.CreatedAt < @CreatedAt;

    SELECT @IdProductFromDb = dbo.Product.IdProduct, @Price = dbo.Product.Price
    FROM dbo.Product
    WHERE IdProduct = @IdProduct;

    IF @IdProductFromDb IS NULL
        BEGIN
            RAISERROR ('Taki produkt nie istnieje', 18, 0);
        END;

    IF @IdOrder IS NULL
        BEGIN
            RAISERROR ('Brak zamówienia', 18, 0);
        END;

    IF NOT EXISTS (SELECT 1
                   FROM dbo.Warehouse
                   WHERE IdWarehouse = @IdWarehouse)
        BEGIN
            RAISERROR ('Podany magazyn nie istnieje', 18, 0);
        END;

    SET XACT_ABORT ON;
    BEGIN TRANSACTION;

    UPDATE dbo.[Order]
    SET FulfilledAt = @CreatedAt
    WHERE IdOrder = @IdOrder;

    INSERT INTO dbo.Product_Warehouse (IdWarehouse, IdProduct, IdOrder, Amount, Price, CreatedAt)
    VALUES (@IdWarehouse, @IdProduct, @IdOrder, @Amount, @Amount * @Price, @CreatedAt);

    SELECT @@IDENTITY AS NewId;
    COMMIT TRANSACTION;
END