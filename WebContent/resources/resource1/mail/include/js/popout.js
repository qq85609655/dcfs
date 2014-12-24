 //弹出代码选择页面 函数
function popOut(path,sql,obj_name,obj_cd,flag){
var final=path+"&flag="+flag+"&sql="+encodeURI(encodeURI(sql));
var x=showModalDialog(final,"","dialogWidth:415px;dialogHeight:430px;status:no;scroll:no");
if(typeof(x)=="undefined"){
document.getElementById(obj_name).value=document.getElementById(obj_name).value;
document.getElementById(obj_cd).value=document.getElementById(obj_cd).value;
}else{
var returnValues=x.split("@@");
document.getElementById(obj_name).value=returnValues[1];
document.getElementById(obj_cd).value=returnValues[0];
}
}
