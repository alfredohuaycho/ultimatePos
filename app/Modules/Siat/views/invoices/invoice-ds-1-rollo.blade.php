<?php
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
$payAmount = $invoice->total - $invoice->giftcard_amount;
?>
<style>
@page {
  size: 3.3in 14in portrait;
  margin: 15px;
}
*{font-size:11px;font-family: Arial, Verdana, Helvetica;}
#invoice-container{}
</style>
<div id="invoice-container">
	<div style="text-align:center;margin:20px 0;">
		<div style="text-align:center;">
			<?php if( isset($logo) ): ?>
			<div>
				<img src="data:<?php print $logo_mime ?>;base64,<?php print $logob64 ?>" style="height:45px;" />
			</div>
			<?php endif; ?>
		</div>
		<div style="text-align:center;font-weight:bold;">FACTURA</div>
		<div style="text-transform: uppercase;">
			<?php if( $invoice->tipo_factura_documento == SiatInvoice::FACTURA_DERECHO_CREDITO_FISCAL ): ?>
			Con Derecho a Credito Fiscal
			<?php elseif( $invoice->tipo_factura_documento == SiatInvoice::FACTURA_SIN_DERECHO_CREDITO_FISCAL ): ?>
			Sin Derecho a Credito Fiscal
			<?php endif;?>
		</div>
	</div>
	<div style="text-align:center;">
		<div><?php print $config->razonSocial ?></div>
		<div><?php print $sucursal ? (sprintf("Sucursal No. %d, %s", $sucursal->code, $sucursal->name)) : 'CASA MATRIZ' ?></div>
		<div>Nro. Punto de Venta <?php print $invoice->codigo_puntoventa ?></div>
		<div><?php print $cufd->direccion ?></div>
		<div><?php //print $cufd->direccion ?></div>
		<div>Telf: <?php print $config->telefono ?></div>
		<div><?php print $sucursal ? $sucursal->city : ($config->ciudad ?: 'LA PAZ') ?></div>
	</div>
	<hr/>
	<div style="text-align:center;">
		<div>
			<div><b>NIT</b></div>
			<div><?php print $config->nit ?></div>
		</div>
		<div>
			<div><b>FACTURA NRO.</b></div>
			<div><?php print $invoiceNum ?></div>
		</div>
		<div>
			<div><b>COD. AUTORIZACIÓN</b></div>
			<div>
				<?php print chunk_split($invoice->cuf, 35, '<br>') ?>
			</div>
		</div>
	</div>
	<table style="width:100%;border-collapse:collapse; table-layout:fixed;">
	<tr>
		<td><b>Nombre/Razon Social:</b></td>
		<td><?php print $invoice->customer ?></td>
	</tr>
	<tr>
		<td><b>NIT/CI/CEX:</b></td>
		<td><?php printf("%s%s", $invoice->nit_ruc_nif, (!empty($invoice->complemento) ? ('-'.$invoice->complemento) : '')) ?></td>
	</tr>
	<tr>
		<td><b>Cod. Cliente</b></td>
		<td><?php print $invoice->getCustomer()->customer_id ?></td>
	</tr>
	<tr>
		<td><b>Fecha:</b></td>
		<td><?php print sb_format_datetime(strtotime($invoice->invoice_date_time)) ?></td>
	</tr>
	</table>
	<hr/>
	<div style="font-weight: bold;text-align:center;margin:10px 0;"><b>DETALLE</b></div>
	<table style="width:100%;border-collapse: collapse;">
	<tbody>
	<?php foreach($invoice->items as $item): ?>
	<tr>
		<td style="">
			<div><?php print $item->product_code ?> <?php print $item->product_name ?></div>
			<div><?php _('Unidad Medida'); ?>: <?php print $syncModel->getUnidadMedidaPorCodigoS(0, 0, $item->unidad_medida) ?></div>
			<div>
				<?php print sb_number_format($item->quantity) ?> X <?php print sb_number_format($item->price) ?> - <?php print sb_number_format($item->discount) ?>
			</div>
			<?php //print $this->siatSyncModel->getUnidadMedidaPorCodigo($user, 0, 0, $item->unidad_medida) ?>
		</td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($item->total) ?></div>
		</td>
	</tr>
	<?php endforeach; ?>
	</tbody>
	<tfoot>
	<tr>
		<td style="text-align:right;"><b>SUBTOTAL</b></td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($invoice->subtotal) ?></div>
		</td>
	</tr>
	<tr>
		<td style="text-align:right;"><b>DESCUENTO</b></td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($invoice->discount) ?></div>
		</td>
	</tr>
	<tr>
		<td style="text-align:right;"><b>TOTAL</b></td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($invoice->total) ?></div>
		</td>
	</tr>
	<tr>
		<td style="text-align:right;"><b>MONTO GIFT CARD</b></td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($invoice->monto_giftcard) ?></div>
		</td>
	</tr>
	<tr>
		<td style="text-align:right;"><b>MONTO A PAGAR</b></td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($payAmount) ?></div>
		</td>
	</tr>
	<tr>
		<td style="text-align:right;"><b>IMPORTE BASE CREDITO FISCAL</b></td>
		<td style="">
			<div style="text-align:right;"><?php print sb_number_format($payAmount) ?></div>
		</td>
	</tr>
	</tfoot>
	</table>
	<br>
	<div>
		Son: <?php print sb_num2letras($payAmount) ?>
	</div>
	<hr/>
	<div style="text-align:center;">
		<?php print 'ESTA FACTURA CONTRIBUYE AL DESARROLLO DEL PAÍS, EL USO ILÍCITO SERÁ SANCIONADO PENALMENTE DE ACUERDO A LEY' ?>
	</div>
	<br>
	<div style="text-align:center;"><?php print $invoice->leyenda ?></div>
	<br>
	<div style="text-align:center;">
		&quot;
		<?php if( $invoice->tipo_emision == SiatInvoice::TIPO_EMISION_OFFLINE || $invoice->evento_id ): ?>
		Este documento es la Representacion Grafica de un Documento Fiscal Digital emitido fuera de linea, verifique su envio con su proveedor o
		en la pagina www.impuestos.gob.bo
		<?php elseif( $invoice->tipo_emision == SiatInvoice::TIPO_EMISION_ONLINE ): ?>
		Este documento es la Representación Gráfica de un Documento Fiscal Digital emitido en una modalidad de facturación en línea
		<?php endif; ?>
		&quot;
	</div>
	<br>
	<div style="text-align:center;"><img src="<?php print $qr64 ?>" alt="" width="110" /></div>
</div>