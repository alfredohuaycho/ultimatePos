<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Exceptions;

use Exception;

class ExceptionSiatError extends Exception
{
	public $url;
	public $action;
	public $data;
	
	public function __construct($message = null, $code = null, $previous = null, $url = null, $action = null, $data = null)
	{
		parent::__construct($message, $code ?: 0, $previous);
		$this->url		= $url;
		$this->action 	= $action;
		$this->data		= $data;
	}
}