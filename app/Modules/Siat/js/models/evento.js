(function(ns)
{
	class Evento extends ns.Model
	{
		constructor()
		{
			super();
			this.id = 0;
			this.sucursal_id = 0;
			this.puntoventa_id = '';
			this.evento_id = '';
			this.fecha_inicio = new Date();
			this.fecha_fin = null;
			this.cafc = null;
			this.cufd_evento = '';
		}
	}
	ns.Evento = Evento;
})(SBFramework.Models);