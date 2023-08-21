<?php
namespace App\Modules\Siat\Classes;

use App\Modules\Siat\Entities\Invoice;
use Exception;

class ExceptionInvalidInvoiceData extends \Exception
{
	/**
	 * @var Invoice
	 */
	public	$invoice;
	
	public function __construct($message, $code = null, ?Invoice $invoice = null)
	{
		parent::__construct($message, $code);
		$this->invoice = $invoice;
	}
}