CREATE PROCEDURE [dbo].[ClienteLista]
	
AS
BEGIN 
SET NOCOUNT ON

SELECT
	IdCliente
	,Nombre

FROM dbo.Cliente

END
