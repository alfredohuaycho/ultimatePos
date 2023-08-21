<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Exceptions;

use Exception;

class SiatTimeout extends Exception
{
	public $action;
	public $data;
	
	public function __construct($message = null, $code = null, $previous = null, $action = null, $data = null)
	{
		parent::__construct($message, $code, $previous);
		$this->action 	= $action;
		$this->data		= $data;
	}
}