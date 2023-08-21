<?php
?>
@extends($layout)
@section('title', __('home.home'))

@section('content')
<section class="content-header">
    <h1>Configuracion SIAT</h1>
</section>
<!-- Main content -->
<section class="content">
	<div id="siat-app">
		<siat-config />
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
<script src="{{ asset('js/modules/siat/config.js') }}"></script>
<script src="{{ asset('js/modules/siat/plugins/processing.js') }}"></script>
<script src="{{ asset('js/modules/siat/plugins/toast.js') }}"></script>
<script src="{{ asset('js/modules/siat/siat-config.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/Model.js') }}"></script>
<script src="{{ asset('js/modules/siat/models/User.js') }}"></script>
<script src="{{ asset('js/modules/siat/mixins/mixin-common.js') }}"></script>
<script src="{{ asset('js/modules/siat/api.js') }}"></script>
<script src="{{ asset('js/modules/siat/service-config.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/config.js') }}"></script>
<script src="{{ asset('js/modules/siat/app.js') }}"></script>
@if( $siat_settings->isUltimatePOS() )
@endsection
@else
@endpush
@endif
