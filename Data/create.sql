CREATE TABLE "Order"
(
    IdOrder     INT      NOT NULL IDENTITY,
    IdProduct   INT      NOT NULL,
    Amount      INT      NOT NULL,
    CreatedAt   DATETIME NOT NULL,
    FulfilledAt DATETIME NULL,
    CONSTRAINT Order_pk PRIMARY KEY (IdOrder)
);

CREATE TABLE Product
(
    IdProduct   INT            NOT NULL IDENTITY,
    Name        NVARCHAR(200)  NOT NULL,
    Description NVARCHAR(200)  NOT NULL,
    Price       NUMERIC(25, 2) NOT NULL,
    CONSTRAINT Product_pk PRIMARY KEY (IdProduct)
);

CREATE TABLE Product_Warehouse
(
    IdProductWarehouse INT            NOT NULL IDENTITY,
    IdWarehouse        INT            NOT NULL,
    IdProduct          INT            NOT NULL,
    IdOrder            INT            NOT NULL,
    Amount             INT            NOT NULL,
    Price              NUMERIC(25, 2) NOT NULL,
    CreatedAt          DATETIME       NOT NULL,
    CONSTRAINT Product_Warehouse_pk PRIMARY KEY (IdProductWarehouse)
);

CREATE TABLE Warehouse
(
    IdWarehouse INT           NOT NULL IDENTITY,
    Name        NVARCHAR(200) NOT NULL,
    Address     NVARCHAR(200) NOT NULL,
    CONSTRAINT Warehouse_pk PRIMARY KEY (IdWarehouse)
);

ALTER TABLE Product_Warehouse
    ADD CONSTRAINT Product_Warehouse_Order
        FOREIGN KEY (IdOrder)
            REFERENCES "Order" (IdOrder);

ALTER TABLE "Order"
    ADD CONSTRAINT Receipt_Product
        FOREIGN KEY (IdProduct)
            REFERENCES Product (IdProduct);

ALTER TABLE Product_Warehouse
    ADD CONSTRAINT _Product
        FOREIGN KEY (IdProduct)
            REFERENCES Product (IdProduct);

ALTER TABLE Product_Warehouse
    ADD CONSTRAINT _Warehouse
        FOREIGN KEY (IdWarehouse)
            REFERENCES Warehouse (IdWarehouse);

GO

INSERT INTO Warehouse(Name, Address)
VALUES ('Sosnowiec', 'Sosnowiecka');

GO

INSERT INTO Product(Name, Description, Price)
VALUES ('Jab³ko', 'piêkne œwie¿e', 1.23),
       ('Arbuz', 'Brzydki, stary', 4.88),
       ('Pluszak', 'najukochañszy', 999.99);

GO

INSERT INTO "Order"(IdProduct, Amount, CreatedAt)
VALUES ((SELECT IdProduct FROM Product WHERE Name = 'Pluszak'), 999, GETDATE());