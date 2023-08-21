<?php
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;

$payAmount = $invoice->total - $invoice->monto_giftcard;
?>
<style>
@page{margin: 20px;}
*{font-size:11px;font-family: Arial, Verdana, Helvetica;}
</style>
<table style="width:100%;border-collapse:collapse; table-layout:fixed;">
<tr>
	<td style="width:50%;">
		<div style="text-align:center;">
			<?php if( isset($logo) ): ?>
			<div>
				<img src="data:<?php print $logo_mime ?>;base64,<?php print $logob64 ?>" style="height:45px;" />
			</div>
			<?php endif; ?>
			<div><b><?php print $config->razonSocial ?></b></div>
			<div>CASA MATRIZ</div>
			<div>Nro. Punto de Venta <?php print $invoice->punto_venta ?></div>
			<div><?php print $cufd->direccion ?></div>
			<div><?php //print $cufd->direccion ?></div>
			<div>Telf: <?php print $config->telefono ?></div>
			<div><?php print $config->ciudad ?: 'LA PAZ' ?></div>
		</div>
	</td>
	<td style="width:50%;">
		<div style="text-align:right;">
			<table style="">
			<tr>
				<td><b>NIT</b></td>
				<td><?php print $config->nit ?></td>
			</tr>
			<tr>
				<td><b>FACTURA NRO.</b></td>
				<td><?php print $invoiceNum ?></td>
			</tr>
			<tr>
				<td><b>COD. AUTORIZACIÓN</b></td>
				<td>
					<?php print chunk_split($invoice->cuf, 25, '<br>') ?>
				</td>
			</tr>
			</table>
		</div>
	</td>
</tr>
<tr>
	<td colspan="2" style="">
		<div style="text-align:center;margin:20px 0;">
			<div style="text-align:center;font-size:25px;font-weight:bold;">FACTURA</div>
			<div>
				(Con Derecho a Credito Fiscal)
			</div>
		</div>
	</td>
</tr>
<tr>
	<td style="width:50%;">
		<table>
		<tr>
			<td><b>Fecha:</b></td>
			<td><?php print sb_format_datetime(strtotime($invoice->invoice_datetime)) ?></td>
		</tr>
		<tr>
			<td><b>Nombre/Razon Social:</b></td>
			<td><?php print $invoice->customer ?></td>
		</tr>
		</table>
	</td>
	<td style="width:50%;">
		<table>
		<tr>
			<td><b>NIT/CI/CEX:</b></td>
			<td><?php printf("%s%s", $invoice->nit_ruc_nif, (!empty($invoice->complemento) ? ('-'.$invoice->complemento) : '')) ?></td>
		</tr>
		<tr>
			<td><b>Cod. Cliente</b></td>
			<td><?php print $invoice->getCustomer()->contact_id ?></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table style="width:100%;border-collapse: collapse;">
<thead>
<tr>
	<th style="border:1px solid #000;">CODIGO PRODUCTO/SERVICIO</th>
	<th style="border:1px solid #000;">CANTIDAD</th>
	<th style="border:1px solid #000;">UNIDAD MEDIDA</th>
	<th style="border:1px solid #000;">DESCRIPCION</th>
	<th style="border:1px solid #000;">PRECIO UNITARIO</th>
	<th style="border:1px solid #000;">DESCUENTO</th>
	<th style="border:1px solid #000;">SUBTOTAL</th>
</tr>
</thead>
<tbody>
<?php foreach($invoice->items as $item): ?>
<tr>
	<td style="border:1px solid #000;">
		<div style="text-align:center;"><?php print $item->product_code ?></div>
	</td>
	<td style="border:1px solid #000;">
		<div style="text-align:center;"><?php print $item->quantity ?></div>
	</td>
	<td style="border:1px solid #000;">
		<div style="text-align:center;">
			<?php print $syncModel->getUnidadMedidaPorCodigoS(0, 0, $item->unidad_medida) ?>
		</div>
	</td>
	<td style="border:1px solid #000;"><?php print nl2br($item->product_name) ?></td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($item->price) ?></div>
	</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($item->discount) ?></div>
	</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($item->total) ?></div>
	</td>
</tr>
<?php endforeach; ?>
</tbody>
<tfoot>
<tr>
	<td colspan="4"></td>
	<td colspan="2" style="border:1px solid #000;text-align:right;">SUBTOTAL</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($invoice->subtotal) ?></div>
	</td>
</tr>
<tr>
	<td colspan="4"></td>
	<td colspan="2" style="border:1px solid #000;text-align:right;">DESCUENTO</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($invoice->discount) ?></div>
	</td>
</tr>
<tr>
	<td colspan="4">
		Son: <?php print sb_num2letras($payAmount) ?>
	</td>
	<td colspan="2" style="border:1px solid #000;text-align:right;">TOTAL</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($invoice->total) ?></div>
	</td>
</tr>
<tr>
	<td colspan="4">
	</td>
	<td colspan="2" style="border:1px solid #000;text-align:right;">MONTO GIFT CARD</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($invoice->monto_giftcard) ?></div>
	</td>
</tr>
<tr>
	<td colspan="4"></td>
	<td colspan="2" style="border:1px solid #000;text-align:right;">MONTO A PAGAR</td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($payAmount) ?></div>
	</td>
</tr>
<tr>
	<td colspan="4"></td>
	<td colspan="2" style="border:1px solid #000;text-align:right;"><b>IMPORTE BASE CREDITO FISCAL</b></td>
	<td style="border:1px solid #000;">
		<div style="text-align:right;"><?php print sb_number_format($payAmount) ?></div>
	</td>
</tr>
</tfoot>
</table>
<br>
<br>
<table style="width:100%;">
<tr>
	<td style="width:80%;text-align:center;">
		<div>
			<?php print 'ESTA FACTURA CONTRIBUYE AL DESARROLLO DEL PAÍS, EL USO ILÍCITO SERÁ SANCIONADO PENALMENTE DE ACUERDO A LEY' ?>
		</div>
		<br>
		<div><?php print $invoice->leyenda ?></div>
		<div>
			&quot;
			<?php if( $invoice->tipo_emision == SiatInvoice::TIPO_EMISION_OFFLINE || $invoice->evento_id ): ?>
			Este documento es la Representacion Grafica de un Documento Fiscal Digital emitido fuera de linea, verifique su envio con su proveedor o
			en la pagina www.impuestos.gob.bo
			<?php elseif( $invoice->tipo_emision == SiatInvoice::TIPO_EMISION_ONLINE ): ?>
			Este documento es la Representación Gráfica de un Documento Fiscal Digital emitido en una modalidad de facturación en línea
			<?php endif; ?>
			&quot;
		</div>
	</td>
	<td style="width:20%;">
		<div style="text-align:center;"><img src="<?php print $qr64 ?>" alt="" width="110" /></div>
	</td>
</tr>
</table>