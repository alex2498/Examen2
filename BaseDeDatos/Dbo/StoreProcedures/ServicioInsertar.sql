CREATE PROCEDURE [dbo].[ServicioInsertar]
    @NombreServicio VARCHAR (128),
    @PlazoEntrega INT,
    @CostoServicio DECIMAL (18,2) ,
    @Estado BIT,
    @CuentaContable VARCHAR (128)
AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    INSERT INTO Servicio
		(
            NombreServicio,
            PlazoEntrega,
            CostoServicio,
            Estado,
            CuentaContable
            
		)
		VALUES
		(
            @NombreServicio,
            @PlazoEntrega,
            @CostoServicio,
            @Estado,
            @CuentaContable
            
		)
		COMMIT TRANSACTION TRASA
		SELECT 0 AS CodeError, '' AS MsgError

	  END TRY 

	  BEGIN CATCH

	   SELECT 
	         ERROR_NUMBER() AS CodeError,
			 ERROR_MESSAGE() AS MsgError
		 ROLLBACK TRANSACTION TRASA

	  END CATCH
	  
    END
GO