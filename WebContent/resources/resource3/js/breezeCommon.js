/*********************************
 * ���ڱδ��� 
 *********************************/
// ���� select
function selecthidden(){
 var  input_elements=document.getElementsByTagName("select");
 var  theLength=input_elements.length;
 for(i=0;i<theLength;i++)
 {
  input_elements[i].style.visibility="hidden";
  }
}
// ��ʾ select
function selectshow(){
 var  input_elements=document.getElementsByTagName("select");
 var  theLength=input_elements.length;
 for(i=0;i<theLength;i++)
 {
  input_elements[i].style.visibility="";
  }
}
// ����һ����͸�������ֲ�
function createBlurDiv(msg){
var objScreen = document.createElement("div");
if (msg==null){
	msg="�����ύ���ݣ����Ժ�...";
}
var oS = objScreen.style;
 objScreen.id = "ScreenOver";
 oS.display = "block";
 oS.top = oS.left = oS.margin = oS.padding = "0px";
 if (document.body.scrollHeight)
 {
  var wh = document.body.scrollHeight + "px";
 }else if (window.innerHeight){
   var wh = window.innerHeight + "px";
  }else{
   var wh = "100%";
  }
oS.width = document.body.scrollWidth + "px";

oS.height = wh;
oS.position = "absolute";
oS.zIndex = "3";
oS.background = "#cccccc";
oS.filter = "alpha(opacity=40)";
oS.opacity = 40/100;
oS.MozOpacity = 40/100;
document.body.appendChild(objScreen);
objScreen.innerHTML="<table width=\"100%\" height=\"100%\" border=\"0\"><tr><td valign=\"middle\" align=\"center\" style=\"color: #0000FF\">" + msg + "</td></tr></table>";
selecthidden();
}

// �Ƴ����ֲ�
function removeBlurDiv(){
 var ScreenOver = document.getElementById("ScreenOver");
 document.body.removeChild(ScreenOver);
 selectshow();
}
// ����
function _S_(msg){
 createBlurDiv(msg);
 }
// ��ʧ
function _H_(divname){
 removeBlurDiv();
 }
