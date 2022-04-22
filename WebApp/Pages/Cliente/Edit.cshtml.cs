using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WBL;
using Entity;

namespace WebApp.Pages.Cliente
{
    public class EditModel : PageModel
    {

        private readonly IClienteService cliente;

        public EditModel(IClienteService cliente)
        {
            this.cliente = cliente;
        }

        [BindProperty(SupportsGet = true)]

        public int? id {get; set;}

        [BindProperty]
        public ClienteEntity Entity { get; set; } = new ClienteEntity();



        public async Task<IActionResult> OnGet()
        {
            try
            {
                if (id.HasValue)
                {
                    Entity = await cliente.GetById(Entity: new()
                    {
                        idCliente=id

                    });

                    return Page();

            }
            catch (Exception ex)
            {

                return Content(content: ex.Message);            
            }

        }

        public async Task<IActionResult> OnPostAsync()
        {
            //ACTUALIZACION

            if(Entity.IdCliente.HasValue)
            {

                var result = await cliente.Update(Entity: Entity);

                if (result.CodeError != 0) throw new Exception(message: result.MsgError);
                TempData[key: "Msg"] = "Actualización Realizada";
                    
            }

            else //metodo de insertar
            {

                var result = await cliente.create(Entity: Entity);

                if (result.CodeError != 0) throw new Exception(message: result.MsgError);
                TempData[key: "Msg"] = "El registro se agregó correctamente";

           }

            return RedirectToPage(pageName: "Grid");

             catch (Exception ex)
            {

                return Content(content: ex.Message);
            }




        }
   
    }

 }
