<?php
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;

$payAmount = $invoice->total - $invoice->monto_giftcard;
?>
<style>
@page{margin: 20px;}
*{font-size:11px;font-family: Arial, Verdana, Helvetica;}
</style>
<?php $count = 0;?>
<?php foreach($invoices as $i => $invoice): ?>
<div style="float:left;width:50%;border:1px solid #ececec;padding:2px;height:190px;">
	<table>
	<tr>
		<td style="width:30%;">&nbsp;</td>
		<td style="width:70%;">
			<div>NIT: <?php print $invoice->nit_emisor ?></div>
			<div>Nro Factura: <?php print $invoice->invoice_number ?></div>
			<div>Cod. Autorizacion: <?php print $invoice->cuf ?></div>
		</td>
	</tr>
	</table>
	<div style="text-align:center;text-transform:uppercase;">Factura con derecho a credito fiscal</div>
	<div style="text-align:center;text-transform:uppercase;font-weight:bold;">
		<div style="font-size:18px;"><?php print $invoice->items()->first()->product_name ?></div>
		<div style="font-size:18px;"><?php print $invoice->items()->first()->price ?></div>
		<div style="font-size:9px;">Son: <?php print sb_num2letras($invoice->items()->first()->price) ?></div>
	</div>
	<div style="text-align:center;font-size:8px;">ESTA FACTURA CONTRIBUYE AL DESARROLLO DEL PAÍS, EL USO ILÍCITO SERÁ SANCIONADO PENALMENTE DE ACUERDO A LEY</div>
	<div style="text-align:center;font-size:8px;"><?php print $invoice->leyenda ?></div>
	<div style="text-align:center;font-size:8px;">Este documento es la Representación Gráfica de un Documento Fiscal Digital emitido en una modalidad de facturación en línea</div>
</div>
<?php $count++; if( $count == 2 ): $count = 0; ?>
<div style="width:100%;"></div><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<?php endif; ?>
<?php endforeach; ?>
