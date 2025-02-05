@php
    use App\Http\Controllers\AbstractController;

    $js_version = AbstractController::getJsVersion();
    $cdash_version = AbstractController::getCDashVersion();
@endphp

<!DOCTYPE html>
<html
    lang="{{ str_replace('_', '-', app()->getLocale()) }}"
    @if(isset($angular) && $angular === true)
        ng-app="CDash"
        ng-strict-di
        ng-cloak
    @endif
>
<head @if(isset($angular) && $angular === true) ng-controller="HeadController" @endif>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="robots" content="noindex,nofollow"/>
    <meta name="csrf-token" content="{{ csrf_token() }}"/>
    <link rel="shortcut icon" href="{{ asset('favicon.ico') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset(mix('build/css/3rdparty.css')) }}"/>

    {{-- Framework-specific details --}}
    @if(isset($angular) && $angular === true)
        <link rel="stylesheet" type="text/css" ng-href="{{ asset("build/css") }}/@{{cssfile}}_{{  $js_version }}.css"/>
        <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}"/>
        <script src="{{ asset("js/CDash_$js_version.min.js") }}"></script>
    @elseif(isset($vue) && $vue === true)
        <link type="text/css" rel="stylesheet" href="{{ asset('css/jquery.dataTables.css') }}"/>
        <link rel="stylesheet" type="text/css" href="{{ asset(get_css_file()) }}"/>
        <link rel="stylesheet" type="text/css" href="{{ asset('css/vue_common.css') }}"/>
        <link rel="stylesheet" type="text/css" href="{{ asset('css/bootstrap.min.css') }}"/>
        <script src="{{ asset('js/3rdparty.min.js') }}" type="text/javascript" defer></script>
        <script src="{{ asset(mix('laravel/js/app.js')) }}" type="text/javascript" defer></script>
    @else
        <link rel="stylesheet" type="text/css" href="{{ asset('css/jquery.dataTables.css') }}"/>
        <link rel="stylesheet" type="text/css" href="{{ asset('css/cdash.css') }}"/>
        <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}"/>
        <script src="{{ asset("js/CDash_${js_version}.min.js") }}"></script>
        <script src="{{ asset('js/tooltip.js') }}" type="text/javascript" charset="utf-8"></script>
        <script src="{{ asset('js/jquery.tablesorter.js') }}" type="text/javascript" charset="utf-8"></script>
        <script src="{{ asset('js/jquery.dataTables.min.js') }}" type="text/javascript" charset="utf-8"></script>
        <script src="{{ asset('js/jquery.metadata.js') }}" type="text/javascript" charset="utf-8"></script>
    @endif

    @yield('header_script')

    <title
        @if(isset($angular) && $angular === true)
            ng-bind="::title"
        @endif
    >@if(isset($title)) {{ $title }} @else CDash @endif</title>
</head>
<body
    @if(isset($angular) && $angular === true)
        ng-controller="{{ $angular_controller }}"
    @endif
>
{{-- This is a horrible hack which allows AngularJS to show the login page when prompted by the API --}}
@if(isset($angular) && $angular === true)
    <div ng-if="cdash.requirelogin == 1" ng-include="'login'"></div>
    <div ng-if="cdash.requirelogin != 1" id="app">
@else
    <div id="app">
@endif
        @section('header')
            @include('components.header')
        @show

        <div id="main_content"
            @if(isset($angular) && $angular === true)
                ng-if="!loading"
            @endif
        >
            @hasSection('main_content')
                @yield('main_content')
            @elseif(isset($xsl) && $xsl === true)
                {!! $xsl_content !!}
            @endif
        </div>

        @section('footer')
            @include('components.footer')
        @show

        @yield('post_content_script')
    </div>
</body>
</html>
