// JavaScript Document
var OffsetX=50;//x��ƫ����
var OffsetY=20;//x��ƫ����
var fadeTime=30;//ִ��Ƶ��
var executionTimes=20;//ִ�д���
var div_hxjs=0;
var div_sxjs=0;
var point_hxjs=0;
var point_sxjs=0;
var zxcs;
var delete_result;
var f;
var g;

/**����div**/
function _float(obj,pointname,result){
	 delete_result=result;
	 zxcs=0;
	 div_hxjs=0;
     div_sxjs=0;
     point_hxjs=0;
     point_sxjs=0;
	 var html='<table class="listtable" border="0" cellpadding="1" cellspacing="1" width="70%"><tr class="titletr"><td width="20%">�鼮���</td><td width="20%">�鼮����</td><td width="15%">����</td><td width="20%">���λ��</td><td width="15%">����</td><td width="10%">����</td></tr>'
	 html=html+'<TR style="BACKGROUND-COLOR: '+obj.parentNode.parentNode.style.backgroundColor+'">'+obj.parentNode.parentNode.innerHTML;
	 html=html+'</TR></TABLE>';
     document.getElementById('floatContainer').innerHTML=html;
	 document.getElementById('floatContainer').className='listContainer';
	 document.getElementById('floatContainer').style.width='99%';
	 document.getElementById('floatContainer').style.height='';
	 var e=obj.parentNode.parentNode;
	 	var   x   =   e.offsetLeft,   y   =   e.offsetTop;   
		while(e=e.offsetParent) 
		{ 
		   x   +=   e.offsetLeft;   
		   y   +=   e.offsetTop;
		}
      document.getElementById('floatContainer').style.top=y+"px";
	  document.getElementById('floatContainer').style.left=x+"px";
	  document.getElementById('floatContainer').className='listContainerTm';
	  document.getElementById('floatContainer').style.display='block';
	  f=setInterval("_dispalyDiv('floatContainer','"+pointname+"')",fadeTime);
	  
}
/**��̬����div**/
function _dispalyDiv(divname,pointname){
	if(zxcs==executionTimes){
	 document.getElementById('floatContainer').style.display='none';
	 window.clearInterval(f);
	 if(delete_result){
	    document.getElementById("floatContainer").innerHTML="";
		showResult(document.getElementById('resultContainer'),document.getElementById(pointname),true);
	 }else{
		document.getElementById('floatContainer').style.display='block';
		showResult(document.getElementById('resultContainer'),document.getElementById(pointname),false);
		g=setInterval("_reductionDiv('"+divname+"','"+pointname+"')",fadeTime);
	 }
	}
	var divobj=document.getElementById(divname);
	//document.getElementById().offsetHeight
	/**���Ŀ��������**/
	var divw=divobj.offsetWidth;
	var divh=divobj.offsetHeight;
	if(div_hxjs==0&&div_sxjs==0){
	div_hxjs=divobj.offsetWidth/executionTimes;
	div_sxjs=divobj.offsetHeight/executionTimes;
	}
	var e=document.getElementById(pointname);
	var   x=e.offsetLeft,y=e.offsetTop;  
	while(e=e.offsetParent) 
	{ 
	   x   +=   e.offsetLeft;   
	   y   +=   e.offsetTop;
	}
	
	var dive=document.getElementById(divname);
	var   divx   =   dive.offsetLeft,   divy   =   dive.offsetTop;   
	while(dive=dive.offsetParent) 
	{ 
	   divx   +=   dive.offsetLeft;   
	   divy   +=   dive.offsetTop;
	}
	if(point_hxjs==0&&point_sxjs==0){
	point_hxjs=(x-divx+OffsetX)/executionTimes;
	point_sxjs=(y-divy+OffsetY)/executionTimes;
	}
	if(divw>=div_hxjs){
		document.getElementById('floatContainer').style.width=(divw-div_hxjs)+"px";
	}else{
		document.getElementById('floatContainer').style.width="0px";
	}
	if(divh>=div_sxjs){
		document.getElementById('floatContainer').style.height=(divh-div_sxjs)+"px";
	}else{
		document.getElementById('floatContainer').style.height="0px";
	}
	document.getElementById('floatContainer').style.left=(divx+point_hxjs)+"px";
	document.getElementById('floatContainer').style.top=(divy+point_sxjs)+"px";
	zxcs++;
}
/**��̬��ʾɾ�����**/

function showResult(resultobj,pointobj,type){
	var e=pointobj;
	var   x   =   e.offsetLeft,   y   =   e.offsetTop;   
	while(e=e.offsetParent) 
	{ 
	   x   +=   e.offsetLeft;   
	   y   +=   e.offsetTop;
	}
	if(type){
	resultobj.className='resultContainer';
	resultobj.innerHTML='����ɾ���ɹ���';
	resultobj.style.left=(x+50)+"px";
	resultobj.style.top=(y)+"px";
	resultobj.style.display='block';
	}else{
	resultobj.className='resultContainer_sb';
	resultobj.innerHTML='ɾ������ʧ�ܣ�';
	resultobj.style.left=(x+50)+"px";
	resultobj.style.top=(y)+"px";
	resultobj.style.display='block';
	}
	setTimeout("closeResult()",2000); 
}

function closeResult(){
	document.getElementById('resultContainer').style.display='none';
}

/**��̬��ԭdiv**/
function _reductionDiv(divname,pointname){
	if(zxcs==0){
	 document.getElementById('floatContainer').style.display='none';
	 window.clearInterval(g);
	}
	var divobj=document.getElementById(divname);
	//document.getElementById().offsetHeight
	var divw=divobj.offsetWidth;
	var divh=divobj.offsetHeight;
	if(div_hxjs==0&&div_sxjs==0){
	div_hxjs=divobj.offsetWidth/executionTimes;
	div_sxjs=divobj.offsetHeight/executionTimes;
	}
	var e=document.getElementById(pointname);
	var   x   =   e.offsetLeft,   y   =   e.offsetTop;   
	while(e=e.offsetParent) 
	{ 
	   x   +=   e.offsetLeft;   
	   y   +=   e.offsetTop;
	}	
	var dive=document.getElementById(divname);
	var   divx   =   dive.offsetLeft,   divy   =   dive.offsetTop;   
	while(dive=dive.offsetParent) 
	{ 
	   divx   +=   dive.offsetLeft;   
	   divy   +=   dive.offsetTop;
	}
	if(point_hxjs==0&&point_sxjs==0){
	point_hxjs=(x-divx+OffsetX)/executionTimes;
	point_sxjs=(y-divy+OffsetY)/executionTimes;
	}
	document.getElementById('floatContainer').style.width=(divw+div_hxjs)+"px";
	document.getElementById('floatContainer').style.height=(divh+div_sxjs)+"px";
	document.getElementById('floatContainer').style.left=(divx-point_hxjs)+"px";
	document.getElementById('floatContainer').style.top=(divy-point_sxjs)+"px";
	zxcs--;
}
