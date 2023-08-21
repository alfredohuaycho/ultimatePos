<?php
function sb_siat_autload()
{
	spl_autoload_register(function($className)
	{
		$baseNamespace 	= 'SinticBolivia\\SBFramework\\Modules\\Invoices\\Classes\\Siat';
		$classPath 		= $basepath = str_replace([$baseNamespace, '\\'],  ['', SB_DS], $className);
		$classFilename 	= BASEPATH . $classPath . '.php';
		//var_dump($className, $classPath, $classFilename);echo "\n\n";
		if( is_file($classFilename) )
			require_once $classFilename;
	}, true, true);
}

function formatXML($xmlFilepath)
{
	if( is_array($xmlFilepath) || is_object($xmlFilepath) )
		return false;
	
	$loadxml = is_file($xmlFilepath) ? simplexml_load_file($xmlFilepath) : ( simplexml_load_string($xmlFilepath) );
	
	$dom = new DOMDocument('1.0');
	$dom->preserveWhiteSpace = false;
	$dom->formatOutput = true;
	$dom->loadXML($loadxml->asXML());
	$formatxml = new SimpleXMLElement($dom->saveXML());
	//$formatxml->saveXML("testF.xml"); // save as file
	
	return $formatxml->saveXML();
}
function sb_siat_debug($str, $isXml = false)
{
    print_r( $isXml ? formatXML($str) : $str);
}
/**
 * Parse SIAT messages list
 * 
 * @param object $obj
 * @return string[]
 */
function sb_siat_get_messages(object $obj)
{
	if( !isset($obj->mensajesList) )
		return [];
	$res = [];
	if( is_object($obj->mensajesList) )
		$res[] = sprintf("SIAT MENSAJE: (%d) %s", $obj->mensajesList->codigo, $obj->mensajesList->descripcion);
	else
		foreach($obj->mensajesList as $msg)
		{
			$res[] = sprintf("SIAT MENSAJE: (%d) %s", $msg->codigo, $msg->descripcion);
		}
	
	return $res;
}
function sb_siat_message(object $obj, $sep = ';')
{
	$res = sb_siat_get_messages($obj);
	
	return implode($sep, $res);
}
function sb_sanitize_xml_text($str)
{
	return str_replace(['<', '>', '&', "'", '"'], ['&#60;', '&#62;', '&#38;', '&#39;', '&#34;'], $str);
}