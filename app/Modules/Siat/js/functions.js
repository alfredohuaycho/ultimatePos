function sb_formatgmtdate(dateStr, cFormat)
{
	if( dateStr.indexOf('+') == -1 )
		dateStr += '+0000';
	let gmtDate = (dateStr instanceof Date) ? dateStr : new Date(dateStr);

	return sb_formatdate(gmtDate.toString(), cFormat);
}
function sb_normalizedate(dateStr, fromFormat)
{
	if( !fromFormat )
		return dateStr;
		
	dateStr			= dateStr.replaceAll('/', '-');
	let mparts		= dateStr.split(' ');
	let parts 		= mparts[0].split('-');//.map((v) => parseInt(v)).sort();
	let positions 	= fromFormat.split('-');
	let tparts		= mparts[1] ? mparts[1].split(':') : null;
	if( parts.length < 3 )
		return 'Invalid format';
		
	let yearIndex	= positions.indexOf('Y');
	let monthIndex	= positions.indexOf('m');
	let dayIndex	= positions.indexOf('d');
	
	
	let newStr = `${parts[yearIndex]}-${parts[monthIndex]}-${parts[dayIndex]}`;
	if( mparts[1] && mparts[1].indexOf(':') != -1 )
	{
		/*
		let tparts		= mparts[1].split(':');
		let hourIndex	= tpos.indexOf('H');
		let minuteIndex	= tpos.indexOf('i');
		let secondIndex	= tpos.indexOf('s');
		*/
		newStr += `T${mparts[1]}`;
	}
	else
	{
		newStr += 'T00:00:00';
	}
	return new Date(newStr);
}
function sb_formatdate(dateStr, cFormat, fromFormat)
{
	let dayNames = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'];
	let monthNames = [
		"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
	];
	let format = cFormat || 'Y-m-d H:i:s';
	
	if( typeof dateStr == 'string' )
	{
		dateStr = sb_normalizedate(dateStr, fromFormat || 'Y-m-d');
	}
	let d = (dateStr instanceof Date) ? dateStr : new Date(Date.parse(dateStr));

	let month 		= parseInt(d.getMonth()) + 1;
	let day 		= parseInt(d.getDate());
	let hours 		= parseInt(d.getHours());
	let singleHours = hours % 12;
	let minutes 	= parseInt(d.getMinutes());
	let seconds 	= parseInt(d.getSeconds());
	let meridiem 	= (hours > 11) ? 'pm' : 'am';
	
	if( month < 10 )
		month = '0' + month;
	if( day < 10 )
		day = '0' + day;
		
	if( hours < 10 )
		hours = '0' + hours;
		
	if( minutes < 10 )
		minutes = '0' + minutes;

	if( seconds < 10 )
		seconds = '0' + seconds;
	let fullYear = d.getFullYear();
		
	let date = format.replace(/\b([a-zA-Z]{1})\b/g, '{$1}')
				.replace('{Y}', fullYear)
				.replace('{m}', month)
				.replace('{M}', monthNames[parseInt(month) - 1])
				.replace('{d}', day)
				.replace('{D}', dayNames[d.getDay()])
				.replace('{H}', hours)
				.replace('{h}', singleHours)
				.replace('{i}', minutes)
				.replace('{s}', seconds)
				.replace('{T}', meridiem);
						
	return date;
}