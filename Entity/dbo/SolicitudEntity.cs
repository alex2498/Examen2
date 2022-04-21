using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
   public class SolicitudEntity : DBEntity
    {
        public int? IdSolicitud { get; set; }
        public int? IdCliente { get; set; }
        public int? IdServicio { get; set; }
        public int? Cantidad { get; set; }
        public double? Monto { get; set; }
        public DateTime FechaEntrega { get; set; } = DateTime.Now;
        public string usuarioEntrega { get; set; }
        public string observaciones { get; set; }
    }
}
