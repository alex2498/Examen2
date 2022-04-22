/*
Script de implementación para Examen2

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Examen2"
:setvar DefaultFilePrefix "Examen2"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.RUIZ\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.RUIZ\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creando Procedimiento [dbo].[SolicitudActualizar]...';


GO
CREATE PROCEDURE [dbo].[SolicitudActualizar]
    @IdSolicitud INT,
    @IdCliente INT,
    @IdServicio INT,
	@Cantidad INT,
    @Monto DECIMAL ,
    @FechaEntrega DATETIME,
    @UsuarioEntrega VARCHAR (50),
	@Observaciones VARCHAR (250)

 
AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    UPDATE  Solicitud SET		
         IdCliente=@IdCliente,
         IdServicio=@IdServicio,
         Cantidad=@Cantidad,
         Monto=@Monto,
         FechaEntrega=@FechaEntrega,
		 UsuarioEntrega=@UsuarioEntrega,
         Observaciones=@Observaciones

        
		WHERE
		     IdSolicitud=@IdSolicitud

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
PRINT N'Creando Procedimiento [dbo].[SolicitudEliminar]...';


GO
CREATE PROCEDURE [dbo].[SolicitudEliminar]
	@IdSolicitud INT

AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY

		DELETE FROM Solicitud WHERE IdSolicitud=@IdSolicitud

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
PRINT N'Creando Procedimiento [dbo].[SolicitudInsertar]...';


GO
CREATE PROCEDURE [dbo].[SolicitudInsertar]
    @IdSolicitud INT,
    @IdCliente INT,
    @IdServicio INT,
	@Cantidad INT,
    @Monto DECIMAL,
    @FechaEntrega DATETIME,
    @UsuarioEntrega VARCHAR (50),
	@Observaciones VARCHAR (250)

AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    INSERT INTO Solicitud
		(
            IdCliente,
            IdServicio,
            Cantidad,
            Monto,
            FechaEntrega,
			UsuarioEntrega,
            Observaciones

            
		)
		VALUES
		(
            @IdCliente,
            @IdServicio,
            @Cantidad,
            @Monto,
            @FechaEntrega,
			@UsuarioEntrega,
            @Observaciones

            
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
PRINT N'Creando Procedimiento [dbo].[SolicitudLista]...';


GO
CREATE PROCEDURE [dbo].[SolicitudLista]
AS
BEGIN 
SET NOCOUNT ON

SELECT
	IdSolicitud
	,Cantidad

FROM dbo.Solicitud

END
GO
PRINT N'Creando Procedimiento [dbo].[SolicitudObtener]...';


GO
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
PRINT N'Actualización completada.';


GO
