<?php
// var_dump($siat_settings);die;
?>
@extends($layout)
@section('title', __('home.home'))

@section('content')
<section class="content-header">
    <h1>Sincronizacion SIAT</h1>
</section>
<!-- Main content -->
<section class="content">
	<div id="siat-app">
		<siat-sync />
	</div>
</section>
@endsection
@if( $siat_settings->isUltimatePOS() )
@section($section_scripts)
@else
@push($section_scripts)
@endif
<script>window.lt = {baseurl: '{{ url('/') }}'};</script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.7.13"></script>
<script src="{{ asset('js/modules/siat/config.js') }}"></script>
<script src="{{ asset('js/modules/siat/plugins/processing.js') }}"></script>
<script src="{{ asset('js/modules/siat/plugins/toast.js') }}"></script>
<script src="{{ asset('js/modules/siat/siat-config.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/Model.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/User.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/invoice.js') }}"></script>
<script src="{{ asset('js/modules/siat/api.js') }}"></script>
<script src="{{ asset('js/modules/siat/service-invoices.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-actividades.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-actividades-documento-sector.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-anulacion.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-codigos.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-documentos-identidad.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-eventos.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-leyendas.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-productos-servicios.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-documento-sector.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-emision.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-factura.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-habitacion.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-metodo-pago.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-moneda.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-tipos-punto-venta.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sync-unidades-medida.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/siat-sync.js') }}"></script>
<script src="{{ asset('js/modules/siat/app.js') }}"></script>
@if( $siat_settings->isUltimatePOS() )
@endsection
@else
@endpush
@endif