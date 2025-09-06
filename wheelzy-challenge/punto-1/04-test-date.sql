-- ============================================= DATOS DE PRUEBA =============================================

-- Insertar Marcas
INSERT INTO Makes (Name) VALUES 
('Toyota'), ('Honda'), ('Ford'), ('BMW'), ('Mercedes-Benz');

-- Insertar Modelos
INSERT INTO Models (MakeId, Name) VALUES 
(1, 'Camry'), (1, 'Corolla'), (1, 'RAV4'),
(2, 'Civic'), (2, 'Accord'), (2, 'CR-V'),
(3, 'Focus'), (3, 'Mustang'), (3, 'F-150'),
(4, '3 Series'), (4, 'X5'), 
(5, 'C-Class'), (5, 'E-Class');

-- Insertar Submodelos
INSERT INTO Submodels (ModelId, Name) VALUES 
(1, 'LE'), (1, 'XLE'), (1, 'Limited'),
(2, 'L'), (2, 'LE'), (2, 'XLE'),
(4, 'LX'), (4, 'EX'), (4, 'Touring'),
(8, 'GT'), (8, 'Shelby GT350'),
(10, '320i'), (10, '330i'), (10, 'M3');

-- Insertar Códigos Postales
INSERT INTO ZipCodes (Code) VALUES 
('10001'), ('10002'), ('90210'), ('60601'), ('30301'), 
('77001'), ('33101'), ('94102'), ('02101'), ('98101');

-- Insertar Usuarios
INSERT INTO Users (Username) VALUES 
('admin'), ('john.doe'), ('jane.smith'), ('mike.johnson'), ('sarah.wilson');

-- Insertar Compradores
INSERT INTO Buyers (Name) VALUES 
('AutoMax Buyers'), ('QuickCash Motors'), ('Premier Auto Group'), 
('FastTrack Cars'), ('Elite Vehicle Solutions');

-- Insertar relaciones Buyer-ZipCode con cotizaciones
INSERT INTO Buyer_ZipCodes (BuyerId, ZipCodeId, QuoteAmount) VALUES 
-- AutoMax Buyers cubre varios códigos postales
(1, 1, 15000.00), (1, 2, 15500.00), (1, 3, 18000.00),
-- QuickCash Motors
(2, 1, 14500.00), (2, 4, 16000.00), (2, 5, 15200.00),
-- Premier Auto Group
(3, 3, 19000.00), (3, 6, 17500.00), (3, 7, 16800.00),
-- FastTrack Cars
(4, 8, 15800.00), (4, 9, 16200.00), (4, 10, 15900.00),
-- Elite Vehicle Solutions
(5, 1, 15300.00), (5, 5, 15700.00), (5, 9, 16500.00);

-- Insertar Automóviles
INSERT INTO Cars (Year, SubmodelId, ZipCodeId) VALUES 
(2020, 1, 1),  -- Toyota Camry LE en 10001
(2019, 4, 2),  -- Toyota Corolla L en 10002
(2021, 7, 3),  -- Honda Civic LX en 90210
(2018, 11, 1), -- Ford Mustang GT en 10001
(2022, 13, 4); -- BMW 320i en 60601

-- Insertar Estados
INSERT INTO Statuses (Name) VALUES 
('Pending Acceptance'), ('Accepted'), ('In Review'), ('Picked Up'), ('Completed');

-- Insertar Casos
INSERT INTO Cases (CarId) VALUES (1), (2), (3), (4), (5);

-- Insertar Cotizaciones (algunas marcadas como current)
INSERT INTO Quotes (CaseId, BuyerZipCodeId, IsCurrent) VALUES 
(1, 1, 1),  -- Caso 1: AutoMax Buyers cotización actual
(1, 5, 0),  -- Caso 1: QuickCash Motors cotización alternativa
(2, 2, 1),  -- Caso 2: AutoMax Buyers cotización actual
(3, 3, 1),  -- Caso 3: Premier Auto Group cotización actual
(4, 1, 0),  -- Caso 4: AutoMax Buyers cotización no actual
(4, 15, 1), -- Caso 4: Elite Vehicle Solutions cotización actual
(5, 6, 1);  -- Caso 5: Premier Auto Group cotización actual

-- Insertar Historial de Estados
INSERT INTO Case_Status_History (CaseId, StatusId, UserId, StatusDate) VALUES 
-- Caso 1
(1, 1, 1, NULL),                    -- Pending Acceptance
(1, 2, 2, NULL),                    -- Accepted
(1, 4, 3, '2024-01-15 10:30:00'),  -- Picked Up (con fecha obligatoria)

-- Caso 2
(2, 1, 1, NULL),                    -- Pending Acceptance
(2, 3, 2, NULL),                    -- In Review

-- Caso 3
(3, 1, 1, NULL),                    -- Pending Acceptance
(3, 2, 3, NULL),                    -- Accepted

-- Caso 4
(4, 1, 2, NULL),                    -- Pending Acceptance
(4, 2, 3, NULL),                    -- Accepted
(4, 4, 4, '2024-01-20 14:45:00'),  -- Picked Up
(4, 5, 4, NULL),                    -- Completed

-- Caso 5
(5, 1, 1, NULL);                    -- Pending Acceptance

GO