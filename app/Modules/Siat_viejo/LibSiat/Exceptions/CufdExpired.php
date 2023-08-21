<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Exceptions;

use Exception;

class CufdExpired extends Exception
{
	public function __construct($message = null, $code = null, $previous = null)
	{
		parent::__construct($message, $code, $previous);
	}
}