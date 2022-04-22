using BD;
using Entity;
using Entity.dbo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace WBL
{
   
       
        public interface IServicioService
        {
            Task<DBEntity> Create(ServicioEntity entity);
            Task<DBEntity> Delete(ServicioEntity entity);
            Task<IEnumerable<ServicioEntity>> Get();
            Task<ServicioEntity> GetById(ServicioEntity entity);
            Task<DBEntity> Update(ServicioEntity entity);
        }

        public class ServicioService : IServicioService
        {
            //Constructor
            private readonly IDataAccess sql;
            public ServicioService(IDataAccess _Sql)
            {
                sql = _Sql;
            }

            #region Metodos CRUD
            //Metodos CRUD
            //Metodo GET
            public async Task<IEnumerable<ServicioEntity>> Get()
            {
                try
                {
                    var result = sql.QueryAsync<ServicioEntity>("dbo.ServicioObtener");
                    return await result;

                }
                catch (Exception)
                {

                    throw;
                }
            }


            //Metodo GetById
            public async Task<ServicioEntity> GetById(ServicioEntity entity)
            {
                try
                {
                    var result = sql.QueryFirstAsync<ServicioEntity>("dbo.ServicioObtener", new { entity.IdServicio });
                    return await result;

                }
                catch (Exception)
                {

                    throw;
                }
            }

            //Metodo create 
            public async Task<DBEntity> Create(ServicioEntity entity)
            {
                try
                {
                    var result = sql.ExecuteAsync("dbo.ServicioInsertar",
                        new
                        {
                            entity.IdServicio,
                            entity.NombreServicio,
                            entity.PlazoEntrega,
                            entity.CostoServicio,
                            entity.estado,
                            entity.CuentaContable,                           

                        });
                    return await result;

                }
                catch (Exception)
                {

                    throw;
                }
            }

            //Metodo Update 
            public async Task<DBEntity> Update(ServicioEntity entity)
            {
                try
                {
                    var result = sql.ExecuteAsync("dbo.ServicioActualizar",
                        new
                        {
                            entity.IdServicio,
                            entity.NombreServicio,
                            entity.PlazoEntrega,
                            entity.CostoServicio,
                            entity.estado,
                            entity.CuentaContable,

                        });
                    return await result;

                }
                catch (Exception)
                {

                    throw;
                }
            }


            //Metodo Delete 
            public async Task<DBEntity> Delete(ServicioEntity entity)
            {
                try
                {
                    var result = sql.ExecuteAsync("dbo.ServicioEliminar", new { entity.IdServicio });
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

