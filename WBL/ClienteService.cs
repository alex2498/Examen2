using BD;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace WBL
{
    //INTERFASES
    public interface IClienteService
    {
        Task<DBEntity> Create(ClienteEntity entity);
        Task<DBEntity> Delete(ClienteEntity entity);
        Task<IEnumerable<ClienteEntity>> Get();
        Task<IEnumerable<ClienteEntity>> GetLista();
        Task<ClienteEntity> GetById(ClienteEntity entity);
        Task<DBEntity> Update(ClienteEntity entity);
    }

    //Constructor
    public class ClienteService : IClienteService
    {
        private readonly IDataAccess sql;

        public ClienteService(IDataAccess _Sql)
        {
            sql = _Sql;
        }




        #region Metodos CRUD

        //Metodo GET
        public async Task<IEnumerable<ClienteEntity>> Get()
        {
            try
            {
                var result = sql.QueryAsync<ClienteEntity>("dbo.ClienteObtener");
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }

        //Metodo getById
        public async Task<ClienteEntity> GetById(ClienteEntity entity)
        {
            try
            {
                var result = sql.QueryFirstAsync<ClienteEntity>("dbo.ClienteObtener", new { entity.IdCliente });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }

        //Metodo create 
        public async Task<DBEntity> Create(ClienteEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("dbo.ClienteInsertar",
                    new
                    {
                        entity.Identificacion,
                        entity.IdTipoIdentificacion,
                        entity.Nombre,
                        entity.PrimerApellido,
                        entity.SegundoApellido,
                        entity.FechaNacimiento,
                        entity.Nacionalidad,
                        entity.FechaDefuncion,
                        entity.Genero,
                        entity.NombreApellidosPadre,
                        entity.NombreApellidosMadre,
                        entity.Pasaporte,
                        entity.CuentaIBAN,
                        entity.CorreoNotifica,


                    });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }

        //Metodo Update 
        public async Task<DBEntity> Update(ClienteEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("dbo.ClienteActualizar",
                    new
                    {
                        entity.IdCliente,
                        entity.Identificacion,
                        entity.IdTipoIdentificacion,
                        entity.Nombre,
                        entity.PrimerApellido,
                        entity.SegundoApellido,
                        entity.FechaNacimiento,
                        entity.Nacionalidad,
                        entity.FechaDefuncion,
                        entity.Genero,
                        entity.NombreApellidosPadre,
                        entity.NombreApellidosMadre,
                        entity.Pasaporte,
                        entity.CuentaIBAN,
                        entity.CorreoNotifica,

                    });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }


        //Metodo Delete 
        public async Task<DBEntity> Delete(ClienteEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("dbo.ClienteEliminar", new { entity.IdCliente });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion

        #region MyRegion
        //Metodo GETLista
        public async Task<IEnumerable<ClienteEntity>> GetLista()
        {
            try
            {
                var result = sql.QueryAsync<ClienteEntity>("dbo.ClienteLista");
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }

        #endregion

    }
}
