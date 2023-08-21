<?php
?>
@extends('layouts.app')
@section('title', __('home.home'))

@section('content')
<section class="content-header">
    <h1>Facturas SIAT</h1>
</section>
<!-- Main content -->
<section class="content">
	<div id="siat-app">
		<siat-invoice-listing></siat-invoice-listing>
	</div>
</section>
@section('javascript')
<script>window.lt = {baseurl: '{{ url('/') }}'};</script>
<script src="https://v2.vuejs.org/js/vue.js"></script>
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
<script src="{{ asset('js/modules/siat/service-customers.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/completion.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/pager.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/void-invoice.js') }}"></script>
<script src="{{ asset('js/modules/siat/components/invoice-listing.js') }}"></script>
<script src="{{ asset('js/modules/siat/app.js') }}"></script>
@endsection
@endsection