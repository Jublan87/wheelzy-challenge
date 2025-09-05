-- ============================================= Creación de tablas =============================================

-- Marcas de vehículos
CREATE TABLE Makes (
    MakeId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- Modelos de vehículos
CREATE TABLE Models (
    ModelId INT IDENTITY(1,1) PRIMARY KEY,
    MakeId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Models_Makes FOREIGN KEY (MakeId) REFERENCES Makes(MakeId),
    CONSTRAINT UQ_Models_MakeName UNIQUE (MakeId, Name)
);

-- Submodelos de vehículos
CREATE TABLE Submodels (
    SubmodelId INT IDENTITY(1,1) PRIMARY KEY,
    ModelId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Submodels_Models FOREIGN KEY (ModelId) REFERENCES Models(ModelId),
    CONSTRAINT UQ_Submodels_ModelName UNIQUE (ModelId, Name)
);

-- Códigos Postales
CREATE TABLE ZipCodes (
    ZipCodeId INT IDENTITY(1,1) PRIMARY KEY,
    Code NVARCHAR(10) NOT NULL UNIQUE,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- Usuarios del sistema
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- Compradores
CREATE TABLE Buyers (
    BuyerId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- Automóviles
CREATE TABLE Cars (
    CarId INT IDENTITY(1,1) PRIMARY KEY,
    Year INT NOT NULL,
    SubmodelId INT NOT NULL,
    ZipCodeId INT NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Cars_Submodels FOREIGN KEY (SubmodelId) REFERENCES Submodels(SubmodelId),
    CONSTRAINT FK_Cars_ZipCodes FOREIGN KEY (ZipCodeId) REFERENCES ZipCodes(ZipCodeId)
);

-- Estados del caso
CREATE TABLE Statuses (
    StatusId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- Relación Buyer-ZipCode (muchos a muchos) con cotización base
CREATE TABLE Buyer_ZipCodes (
    BuyerZipCodeId INT IDENTITY(1,1) PRIMARY KEY,
    BuyerId INT NOT NULL,
    ZipCodeId INT NOT NULL,
    QuoteAmount DECIMAL(18,2) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_BuyerZip_Buyers FOREIGN KEY (BuyerId) REFERENCES Buyers(BuyerId),
    CONSTRAINT FK_BuyerZip_ZipCodes FOREIGN KEY (ZipCodeId) REFERENCES ZipCodes(ZipCodeId),
    CONSTRAINT UQ_BuyerZip UNIQUE (BuyerId, ZipCodeId)
);

-- Casos de venta
CREATE TABLE Cases (
    CaseId INT IDENTITY(1,1) PRIMARY KEY,
    CarId INT NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Cases_Cars FOREIGN KEY (CarId) REFERENCES Cars(CarId)
);

-- Cotizaciones por Caso (con manejo de cotización actual)
CREATE TABLE Quotes (
    QuoteId INT IDENTITY(1,1) PRIMARY KEY,
    CaseId INT NOT NULL,
    BuyerZipCodeId INT NOT NULL,
    IsCurrent BIT NOT NULL DEFAULT 0,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Quotes_Cases FOREIGN KEY (CaseId) REFERENCES Cases(CaseId),
    CONSTRAINT FK_Quotes_BuyerZipCodes FOREIGN KEY (BuyerZipCodeId) REFERENCES Buyer_ZipCodes(BuyerZipCodeId)
);

-- Historial de Estados del Caso
CREATE TABLE Case_Status_History (
    HistoryId INT IDENTITY(1,1) PRIMARY KEY,
    CaseId INT NOT NULL,
    StatusId INT NOT NULL,
    UserId INT NOT NULL,
    StatusDate DATETIME2 NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_CaseHistory_Cases FOREIGN KEY (CaseId) REFERENCES Cases(CaseId),
    CONSTRAINT FK_CaseHistory_Statuses FOREIGN KEY (StatusId) REFERENCES Statuses(StatusId),
    CONSTRAINT FK_CaseHistory_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Índice único para asegurar solo una cotización current por caso
CREATE UNIQUE INDEX UQ_CurrentQuote_Per_Case 
ON Quotes (CaseId) 
WHERE IsCurrent = 1;