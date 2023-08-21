(function(ns)
{
	class Invoice extends ns.Model
	{
		constructor()
		{
			super();
			this.invoice_id 				= 0;
			this.dosage_id 					= 0;
			this.customer_id 				= 0;
			this.customer 					= '';
			this.user_id 					= 0;
			this.store_id					= 0;
			this.nit_ruc_nif 				= '';
			this.tax_id						= 0;
			this.tax_rate					= 0;
			this.subtotal					= 0;
			this.total_tax					= 0;
			this.discount					= 0;
			this.monto_giftcard				= 0;
			this.total						= 0;
			this.cash						= 0;
			this.invoice_number				= 0;
			this.control_code				= '';
			this.authorization				= '';
			this.invoice_date_time 			= '';
			this.invoice_limite_date 		= '';
			this.currency_code				= '';
			this.status						= '';
			this.codigo_sucursal			= 0;
			this.punto_venta				= 0;
			this.actividad_economica		= 0;
			this.codigo_documento_sector	= 1; //compra venta
			this.tipo_documento_identidad	= 1;
			this.codigo_metodo_pago			= 1;
			this.codigo_moneda				= 1;
			this.cufd						= '';
			this.cuf						= '';
			this.cafc						= '';
			this.complemento				= null;
			this.numero_tarjeta				= null;
			this.tipo_cambio				= 1;
			this.evento_id					= null;
			this.siat_id					= null;
			this.tipo_emision				= 1; //ONLINE
			this.tipo_factura_documento		= 1; //CREDITO FISCAL
			this.tipo_producto_id			= '';
			this.items						= [];
			this.dosage						= '';
			this.data						= {excepcion: 0, custom_fields: {}};
		}
		get tipoDeCambio()
		{
			return this.tipo_cambio;
		}
		set tipoDeCambio(val)
		{
			this.tipo_cambio = isNaN(parseFloat(val)) ? 0 : parseFloat(val);
		}
		get excepcion()
		{
			return this.data['excepcion'] || 0;
		}
		set excepcion(val)
		{
			this.data['excepcion'] = val;
		}
		setCustomField(field_name, field_value)
		{
			this.data.custom_fields[field_name] = field_value;
		}
		getCustomField()
		{
			return this.data.custom_fields[field_name] || null;
		}
		/*
		get numeroTarjeta()
		{
			if( this.data && this.data.numero_tarjeta )
				return this.data.numero_tarjeta;
				
			return '';
		}
		set numeroTarjeta(val)
		{
			this.data['numero_tarjeta'] = val;
		}
		*/
	}
	ns.Invoice = Invoice;
})(SBFramework.Models);