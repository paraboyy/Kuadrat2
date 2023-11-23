<?php

namespace App\Http\Middleware;

// Update path from Fideloper\Proxy\TrustProxies
// refernces: https://laracasts.com/discuss/channels/laravel/class-fideloperproxytrustproxies-not-found
use Illuminate\Http\Middleware\TrusProxies as Middleware;
use Illuminate\Http\Request;

class TrustProxies extends Middleware
{
    /**
     * The trusted proxies for this application.
     *
     * @var array|string
     */
    protected $proxies;

    /**
     * The headers that should be used to detect proxies.
     *
     * @var int
     */
    protected $headers = Request::HEADER_X_FORWARDED_ALL;
}
