CREATE PROCEDURE [dbo].[SolicitudObtener]
@IdSolicitud INT = NULL

AS
	BEGIN
	SET NOCOUNT ON
	
	SELECT 
           IdSolicitud,
		   IdCliente,
		   IdServicio,
		   Cantidad,
		   Monto,
		   FechaEntrega,
		   UsuarioEntrega,
		   Observaciones
	FROM 
	     Solicitud
	WHERE 
	    (@IdSolicitud IS NULL OR IdSolicitud=@IdSolicitud)

	END
GO