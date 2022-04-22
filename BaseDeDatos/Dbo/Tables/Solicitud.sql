CREATE TABLE [dbo].[Solicitud]
(
	 IdSolicitud INT IDENTITY (1,1) CONSTRAINT [PK_Solicitud] PRIMARY KEY CLUSTERED (IdSolicitud ASC),
     IdCliente INT CONSTRAINT [FK_Solicitud_Cliente] FOREIGN KEY (IdCliente)
     REFERENCES dbo.Cliente (IdCliente),
     IdServicio INT CONSTRAINT [FK_Solicitud_Servicio] FOREIGN KEY (IdServicio) REFERENCES
     dbo.Servicio (IdServicio),
     Cantidad INT CONSTRAINT [DF_Servicio_cantidad] DEFAULT ((1)),
     Monto DECIMAL (18, 2) ,
     FechaEntrega DATETIME,
     UsuarioEntrega VARCHAR (50),
     Observaciones VARCHAR(250), 
)
WITH (DATA_COMPRESSION = PAGE)
GO
