<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices;

use Exception;

class InvoiceDetailHospital extends InvoiceDetail
{
	public	$actividadEconomica;
	public	$codigoProductoSin;
	public	$codigoProducto;
	public	$descripcion;
	public	$especialidad; //## CA ##
	public	$especialidadDetalle; //## CA ##
	public	$nroQuirofanoSalaOperaciones; //## CA ##
	public	$especialidadMedico; //## CA ##
	public	$nombreApellidoMedico; //## CA ##
	public	$nitDocumentoMedico; //## CA ##
	public	$nroMatriculaMedico; //## CA ##
	public	$nroFacturaMedico; //## CA ##
	public	$cantidad;
	public	$unidadMedida;
	public	$precioUnitario;
	public	$montoDescuento;
	public	$subTotal;
	
	
	public function __construct()
	{
		parent::__construct();
		$this->xmlAttributes = array_merge($this->xmlAttributes, [
			'especialidad'			=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'especialidadDetalle'	=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'especialidadMedico'	=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'nroMatriculaMedico' 	=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
			'nroFacturaMedico' 		=> [['attr' => 'xsi:nil', 'value' => 'true', 'ns' => 'http://www.w3.org/2001/XMLSchema-instance']],
		]);
		$this->skipProperties[] = 'numeroSerie';
		$this->skipProperties[] = 'numeroImei';
	}
	public function validate()
	{
		
		if( (int)$this->nroMatriculaMedico <= 0 )
			$this->nroMatriculaMedico = null;
		//var_dump($this->nitDocumentoMedico);
		parent::validate();
		if( (int)$this->nitDocumentoMedico <= 0 )
			throw new Exception('Debe ingresar un NIT para el medico. '. $this->nitDocumentoMedico);
		if( (int)$this->nroQuirofanoSalaOperaciones <= 0 )
			throw new Exception('El nro de quirofona debe ser mayor o igual a 1');
	}
}