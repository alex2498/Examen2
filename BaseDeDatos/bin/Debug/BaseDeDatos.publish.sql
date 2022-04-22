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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[Cliente]...';


GO
CREATE TABLE [dbo].[Cliente] (
    [IdCliente]            INT           NOT NULL,
    [Identificacion]       VARCHAR (128) NULL,
    [IdTipoIdentificacion] INT           NULL,
    [Nombre]               VARCHAR (128) NULL,
    [PrimerApellido]       VARCHAR (128) NULL,
    [SegundoApellido]      VARCHAR (128) NULL,
    [FechaNacimiento]      DATETIME      NULL,
    [Nacionalidad]         INT           NULL,
    [FechaDefuncion]       DATETIME      NULL,
    [Genero]               CHAR (1)      NULL,
    [NombreApellidosPadre] VARCHAR (200) NULL,
    [NombreApellidosMadre] VARCHAR (200) NULL,
    [Pasaporte]            VARCHAR (50)  NULL,
    [CuentaIBAN]           VARCHAR (50)  NULL,
    [CorreoNotifica]       VARCHAR (128) NULL,
    CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED ([IdCliente] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[Servicio]...';


GO
CREATE TABLE [dbo].[Servicio] (
    [IdServicio]     INT             NOT NULL,
    [NombreServicio] VARCHAR (128)   NULL,
    [PlazoEntrega]   INT             NULL,
    [CostoServicio]  DECIMAL (18, 2) NULL,
    [Estado]         BIT             NULL,
    [CuentaContable] VARCHAR (50)    NULL,
    CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED ([IdServicio] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[Solicitud]...';


GO
CREATE TABLE [dbo].[Solicitud] (
    [IdSolicitud]    INT             NOT NULL,
    [IdCliente]      INT             NOT NULL,
    [IdServicio]     INT             NOT NULL,
    [Cantidad]       INT             NOT NULL,
    [Monto]          DECIMAL (18, 2) NOT NULL,
    [FechaEntrega]   DATETIME        NULL,
    [UsuarioEntrega] VARCHAR (50)    NULL,
    [Observaciones]  VARCHAR (250)   NULL,
    CONSTRAINT [PK_Solicitud] PRIMARY KEY CLUSTERED ([IdSolicitud] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[Servicio]...';


GO
ALTER TABLE [dbo].[Servicio]
    ADD DEFAULT 1 FOR [Estado];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Servicio_cantidad]...';


GO
ALTER TABLE [dbo].[Solicitud]
    ADD CONSTRAINT [DF_Servicio_cantidad] DEFAULT ((1)) FOR [Cantidad];


GO
PRINT N'Creando Clave externa [dbo].[FK_Solicitud_Cliente]...';


GO
ALTER TABLE [dbo].[Solicitud]
    ADD CONSTRAINT [FK_Solicitud_Cliente] FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Cliente] ([IdCliente]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Solicitud_Servicio]...';


GO
ALTER TABLE [dbo].[Solicitud]
    ADD CONSTRAINT [FK_Solicitud_Servicio] FOREIGN KEY ([IdServicio]) REFERENCES [dbo].[Servicio] ([IdServicio]);


GO
PRINT N'Creando Procedimiento [dbo].[ClienteActualizar]...';


GO
CREATE PROCEDURE [dbo].[ClienteActualizar]
    @IdCliente INT,
    @Identificacion VARCHAR (128),
    @IdTipoIdentificacion INT,
    @Nombre VARCHAR (128) ,
    @PrimerApellido VARCHAR (128),
    @SegundoApellido VARCHAR (128),
    @FechaNacimiento DATETIME,
    @Nacionalidad INT,
    @FechaDefuncion DATETIME,
    @Genero CHAR (1),
    @NombreApellidosPadre VARCHAR (200),
    @NombreApellidosMadre VARCHAR (200),
    @Pasaporte VARCHAR (50),
    @CuentaIBAN VARCHAR(50),
    @CorreoNotifica VARCHAR(128) 

AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    UPDATE  Cliente SET		
		 Identificacion=@Identificacion,
         IdTipoIdentificacion=@IdTipoIdentificacion,
         Nombre=@Nombre,
         PrimerApellido=@PrimerApellido,
         SegundoApellido=@SegundoApellido,
         FechaNacimiento=@FechaNacimiento,
         Nacionalidad=@Nacionalidad,
         FechaDefuncion=@FechaDefuncion,
         Genero=@Genero,
         NombreApellidosPadre=@NombreApellidosPadre,
         NombreApellidosMadre=@NombreApellidosMadre,
         Pasaporte=@Pasaporte,
         CuentaIBAN=@CuentaIBAN,
         CorreoNotifica=@CorreoNotifica 
		WHERE
		     IdCliente=@IdCliente

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
PRINT N'Creando Procedimiento [dbo].[ClienteEliminar]...';


GO
CREATE PROCEDURE [dbo].[ClienteEliminar]
	@IdCliente INT

AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY

		DELETE FROM Cliente WHERE IdCliente=@IdCliente

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
PRINT N'Creando Procedimiento [dbo].[ClienteInsertar]...';


GO
CREATE PROCEDURE [dbo].[ClienteInsertar]
	@Identificacion VARCHAR (128),
    @IdTipoIdentificacion INT,
    @Nombre VARCHAR (128) ,
    @PrimerApellido VARCHAR (128),
    @SegundoApellido VARCHAR (128),
    @FechaNacimiento DATETIME,
    @Nacionalidad INT,
    @FechaDefuncion DATETIME,
    @Genero CHAR (1),
    @NombreApellidosPadre VARCHAR (200),
    @NombreApellidosMadre VARCHAR (200),
    @Pasaporte VARCHAR (50),
    @CuentaIBAN VARCHAR(50),
    @CorreoNotifica VARCHAR(128) 
AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    INSERT INTO Cliente
		(
	        Identificacion,
            IdTipoIdentificacion,
            Nombre,
            PrimerApellido,
            SegundoApellido,
            FechaNacimiento,
            Nacionalidad,
            FechaDefuncion,
            Genero,
            NombreApellidosPadre,
            NombreApellidosMadre,
            Pasaporte,
            CuentaIBAN,
            CorreoNotifica 
		)
		VALUES
		(
            @Identificacion,
            @IdTipoIdentificacion,
            @Nombre,
            @PrimerApellido,
            @SegundoApellido,
            @FechaNacimiento,
            @Nacionalidad,
            @FechaDefuncion,
            @Genero,
            @NombreApellidosPadre,
            @NombreApellidosMadre,
            @Pasaporte,
            @CuentaIBAN,
            @CorreoNotifica 
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
PRINT N'Creando Procedimiento [dbo].[ClienteLista]...';


GO
CREATE PROCEDURE [dbo].[ClienteLista]
	
AS
BEGIN 
SET NOCOUNT ON

SELECT
	IdCliente
	,Nombre

FROM dbo.Cliente

END
GO
PRINT N'Creando Procedimiento [dbo].[ClienteObtener]...';


GO
CREATE PROCEDURE [dbo].[ClienteObtener]
@IdCliente INT = NULL

AS
	BEGIN
	SET NOCOUNT ON
	
	SELECT 
            IdCliente,
	        Identificacion,
            IdTipoIdentificacion,
            Nombre,
            PrimerApellido,
            SegundoApellido,
            FechaNacimiento,
            Nacionalidad,
            FechaDefuncion,
            Genero,
            NombreApellidosPadre,
            NombreApellidosMadre,
            Pasaporte,
            CuentaIBAN,
            CorreoNotifica
	FROM 
	     Cliente
	WHERE 
	    (@IdCliente IS NULL OR IdCliente=@IdCliente)

	END
GO
PRINT N'Creando Procedimiento [dbo].[ServicioActualizar]...';


GO
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
		 IdServicio=@IdServicio,
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
PRINT N'Creando Procedimiento [dbo].[ServicioEliminar]...';


GO
CREATE PROCEDURE [dbo].[ServicioEliminar]
	@IdServicio INT

AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY

		DELETE FROM Servicio WHERE IdServicio=@IdServicio

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
PRINT N'Creando Procedimiento [dbo].[ServicioInsertar]...';


GO
CREATE PROCEDURE [dbo].[ServicioInsertar]
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
	    INSERT INTO Servicio
		(
	        IdServicio,
            NombreServicio,
            PlazoEntrega,
            CostoServicio,
            Estado,
            CuentaContable
            
		)
		VALUES
		(
            @IdServicio,
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
PRINT N'Creando Procedimiento [dbo].[ServicioLista]...';


GO
CREATE PROCEDURE [dbo].[ServicioLista]
AS
BEGIN 
SET NOCOUNT ON

SELECT
	IdServicio
	,NombreServicio

FROM dbo.Servicio

END
GO
PRINT N'Creando Procedimiento [dbo].[ServicioObtener]...';


GO
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
PRINT N'Creando Procedimiento [dbo].[SolicitudActualizar]...';


GO
CREATE PROCEDURE [dbo].[SolicitudActualizar]
    @IdSolicitud INT,
    @IdCliente INT,
    @IdServicio INT,
	@Cantidad INT,
    @Monto DECIMAL (18,2) ,
    @FechaEntrega DATETIME,
    @UsuarioEntrega VARCHAR (50),
	@Observaciones VARCHAR (250)

 
AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    UPDATE  Solicitud SET		
		 IdSolicitud=@IdSolicitud,
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
    @Monto DECIMAL (18,2) ,
    @FechaEntrega DATETIME,
    @UsuarioEntrega VARCHAR (50),
	@Observaciones VARCHAR (250)

AS BEGIN
SET NOCOUNT ON

    BEGIN TRANSACTION TRASA 
	  
	  BEGIN TRY
	    INSERT INTO Solicitud
		(
	        IdSolicitud,
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
            @IdSolicitud,
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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
