CREATE PROCEDURE [dbo].[ServicioObtener]
@IdServicio INT = NULL

AS
	BEGIN
	SET NOCOUNT ON
	
	SELECT 
            IdServicio,
            NombreServicio,
            PlazoEntrega,
            CostoServicio,
            Estado,
            CuentaContable
	FROM 
	     Servicio
	WHERE 
	    (@IdServicio IS NULL OR IdServicio=@IdServicio)

	END
GO