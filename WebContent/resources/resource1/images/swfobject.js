function LoadFlash(url,wmode,width,height) { 
	var htmstr ='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" ';
	htmstr = htmstr + 'width="' + width + '" height="' + height + '">';
	htmstr = htmstr + '<param name="movie" value="' + url + '" />';
	htmstr = htmstr + '<param name="quality" value="high" />';
	htmstr = htmstr + '<param name="wmode" value="' + wmode + '" />';
	htmstr = htmstr + '<embed src="' + url + '" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" ';
	htmstr = htmstr + 'wmode="' + wmode + '" width="' + width + '" height="' + height + '"></embed></object>';
	document.write(htmstr);
}