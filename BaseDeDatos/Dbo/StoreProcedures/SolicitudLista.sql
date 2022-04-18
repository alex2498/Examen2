CREATE PROCEDURE [dbo].[SolicitudLista]
AS
BEGIN 
SET NOCOUNT ON

SELECT
	IdSolicitud
	,Cantidad

FROM dbo.Solicitud

END
