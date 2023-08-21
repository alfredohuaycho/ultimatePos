<?php
?>
@extends($layout)
@section('title', __('home.home'))

@section('content')
<section class="content-header">
    <h1>Facturador SIAT</h1>
</section>
<!-- Main content -->
<section class="content">
	<div id="siat-app">
		<siat-invoicer></siat-invoicer>
	</div>
</section>
@endsection
@if( $siat_settings->isUltimatePOS() )
@section($section_scripts)
@else
@push($section_scripts)
@endif
<script>window.lt = {baseurl: '{{ url('/') }}'};</script>
<script src="https://v2.vuejs.org/js/vue.js"></script>
<script src="{{ asset('js/modules/siat/functions.js') }}"></script>
<script src="{{ asset('js/modules/siat/config.js') }}"></script>
<script src="{{ asset('js/modules/siat/plugins/processing.js') }}"></script>
<script src="{{ asset('js/modules/siat/plugins/toast.js') }}"></script>
<script src="{{ asset('js/modules/siat/siat-config.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/Model.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/User.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/invoice.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/evento.js') }}"></script>
<script src="{{ asset('js/modules/siat/api.js') }}"></script>
<script src="{{ asset('js/modules/siat/service-invoices.js') }}"></script>
@if( $siat_settings->isUltimatePOS() )
<script src="{{ asset('js/modules/siat/service-up-customers.js') }}"></script>
@else
<script src="{{ asset('js/modules/siat/service-customers.js') }}"></script>
@endif
<script src="{{ asset('js/modules/siat/service-events.js') }}"></script>
<script src="{{ asset('js/modules/siat/mixins/mixin-common.js') }}"></script>
<script src="{{ asset('js/modules/siat/mixins/mixin-events.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/completion.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/dropdown.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/customer-form.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/cerrar-evento.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/hoteles.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/hospitales.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/colegios.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/entidad-financiera.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/turistico-hospedaje.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/tasa-cero.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/exportacion-servicio.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/exportacion.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/alquiler.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/sectores/prevalorada.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/invoicer-top.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/invoicer.js') }}"></script>
<script src="{{ asset('js/modules/siat/app.js') }}"></script>
@if( $siat_settings->isUltimatePOS() )
@endsection
@else
@endpush
@endif
