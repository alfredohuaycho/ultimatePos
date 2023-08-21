<?php
use Illuminate\Support\Facades\Mail;

function sb_user_get_dir()
{
	$path = storage_path() . SB_DS . 'siat';
	if( !is_dir($path) )
		mkdir($path);
	return $path;
}
function sb_number_format($number, $decimals = null, $ds = null, $hs = null)
{
	$decimal_separator 	= $ds !== null ? $ds : (defined('DECIMAL_SEPARATOR') ? DECIMAL_SEPARATOR : '.');
	$hundred_separator 	= $hs !== null ? $hs : (defined('HUNDRED_SEPARATOR') ? HUNDRED_SEPARATOR : ',');
	$decimals 			= $decimals !== null ? (int)$decimals : ((defined('DECIMALS') && (int)DECIMALS) ? DECIMALS : 2);
	
	return number_format((float)$number, $decimals, $decimal_separator, $hundred_separator);
}
function sb_format_date($date, $format = null, $from_format = null)
{
	$date_format = 'Y-m-d';
	if( defined('DATE_FORMAT') )
	{
		$date_format = DATE_FORMAT;
	}
	if( $format )
	{
		$date_format = $format;
	}
	if( is_numeric($date) )
		return date("$date_format", $date);
		
	$date = str_replace('/', '-', $date);
	$the_date = $from_format ? DateTime::createFromFormat($from_format, $date) : new DateTime($date);
	return $the_date ? $the_date->format($date_format) : null;
}
function sb_format_time($time, $format = null)
{
	if( !is_numeric($time) )
	{
		$time = strtotime(str_replace('/', '-', trim($time)));
	}
	$time_format = 'H:i:s';
	if( defined('DATE_FORMAT') )
	{
		$date_format = DATE_FORMAT;
	}
	if( defined('TIME_FORMAT') )
	{
		$time_format = TIME_FORMAT;
	}
	if( $format )
	{
		$time_format = $format;
	}
	//$date_time = strtotime($date);
	
	return date("$time_format", $time);
}
function sb_format_datetime($date, $format = null)
{
	$date_format = 'Y-m-d';
	$time_format = 'H:i:s';
	if( defined('DATE_FORMAT') )
	{
		$date_format = DATE_FORMAT;
	}
	if( defined('TIME_FORMAT') )
	{
		$time_format = TIME_FORMAT;
	}
	$the_format = "$date_format $time_format";
	if( $format != null )
	{
		$the_format = $format;
	}
	if( is_numeric($date) )
		return date("$the_format", $date);
		
	//$date_time = is_numeric($date) ? $date : strtotime($date);
	$date_time = strtotime(str_replace('/', '-', $date));
	return date($the_format, $date_time);
}
if( !function_exists('sb_num2letras')):
/**
 * Convertir numeros a letras (solo español)
 * Máxima cifra soportada: 18 dígitos con 2 decimales
 * --- > 999,999,999,999,999,999.99
 *
 * @param float $xcifra
 * @return string
 */
