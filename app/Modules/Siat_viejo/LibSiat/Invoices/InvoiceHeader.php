<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Message;
use Exception;

class InvoiceHeader extends Message
{
	public	$nitEmisor;
	public	$razonSocialEmisor;
	public	$municipio;
	public	$telefono;
	public	$numeroFactura;
	public	$cuf;
	public	$cufd;
	public	$codigoSucursal;
	public	$direccion;
	public	$codigoPuntoVenta;
	public	$fechaEmision;
	public	$nombreRazonSocial;
	public	$codigoTipoDocumentoIdentidad;
	public	$numeroDocumento;
	public	$complemento;
	public	$codigoCliente;
	public	$codigoMetodoPago;
	public	$numeroTarjeta;
	protected	$numeroTarjetaReal;
	public	$montoTotal;
	public	$montoTotalSujetoIva;
	public	$codigoMoneda;
	public	$tipoCambio;
	public	$montoTotalMoneda;
	public	$montoGiftCard = null;
	public	$descuentoAdicional;
	public	$codigoExcepcion;
	public	$cafc;
	public	$leyenda = 'Ley Nro 453: Tienes derecho a recibir información sobre las características y contenidos de los servicios que utilices.';
	public	$usuario;
	public	$codigoDocumentoSector;
	
	public function __construct()
	{
		$this->xmlAttributes = [
			//'codigoPuntoVenta'	=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'complemento' 		=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'numeroTarjeta' 	=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'montoGiftCard'		=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'codigoExcepcion' 	=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'cafc' 				=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
		];
	}
	public function validate()
	{
		if( empty($this->nitEmisor) )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "nitEmisor"');
		if( empty($this->cufd) )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "cufd"');
		if( empty($this->cuf) )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "cuf"');
		if( !(int)$this->codigoDocumentoSector )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "codigoDocumentoSector"');
		if( empty($this->telefono) )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "telefono"');
		if( empty($this->direccion) )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "direccion"');
		if( empty($this->nombreRazonSocial) )
			throw new Exception('[SiatInvoice:ERROR] Invalid data "nombreRazonSocial"');
		/*
		if( (int)$this->codigoPuntoVenta >= 0 )
			unset($this->xmlAttributes['codigoPuntoVenta']);
		if( $this->montoGiftCard !== null )
			unset($this->xmlAttributes['montoGiftCard']);
		if( !empty($this->complemento) )
			unset($this->xmlAttributes['complemento']);
		if( (int)$this->numeroTarjeta )
			unset($this->xmlAttributes['numeroTarjeta']);
		if( !empty($this->cafc) )
			unset($this->xmlAttributes['cafc']);
		*/
		foreach($this->xmlAttributes as $attr => $data)
		{
			//var_dump($attr, $this->$attr);
			if( $this->$attr === null ) continue;
			//if( (int)$this->$attr === 0 || !empty($this->$attr) )
				unset($this->xmlAttributes[$attr]);
		}
	}
	/**
	 * Verifica los montos de la factura
	 */
	public function checkAmounts()
	{
		if( (float)$this->montoGiftCard > 0 )
		{
			//$this->montoTotalSujetoIva = $this->montoTotal - $this->montoGiftCard;
		}
	}
	public function setNumeroTarjetaReal($num)
	{
		$this->numeroTarjetaReal = $num;
	}
	public function getNumeroTarjetaReal()
	{
		return $this->numeroTarjetaReal;
	}
	public function obfuscarTarjeta($save = true, $asignar = true)
	{
		if( empty($this->numeroTarjeta) /*|| strlen($this->numeroTarjeta) < 16*/ )
			return null;
		if( $save )
			$this->numeroTarjetaReal = $this->numeroTarjeta;
		
		$fd = substr($this->numeroTarjeta, 0, 4);
		$ld = substr($this->numeroTarjeta, -4);
		
		$tarjeta =  sprintf("%s%s", str_pad($fd, 12, '0'), $ld);
		if( $asignar )
			$this->numeroTarjeta = $tarjeta;
		return $tarjeta;
	}
	public function recuperarTarjeta()
	{
		$this->numeroTarjeta = $this->numeroTarjetaReal;
	}
}