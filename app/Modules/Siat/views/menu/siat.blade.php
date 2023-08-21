<?php
?>
<div id="siat-menu">
	<ul>
		<li><a href="{{ route('siat.sync') }}"><i class="fa fa-sync"></i> Sincronizacion</a></li>
		<li><a href="{{ route('siat.cufds') }}"><i class="fa fa-tasks"></i> CUFDs</a></li>
		<li><a href="{{ route('siat.branches') }}"><i class="fa fa-building"></i> Sucursales</a></li>
		<li><a href="{{ route('siat.pointofsales') }}"><i class="fa fa-cash-register"></i> Puntos de Venta</a></li>
		@if( $siat_settings->show_customers_menu )
		<li><a href="{{ route('siat.clientes') }}"><i class="fa fa-users"></i> Clientes</a></li>
		@endif
		@if( $siat_settings->show_products_menu )
		<li><a href="{{ route('siat.productos') }}"><i class="fa fa-box"></i> Productos</a></li>
		@endif
		<li><a href="{{ route('siat.eventos') }}"><i class="fa fa-calendar"></i> Eventos</a></li>
		<li><a href="{{ route('siat.facturas') }}"><i class="fa fa-receipt"></i> Facturas</a></li>
		<li><a href="{{ route('siat.facturador') }}"><i class="fa fa-coins"></i> Facturador</a></li>
		<li><a href="{{ route('siat.config') }}"><i class="fa fa-cog"></i> Configuraci&oacute;n</a></li>
	</ul>
</div>