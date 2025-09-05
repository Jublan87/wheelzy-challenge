-- ============================================= Triggers y validaciones adicionales =============================================

-- Trigger para validar que "Picked Up" tenga fecha obligatoria
CREATE TRIGGER TR_CaseStatusHistory_ValidatePickedUpDate
ON Case_Status_History
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si algún registro insertado/actualizado es "Picked Up" sin fecha
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        INNER JOIN Statuses s ON i.StatusId = s.StatusId
        WHERE s.Name = 'Picked Up' AND i.StatusDate IS NULL
    )
    BEGIN
        RAISERROR('The "Picked Up" status requires a mandatory status date.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

-- Trigger para asegurar que solo una cotización esté marcada como current por caso
CREATE TRIGGER TR_Quotes_ValidateOneCurrent
ON Quotes
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Si se está marcando una cotización como current
    IF EXISTS (SELECT 1 FROM inserted WHERE IsCurrent = 1)
    BEGIN
        -- Desmarcar todas las otras cotizaciones del mismo caso como no current
        UPDATE q 
        SET IsCurrent = 0
        FROM Quotes q
        INNER JOIN inserted i ON q.CaseId = i.CaseId
        WHERE q.QuoteId != i.QuoteId AND i.IsCurrent = 1;
    END
END;
GO

-- Función para obtener el estado actual de un caso
CREATE FUNCTION dbo.GetCurrentCaseStatus(@CaseId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1
        s.StatusId,
        s.Name AS StatusName,
        csh.StatusDate,
        csh.CreatedDate,
        u.Username AS ChangedBy
    FROM Case_Status_History csh
    INNER JOIN Statuses s ON csh.StatusId = s.StatusId
    INNER JOIN Users u ON csh.UserId = u.UserId
    WHERE csh.CaseId = @CaseId
    ORDER BY csh.CreatedDate DESC
);
GO