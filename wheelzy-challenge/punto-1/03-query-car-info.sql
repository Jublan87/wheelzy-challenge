-- ============================================= Query para mostrar informaci�n solicitada =============================================

SELECT 
    -- Informaci�n del auto
    car.Year AS CarYear,
    make.Name AS Make,
    model.Name AS Model,
    submodel.Name AS Submodel,
    zipcode.Code AS ZipCode,
    
    -- Informaci�n del comprador actual y cotizaci�n
    buyer.Name AS CurrentBuyerName,
    buyer_zip.QuoteAmount AS CurrentQuoteAmount,
    
    -- Informaci�n del estado actual
    current_status.StatusName AS CurrentStatusName,
    current_status.StatusDate AS CurrentStatusDate,
    current_status.ChangedBy AS StatusChangedBy,
    current_status.CreatedDate AS StatusChangedDate
    
FROM Cases case_info
    -- Informaci�n del auto
    INNER JOIN Cars car ON case_info.CarId = car.CarId
    INNER JOIN Submodels submodel ON car.SubmodelId = submodel.SubmodelId
    INNER JOIN Models model ON submodel.ModelId = model.ModelId
    INNER JOIN Makes make ON model.MakeId = make.MakeId
    INNER JOIN ZipCodes zipcode ON car.ZipCodeId = zipcode.ZipCodeId
    
    -- Cotizaci�n actual (solo una por caso marcada como IsCurrent = 1)
    LEFT JOIN Quotes quote ON case_info.CaseId = quote.CaseId AND quote.IsCurrent = 1
    LEFT JOIN Buyer_ZipCodes buyer_zip ON quote.BuyerZipCodeId = buyer_zip.BuyerZipCodeId
    LEFT JOIN Buyers buyer ON buyer_zip.BuyerId = buyer.BuyerId
    
    -- Estado actual del caso (usando la funci�n creada anteriormente)
    CROSS APPLY dbo.GetCurrentCaseStatus(case_info.CaseId) current_status

ORDER BY case_info.CaseId;