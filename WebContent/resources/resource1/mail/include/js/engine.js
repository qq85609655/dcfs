function $(id){
	return document.getElementById(id);
}

function toggleInfo(obj1,obj){
	if(document.getElementById(obj).style.display==''){
		document.getElementById(obj).style.display='none';
		document.getElementById(obj1).title ="展开";
		document.getElementById(obj1).className='clsFd bgF1';
	}else{
		document.getElementById(obj).style.display='';
		document.getElementById(obj1).title ="折叠";
		document.getElementById(obj1).className='opnFd bgF1';
	}
	
}

function fGoto(num){
	 if (num>0){
	 for (i=1;i<=4;i++) 
     {
	 p =top.f0.document.getElementById("m"+i);
     p.className="";
	 }
	 p =top.f0.document.getElementById("m"+num);
     p.className="on";
	 }
}

function theright(rurl, onlyone) {
	var mrstr = String(Math.random());
	
	if (onlyone == true)
		parent.f2.window.location.href = rurl + "?GRSN=" + mrstr.substring(2, 10);
	else
		parent.f2.window.location.href = rurl + "&GRSN=" + mrstr.substring(2, 10);
}

function msearch() {
    frmsearch.mailsearch.value = "\t\tSubject\t1\t" + frmsearch.stext.value + "\t\tRecDate\t1\t" + frmsearch.syear.value + frmsearch.smonth.value + frmsearch.sday.value + "\t\tSize\t1\t\tRead\t1\t1\t\tFolders\tin\tout\tsed\t\del\t\t";
	frmsearch.submit();
}

function emptyfolder() {
	if (confirm("确实要清空垃圾箱吗?") == false)
		return ;

	location.href = "mulmail.asp?mode=cleanTrash";
	alert ("已清空垃圾箱。");
	theright('listmail.asp?mode=del', false);
}