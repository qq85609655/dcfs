// JavaScript Document
 function _onLoad(){
 	var tem=getSelectPosition(document.getElementById("jiahao"));
	document.getElementById("photopos").style.posTop=tem[1]-top;
	document.getElementById("photopos").style.posLeft=tem[0]-left;
	kuozhan();
  }  
  
  //���ض�����ҳ���left�����top����
function getSelectPosition(obj){   
    var objLeft=obj.offsetLeft;   
    var objTop=obj.offsetTop;   
    var objParent=obj.offsetParent;
    while(objParent.tagName!="BODY"&&objParent.tagName!="HTML"){   
	     objLeft+=objParent.offsetLeft;   
	     objTop+=objParent.offsetTop;   
	     objParent=objParent.offsetParent;   
    
    }   
    return([objLeft,objTop]);   
}
  function loadTupian(TPMZ)
	{ 
	var x = TPMZ.value;
	var obj=document.getElementById("newPreview");
	if(x==""||x==null){
	document.getElementById("tiaojian").value="1";
	return;
    } 
    var index  = x.lastIndexOf('.');
    var file = x.substring(index+1,x.length).toUpperCase();
    if(file!='JPG'&&file!='GIF'){
	alert('�ϴ�����Ƭֻ����JPG��GIF��ʽ��');
	document.getElementById("tiaojian").value="0";
	return;
    }else
    {
    document.getElementById("tiaojian").value="1";
    document.getElementById("panduan").value=x;
    preview4();
    }
	}
 function preview4(){ 
      
     var x = document.getElementById("ZP");
     var y = document.getElementById("xianzp"); 
     if(!x || !x.value || !y) 
     {
      return;
     }     
    try{
      var obj=document.getElementById("newPreview");
      obj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src  =  x.value;
      y.style.display="none";
     obj.style.width  =   " 320px " ;
     obj.style.height  =   " 210px " ;
     }
     catch(e)
     {
      alert('��ѡ���ļ������Ѿ����ƻ����޷�Ԥ����'); 
     }
       document.getElementById("xianzp").src = "file://localhost/" +x.value; 
    }
  function qingkong()
  {
  var z=document.getElementById("photo");
  var obj=document.getElementById("newPreview");
  var y = document.getElementById("xianzp"); 
  obj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src  =  z.value;
  y.style.display="none";
  obj.style.width  =   " 320px " ;
  obj.style.height  =   " 210px " ;
  document.getElementById("xianzp").src = "file://localhost/" +z.value;
  document.getElementById("panduan").value="";
   document.getElementById("photopos").innerHTML="";
   document.getElementById("photopos").innerHTML="<input id=\"ZP\" name=\"ZP\"  type=\"file\" onChange=\"loadTupian(this)\" class=\"file\" title=\"����ϴ�ͼƬ\"/>";
  } 