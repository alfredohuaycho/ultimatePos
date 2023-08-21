<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat;

use Exception;
use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Exceptions\CufdExpired;

/**
 * Clase que almacena la configuracion para el servicio de facturacion
 * @author mac
 *
 */
class SiatConfig extends SiatObject
{
	/**
	 * @var string
	 */
	public	$nombreSistema;
	/**
	 * @var string
	 */
	public	$codigoSistema;
	/**
	 * 
	 * @var int
	 */
	public	$tipo;
	/**
	 * @var int
	 */
	public	$nit;
	/**
	 * @var string
	 */
	public	$razonSocial;
	/**
	 * Tipo de modalidad para la facturacion Electronica o Computarizada
	 * @var int
	 */
	public	$modalidad;
	/**
	 * Ambiente para emisionde facturas Piloto o Produccion
	 * @var int
	 */
	public	$ambiente;
	/**
	 * 
	 * @var string
	 */
	public	$tokenDelegado;
	/**
	 * Ciudad o dependencia del contribuyente o dueno del nit
	 * @var string
	 */
	public	$ciudad;
	/**
	 * Telefono  del contribuyente o dueno del nit
	 * @var string
	 */
	public	$telefono;
	/**
	 * 
	 * @var string
	 */
	//public	$cafc;
	/**
	 * @var integer
	 */
	//public	$cafc_inicio_nro_factura;
	/**
	 * @var integer
	 */
	//public	$cafc_fin_nro_factura;
	
	/**
	 * Codigo CUIS
	 * @var SiatConfigCuis
	 */
	public	$cuis			= null;
	/**
	 * Codigo CUF
	 * @var SiatConfigCufd
	 */
	public	$cufd			= null;
	/**
	 * Ruta del archivo de firma digital
	 * @var string
	 */
	public	$pubCert		= null;
	/**
	 * Ruta del archivo de llave privada de la firma digital
	 * @var string
	 */
	public	$privCert		= null;
	/**
	 * Tipo de impresion (Ticket o Media Pagina)
	 * @example page|ticket
	 * @var string
	 */
	public	$tipoImpresion	= 'page';
	public	$sectors = [];
	
	protected	$propsOptions = [
		'cafc' => [
			'desc' => 'Nro. CAFC para la emision de facturas manuales (talonario)'
		],
		'cafc_inicio_nro_factura' => [
			'desc' => 'Nro. de inicio de factura para el codigo CAFC'
		],
		'cafc_fin_nro_factura' => [
			'desc' => 'Nro. de finalizacion de factura para el codigo CAFC'
		],
		'tipoImpresion'=> [
			'desc' => 'Tipo de impresion por defecto (Ticket o Media Pagina)',
			'ops' => ['page' => 'Media Pagina', 'rollo' => 'Ticket/Rollo']
		]
	];
	public function getPropOps($prop)
	{
		return isset($this->propsOptions[$prop]) ? $this->propsOptions[$prop]['ops'] : [];
	}
	public function getPropDesc($prop)
	{
		if( !isset($this->propsOptions[$prop]) )
			return '';
		return isset($this->propsOptions[$prop]['desc']) ? $this->propsOptions[$prop]['desc'] : '';
	}
	/**
	 * 
	 * @return []
	 */
	public static function toArray()
	{
		$self = new \ReflectionClass(self::class);
		$props = $self->getProperties(\ReflectionProperty::IS_STATIC);
		
		$data = [];
		foreach($props as $prop)
		{
			$data[$prop->name] = $prop->getValue(self::class);
		}
		return $data;
	}
	
	public function __construct($data = null)
	{
		if( $data )
			$this->bind($data);
	}
	/**
	 * Asigna datos desde un array u objecto a los propiedades de clases
	 * {@inheritDoc}
	 * @see \SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\SiatObject::bind()
	 */
	public function bind($data)
	{
		parent::bind($data);
		if( isset($data->cuis) )
			$this->cuis = new SiatConfigCuis($data->cuis);
		if( isset($data->cufd) )
			$this->cufd = new SiatConfigCufd($data->cufd);
	}
	/**
	 * Valida datos de configuracion
	 * @throws Exception
	 */
	public function validate()
	{
		list($class, ) = explode('::', __METHOD__);
		
		if( !isset($this->tokenDelegado) )
			throw new Exception("$class ERROR: Token delegado invalido");
		if( !isset($this->nombreSistema) )
			throw new Exception("$class ERROR: Nombre de sistema invalido");
		if( !isset($this->codigoSistema) )
			throw new Exception("$class ERROR: Codigo de sistema invalido");
		if( !in_array((int)$this->ambiente, [1, 2]) )
			throw new Exception("$class ERROR: Codigo de ambiente invalido");
		if( (int)$this->nit <= 0 )
			throw new Exception("$class ERROR: NIT invalido");
		if( !in_array((int)$this->modalidad, [1, 2]) )
			throw new Exception("$class ERROR: Modalidad invalida");
		
	}
	/**
	 * Valida las expiraciones de los codigos CUIS y CUF
	 * @throws Exception
	 * @throws CufdExpired
	 */
	public function validateExpirations()
	{
		$class = static::class;
		if( !$this->cuis )
			throw new Exception("$class ERROR: CUIS no existe");
		if( !$this->cufd )
			throw new Exception("$class ERROR: CUFD no existe");
		if( $this->cuis->expirado() )
			throw new Exception("$class ERROR: CUIS Expirado");
		if( $this->cufd->expirado() )
			throw new CufdExpired("$class ERROR: CUFD Expirado");
	}
}