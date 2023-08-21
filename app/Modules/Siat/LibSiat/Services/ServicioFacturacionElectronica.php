<?php
namespace SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Services;

use SinticBolivia\SBFramework\Modules\Invoices\Classes\Siat\Invoices\SiatInvoice;
use RobRichards\XMLSecLibs\XMLSecurityDSig;
use RobRichards\XMLSecLibs\XMLSecurityKey;
use Exception;

/**
 * Clase para el servicio de Facturacion Computarizada en linea
 * @author J. Marcelo Aviles Paco
 *
 */
class ServicioFacturacionElectronica extends ServicioFacturacion
{
	protected	$wsdl = 'https://pilotosiatservicios.impuestos.gob.bo/v2/ServicioFacturacionElectronica?wsdl';
	
	protected	$privateCertFile;
	protected	$publicCertFile;
	
	public function __construct($cuis = null, $cufd = null, $token = null, $endpoint = null)
	{
		parent::__construct($cuis, $cufd, $token, $endpoint);
	}
	public function setPrivateCertificateFile($filename)
	{
		if( !is_file($filename) )
			throw new Exception('PRIVATE CERTIFICATE ERROR: The certificate file "'. $filename .'" does not exists');
		$this->privateCertFile = $filename;
	}
	public function setPublicCertificateFile($filename)
	{
		if( !is_file($filename) )
			throw new Exception('PUBLIC CERTIFICATE ERROR: The certificate file does not exists');
		$this->publicCertFile = $filename;
	}
	public function signInvoice(string $xml)
	{
		if( !$this->privateCertFile || !$this->publicCertFile )
			throw new Exception('INVOICE SIGN PROCESS ERROR: Invalid certificates filenames');
		
		require_once MOD_SIAT_DIR . SB_DS . 'Libs' . SB_DS . 'xmlseclibs' . SB_DS . 'xmlseclibs.php';
		
		$doc = new \DOMDocument();
		$doc->loadXML($xml);
		$objDSig = new XMLSecurityDSig('');
		//$objDSig->setCanonicalMethod(XMLSecurityDSig::EXC_C14N);
		$objDSig->setCanonicalMethod(XMLSecurityDSig::EXC_C14N_COMMENTS);
		$objDSig->addReference($doc, XMLSecurityDSig::SHA256, ['http://www.w3.org/2000/09/xmldsig#enveloped-signature'], ['force_uri' => true]);
		$objKey = new XMLSecurityKey(XMLSecurityKey::RSA_SHA256, array('type'=>'private'));
		$objKey->loadKey($this->privateCertFile, true);
		$objDSig->sign($objKey);
		$objDSig->add509Cert(file_get_contents($this->publicCertFile));
		$objDSig->appendSignature($doc->documentElement);
		
		return $doc->saveXML();
	}
	public function buildInvoiceXml(SiatInvoice $invoice)
	{
		$invoiceXml = $invoice->toXml(null, true)->asXML();
		
		$invoiceXml = $this->signInvoice($invoiceXml);
		return $invoiceXml;
	}
}