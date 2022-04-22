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
    public class EditModel : PageModel
    {
        private readonly ISolicitudService solicitudservicios;

        public EditModel(ISolicitudService solicitudservicios)
        {
            this.solicitudservicios = 
                solicitudservicios;
        }

        [BindProperty(SupportsGet = true)]
        public int? id { get; set; }

        [BindProperty]
        public SolicitudEntity Entity { get; set; } = new SolicitudEntity();


        public async Task<IActionResult> OnGet()
        {
            try
            {
                if (id.HasValue)
                {
                    Entity = await solicitudservicios.GetById(new()
                    {
                        IdSolicitud = id
                    });
                }

                return Page();

            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }


        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                //Metodo de Actualización
                if (Entity.IdSolicitud.HasValue)
                {
                    var result = await solicitudservicios.Update(Entity);

                    if (result.CodeError != 0) throw new Exception(result.MsgError);
                    TempData["Msg"] = "El registro se actualizó correctamente";

                }
                else
                {   //Metodo de Inserción
                    var result = await solicitudservicios.Create(Entity);

                    if (result.CodeError != 0) throw new Exception(result.MsgError);
                    TempData["Msg"] = "El registro se agregró correctamente";
                }

                return RedirectToPage("Grid");
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }


        }

    }
}