function sb_num2letras($xcifra, $currency_text = 'BOLIVIANOS')
{
	$xarray = array(
		0 => "Cero",
		1 => "UN",
		"DOS",
		"TRES",
		"CUATRO",
		"CINCO",
		"SEIS",
		"SIETE",
		"OCHO",
		"NUEVE",
		"DIEZ",
		"ONCE",
		"DOCE",
		"TRECE",
		"CATORCE",
		"QUINCE",
		"DIECISEIS",
		"DIECISIETE",
		"DIECIOCHO",
		"DIECINUEVE",
		"VEINTI",
		30 => "TREINTA",
		40 => "CUARENTA",
		50 => "CINCUENTA",
		60 => "SESENTA",
		70 => "SETENTA",
		80 => "OCHENTA",
		90 => "NOVENTA",
		100 => "CIENTO",
		200 => "DOSCIENTOS",
		300 => "TRESCIENTOS",
		400 => "CUATROCIENTOS",
		500 => "QUINIENTOS",
		600 => "SEISCIENTOS",
		700 => "SETECIENTOS",
		800 => "OCHOCIENTOS",
		900 => "NOVECIENTOS"
	);
	//
	$xcifra = trim($xcifra);
	$xlength = strlen($xcifra);
	$xpos_punto = strpos($xcifra, ".");
	$xaux_int = $xcifra;
	$xdecimales = "00";
	if (!($xpos_punto === false)) {
		if ($xpos_punto == 0) {
			$xcifra = "0" . $xcifra;
			$xpos_punto = strpos($xcifra, ".");
		}
		$xaux_int = substr($xcifra, 0, $xpos_punto); // obtengo el entero de la cifra a covertir
		$xdecimales = substr($xcifra . "00", $xpos_punto + 1, 2); // obtengo los valores decimales
	}
	
	$XAUX = str_pad($xaux_int, 18, " ", STR_PAD_LEFT); // ajusto la longitud de la cifra, para que sea divisible por centenas de miles (grupos de 6)
	$xcadena = "";
	for ($xz = 0; $xz < 3; $xz++) {
		$xaux = substr($XAUX, $xz * 6, 6);
		$xi = 0;
		$xlimite = 6; // inicializo el contador de centenas xi y establezco el límite a 6 dígitos en la parte entera
		$xexit = true; // bandera para controlar el ciclo del While
		while ($xexit) {
			if ($xi == $xlimite) { // si ya llegó al límite máximo de enteros
				break; // termina el ciclo
			}
			
			$x3digitos = ($xlimite - $xi) * -1; // comienzo con los tres primeros digitos de la cifra, comenzando por la izquierda
			$xaux = substr($xaux, $x3digitos, abs($x3digitos)); // obtengo la centena (los tres dígitos)
			for ($xy = 1; $xy < 4; $xy++) { // ciclo para revisar centenas, decenas y unidades, en ese orden
				switch ($xy) {
					case 1: // checa las centenas
						if (substr($xaux, 0, 3) < 100) { // si el grupo de tres dígitos es menor a una centena ( < 99) no hace nada y pasa a revisar las decenas
							
						} else {
							$key = (int) substr($xaux, 0, 3);
							if (TRUE === array_key_exists($key, $xarray)){  // busco si la centena es número redondo (100, 200, 300, 400, etc..)
								$xseek = $xarray[$key];
								$xsub = subfijo($xaux); // devuelve el subfijo correspondiente (Millón, Millones, Mil o nada)
								if (substr($xaux, 0, 3) == 100)
									$xcadena = " " . $xcadena . " CIEN " . $xsub;
									else
										$xcadena = " " . $xcadena . " " . $xseek . " " . $xsub;
										$xy = 3; // la centena fue redonda, entonces termino el ciclo del for y ya no reviso decenas ni unidades
							}
							else { // entra aquí si la centena no fue numero redondo (101, 253, 120, 980, etc.)
								$key = (int) substr($xaux, 0, 1) * 100;
								$xseek = $xarray[$key]; // toma el primer caracter de la centena y lo multiplica por cien y lo busca en el arreglo (para que busque 100,200,300, etc)
								$xcadena = " " . $xcadena . " " . $xseek;
							} // ENDIF ($xseek)
						} // ENDIF (substr($xaux, 0, 3) < 100)
						break;
					case 2: // checa las decenas (con la misma lógica que las centenas)
						if (substr($xaux, 1, 2) < 10) {
							
						} else {
							$key = (int) substr($xaux, 1, 2);
							if (TRUE === array_key_exists($key, $xarray)) {
								$xseek = $xarray[$key];
								$xsub = subfijo($xaux);
								if (substr($xaux, 1, 2) == 20)
									$xcadena = " " . $xcadena . " VEINTE " . $xsub;
									else
										$xcadena = " " . $xcadena . " " . $xseek . " " . $xsub;
										$xy = 3;
							}
							else {
								$key = (int) substr($xaux, 1, 1) * 10;
								$xseek = $xarray[$key];
								if (20 == substr($xaux, 1, 1) * 10)
									$xcadena = " " . $xcadena . " " . $xseek;
									else
										$xcadena = " " . $xcadena . " " . $xseek . " Y ";
							} // ENDIF ($xseek)
						} // ENDIF (substr($xaux, 1, 2) < 10)
						break;
					case 3: // checa las unidades
						if (substr($xaux, 2, 1) < 1) { // si la unidad es cero, ya no hace nada
							
						} else {
							$key = (int) substr($xaux, 2, 1);
							$xseek = $xarray[$key]; // obtengo directamente el valor de la unidad (del uno al nueve)
							$xsub = subfijo($xaux);
							$xcadena = " " . $xcadena . " " . $xseek . " " . $xsub;
						} // ENDIF (substr($xaux, 2, 1) < 1)
						break;
				} // END SWITCH
			} // END FOR
			$xi = $xi + 3;
		} // ENDDO
		
		if (substr(trim($xcadena), -5, 5) == "ILLON") // si la cadena obtenida termina en MILLON o BILLON, entonces le agrega al final la conjuncion DE
			$xcadena.= " DE";
			
			if (substr(trim($xcadena), -7, 7) == "ILLONES") // si la cadena obtenida en MILLONES o BILLONES, entoncea le agrega al final la conjuncion DE
				$xcadena.= " DE";
				
				// ----------- esta línea la puedes cambiar de acuerdo a tus necesidades o a tu país -------
				if (trim($xaux) != "") {
					switch ($xz) {
						case 0:
							if (trim(substr($XAUX, $xz * 6, 6)) == "1")
								$xcadena.= "UN BILLON ";
								else
									$xcadena.= " BILLONES ";
									break;
						case 1:
							if (trim(substr($XAUX, $xz * 6, 6)) == "1")
								$xcadena.= "UN MILLON ";
								else
									$xcadena.= " MILLONES ";
									break;
						case 2:
							if ($xcifra < 1) {
								$xcadena = "CERO $xdecimales/100 $currency_text ";
							}
							if ($xcifra >= 1 && $xcifra < 2) {
								$xcadena = "UN $xdecimales/100 $currency_text ";
							}
							if ($xcifra >= 2) {
								$xcadena.= " $xdecimales/100 $currency_text "; //
							}
							break;
					} // endswitch ($xz)
				} // ENDIF (trim($xaux) != "")
				// ------------------      en este caso, para México se usa esta leyenda     ----------------
				$xcadena = str_replace("VEINTI ", "VEINTI", $xcadena); // quito el espacio para el VEINTI, para que quede: VEINTICUATRO, VEINTIUN, VEINTIDOS, etc
				$xcadena = str_replace("  ", " ", $xcadena); // quito espacios dobles
				$xcadena = str_replace("UN UN", "UN", $xcadena); // quito la duplicidad
				$xcadena = str_replace("  ", " ", $xcadena); // quito espacios dobles
				$xcadena = str_replace("BILLON DE MILLONES", "BILLON DE", $xcadena); // corrigo la leyenda
				$xcadena = str_replace("BILLONES DE MILLONES", "BILLONES DE", $xcadena); // corrigo la leyenda
				$xcadena = str_replace("DE UN", "UN", $xcadena); // corrigo la leyenda
	} // ENDFOR ($xz)
	return trim($xcadena);
}
endif;
if( !function_exists('subfijo') ):
function subfijo($xx)
{
	// esta función regresa un subfijo para la cifra
	$xx = trim($xx);
	$xstrlen = strlen($xx);
	if ($xstrlen == 1 || $xstrlen == 2 || $xstrlen == 3)
		$xsub = "";
		//
		if ($xstrlen == 4 || $xstrlen == 5 || $xstrlen == 6)
			$xsub = "MIL";
			//
			return $xsub;
}
endif;
function lt_mail($email, $subject, $message, $headers = [], array $attachments = [])
{
	$data = ['name' => env('APP_TITLE'), 'body' => str_replace(["\n"], ["<br/>"], $message)];
	//$view = ['text' => 'Siat::mail'];
	//if( isset($headers['Content-Type']) && $headers['Content-Type'] == 'text/html' )
	//	$view = ['html' => 'Siat::mail'];
	
	$res = Mail::send('Siat::mail', $data, function($message) use($email, $subject, $attachments)
	{
		$message->to($email, 'Terrapuerto')
			->subject($subject)
			->from(env('MAIL_FROM_ADDRESS'), env('APP_TITLE'));
		foreach($attachments as $attach)
		{
			$message->attach($attach);
		}
	});
}
function sb_get_file_mime($filename)
{
	$mime = null;
	if( function_exists('finfo_open') )
	{
		$fh 	= finfo_open(FILEINFO_MIME_TYPE);
		$mime 	= finfo_file($fh, $filename);
		finfo_close($fh);
	}
	else
	{
		$mime = mime_content_type($filename);
	}
	return $mime;
}