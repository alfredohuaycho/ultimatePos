<?php
namespace App\Modules\Siat;

class Settings
{
	//public	$customer_endpoint 		= '';
	//public	$products_endpoint 		= '';
	public	$show_products_menu 	= true;
	public	$show_customers_menu 	= true;
	protected	$layout				= 'layouts.app';
	//protected	$layout				= 'Siat::demo.index';
	public		$section_scripts	= 'javascript';
	/**
	 * 
	 * @return string
	 */
	public function customers_endpoint()
	{
		return route('siat.customers');
	}
	public function isUltimatePOS()
	{
		return ( env('APP_NAME') == 'ultimatePOS' );
	}
	public function getLayout()
	{
		return $this->layout;
	}
	/**
	 * 
	 * @return \App\Modules\Siat\Settings
	 */
	public static function getInstance()
	{
		static $obj;
		
		if( !$obj )
			$obj = new static();
		
		return $obj;
	}
}
