using BD;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WBL
{
    public interface ISolicitudService
    {
        Task<DBEntity> Create(SolicitudEntity entity);
        Task<DBEntity> Delete(SolicitudEntity entity);
        Task<IEnumerable<SolicitudEntity>> Get();
        Task<SolicitudEntity> GetById(SolicitudEntity entity);
        Task<DBEntity> Update(SolicitudEntity entity);
    }

    public class SolicitudService : ISolicitudService
    {
        //Constructor
        private readonly IDataAccess sql;
        public SolicitudService(IDataAccess _Sql)
        {
            sql = _Sql;
        }

        #region Metodos CRUD
        //Metodos CRUD
        //Metodo GET
        public async Task<IEnumerable<SolicitudEntity>> Get()
        {
            try
            {
                var result = sql.QueryAsync<SolicitudEntity>("dbo.SolicitudObtener", "IdSolicitud");
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }


        //Metodo GetById
        public async Task<SolicitudEntity> GetById(SolicitudEntity entity)
        {
            try
            {
                var result = sql.QueryFirstAsync<SolicitudEntity>("dbo.SolicitudObtener", new { entity.IdSolicitud });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }

        //Metodo create 
        public async Task<DBEntity> Create(SolicitudEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("dbo.SolicitudInsertar",
                    new
                    {
                        entity.IdSolicitud,
                        entity.IdCliente,
                        entity.IdServicio,
                        entity.Cantidad,
                        entity.Monto,
                        entity.FechaEntrega,
                        entity.usuarioEntrega,
                        entity.observaciones,


                    });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }

        //Metodo Update 
        public async Task<DBEntity> Update(SolicitudEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("dbo.SolicitudActualizar",
                    new
                    {
                        entity.IdSolicitud,
                        entity.IdCliente,
                        entity.IdServicio,
                        entity.Cantidad,
                        entity.Monto,
                        entity.FechaEntrega,
                        entity.usuarioEntrega,
                        entity.observaciones,

                    });
                return await result;

            }
            catch (Exception)
            {

                throw;
            }
        }


        //Metodo Delete 
        public async Task<DBEntity> Delete(SolicitudEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("dbo.SolicitudEliminar", new { entity.IdSolicitud });
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

