CREATE PROCEDURE [dbo].[ServicioActualizar]
    @IdServicio INT,
    @NombreServicio VARCHAR (128),
    @PlazoEntrega INT,
    @CostoServicio DECIMAL (18,2) ,
    @Estado BIT,
    @CuentaContable VARCHAR (128)
 
AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    UPDATE  Servicio SET		
         NombreServicio=@NombreServicio,
         PlazoEntrega=@PlazoEntrega,
         CostoServicio=@CostoServicio,
         Estado=@Estado,
         CuentaContable=@CuentaContable
        
		WHERE
		     IdServicio=@IdServicio

		COMMIT TRANSACTION TRASA
		SELECT 0 AS CodeError, '' AS msgError

	  END TRY 

	  BEGIN CATCH

	   SELECT 
	         ERROR_NUMBER() AS CodeError,
			 ERROR_MESSAGE() AS MsgError
		 ROLLBACK TRANSACTION TRASA

	  END CATCH
	  
    END
GO