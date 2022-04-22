using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WBL;
using Entity;


namespace WebApp.Pages.Solicitud
{
    
    public class GridModel : PageModel
    {
        private readonly ISolicitudService soliService;

        public GridModel(ISolicitudService soliService)
        {
            this.soliService = soliService;
        }

        public IEnumerable<SolicitudEntity> GridList { get; set; } = new List<SolicitudEntity>();

        public string Mensaje { get; set; } = "";
        public async Task<IActionResult> OnGet()
        {
            try
            {
                GridList = await soliService.Get();

                return Page();
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }
        }

        public async Task<JsonResult> OnDeleteEliminar(int idsolicitud)
        {
            try
            {
                var result = await soliService.Delete(new()
                {
                    IdSolicitud = idsolicitud
                }
                );

                return new JsonResult(result);
            }

            catch (Exception ex)
            {

                return new JsonResult(new DBEntity

                { CodeError = ex.HResult, MsgError = ex.Message });
            }
        }


    }
}
