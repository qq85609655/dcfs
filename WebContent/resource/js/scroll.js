function _scroll(setUp,width)
{
	//��Ļ�ֱ���
	var sWidth = document.body.clientWidth;
	var sd = $("#scrollDiv");
	sWidth < setUp ?sd.css("width",width):sd.css("width","");
}