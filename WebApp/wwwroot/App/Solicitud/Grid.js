"use strict";
var Solicitud;
(function (Solicitud) {
    if (MensajeApp != "") {
        Toast.fire({ icon: "success", title: MensajeApp });
    }
    function OnClickEliminar(id) {
        ComfirmAlert("¿Desea eliminar el registro seleccionado?", "Eliminar", "warning", '#3085d6', '#d33')
            .then(function (result) {
            if (result.isConfirmed) {
                window.location.href = "Solicitud/Grid?handler=Eliminar&id=" + id;
            }
        });
    }
    Solicitud.OnClickEliminar = OnClickEliminar;
    $("#GridView").DataTable();
})(Solicitud || (Solicitud = {}));
//# sourceMappingURL=Grid.js.map