<?php
?>
@extends('layouts.app')
@section('title', __('home.home'))

@section('content')
<section class="content-header">
    <h1>CUFDs SIAT</h1>
</section>
<!-- Main content -->
<section class="content">
	<div id="siat-app">
		<siat-cufd-listing />
	</div>
</section>
@section('javascript')
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
<script src="{{ asset('js/modules/siat/components/cufd-listing.js') }}"></script>
<script src="{{ asset('js/modules/siat/app.js') }}"></script>
@endsection
@endsection