function _scroll(setUp,width)
{
	//ÆÁÄ»·Ö±æÂÊ
	var sWidth = document.body.clientWidth;
	var sd = $("#scrollDiv");
	sWidth < setUp ?sd.css("width",width):sd.css("width","");
}