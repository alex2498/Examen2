using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WBL;
using Entity;

namespace WebApp.Pages.Servicio
{
    public class EditModel : PageModel
    {
        
            private readonly IServicioService servicio;

            public EditModel(IServicioService Servicio)
            {
                servicio = Servicio;
            }

            [BindProperty(SupportsGet = true)]
            public int? id { get; set; }

            [BindProperty]
            public ServicioEntity Entity { get; set; } = new ServicioEntity();


            public async Task<IActionResult> OnGet()
            {
                try
                {
                    if (id.HasValue)
                    {
                        Entity = await servicio.GetById(new()
                        {
                            IdServicio = id
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

                    if (Entity.IdServicio.HasValue)
                    {
                        var result = await servicio.Update(Entity);
                        if (result.CodeError != 0) throw new Exception(result.MsgError);
                        TempData["Msg"] = "EL registro se actualizo correctamentre";


                    }
                    else
                    {   //Metodo de Inserción
                        var result = await servicio.Create(Entity);
                        if (result.CodeError != 0) throw new Exception(result.MsgError);
                        TempData["Msg"] = "EL registro se agrego correctamentre";


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
