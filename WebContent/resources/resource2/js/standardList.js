/**
 * oa标准版列表
 */
   var is_double=false;
   /**初始化列表**/
	function initTable(tableid){
		initCol(tableid);
		initSeq();
	}	
	  function trmovrover(obj){
		  if(obj.className=="blue"){
			  is_double=true;  
		  }
		  obj.style.backgroundColor="#D2DFF0";  
	  }
	  
	  function trmoveout(obj){
		  if(is_double){
		  obj.style.backgroundColor="#f2f7fc";    
		  }else{
		  obj.style.backgroundColor="";  
		  }
		  is_double=false;
	  }
	  
	  function thmoveout(obj){
		  obj.className=""; 
	  }
	  
	  function thmovrover(obj){
		  obj.className="thonmover"; 
	  }
	  
	  function _sort(type,column){
			 document.getElementById("compositor").value=column;
			 document.getElementById("ordertype").value=type; 
			 document.srcForm.submit();
	  }
	  
	  function initSeq(){
		  var column=document.getElementById("compositor").value;
		  var type=document.getElementById("ordertype").value;
		  try{
		  if(column!=""){
		  var childs=document.getElementById("titleth_"+column).childNodes;
		  for(var i=0;i<childs.length;i++){
			  if(childs[i].nodeName.toLocaleUpperCase()=='IMG'){
				  childs[i].style.display="";
			  } 
		  }
		  }
		  if(type!=""){
			  if(type=="DESC"){
				  document.getElementById("titleth_"+column).onclick=function(){
					  _sort('ASC',column);
				  };
				 //document.getElementById("titleth_"+column).setAttribute('onclick',document.all ? eval(function(){_sort('ASC',column);}) : 'javascript:_sort(\'ASC\',\''+column+'\')');
				 document.getElementById("titleth_"+column).innerHTML=document.getElementById("titleth_"+column).innerHTML.replace('title_up.png','title_down.png');
			  }else{
				  document.getElementById("titleth_"+column).onclick=function(){
					  _sort('DESC',column);
				  };
				 //document.getElementById("titleth_"+column).setAttribute('onclick',document.all ? eval(function(){_sort('DESC',column);}) : 'javascript:_sort(\'DESC\',\''+column+'\')');
				 document.getElementById("titleth_"+column).innerHTML=document.getElementById("titleth_"+column).innerHTML.replace('title_down.png','title_up.png');
			  }
		  }
		  }catch(e){
		  }
	  }
	  
	  /**初始化列***/
	  function initCol(tableid){
		  var tableobj=document.getElementById(tableid);
		  var ifblue=false;
		  var tablebody;
		  for(var i=0;i<tableobj.childNodes.length;i++){
			  if(tableobj.childNodes[i].nodeName.toLocaleUpperCase()=='TBODY'){
				  tablebody=tableobj.childNodes[i];
			  }
		  }
		  for(var i=0;i<tablebody.childNodes.length;i++){
			  if(tablebody.childNodes[i].nodeName.toLocaleUpperCase()=='TR'){
				  if(tablebody.childNodes[i].scrollHeight!="31"){
					  tablebody.childNodes[i].onmouseover=function(){
						  								trmovrover(this);
					                                    };
	                  tablebody.childNodes[i].onmouseout=function(){
	                	                                trmoveout(this);
								                        };
					  if(ifblue){
						  tablebody.childNodes[i].className="blue";
						  ifblue=false;
					  }else{
						  ifblue=true;
					  }		                        
				  }
			  }
		  }
	  }
	  
	  /*复选框扩展功能*/
	  function _checkb(name){
	   var boxname="xuanze";
	   if(name){
		   boxname=name; 
	   }
	   var quanxuan=document.getElementById('quanxuan');
	   var checkboxs=document.getElementsByName(boxname);
	   for(var i=0;i<checkboxs.length;i++){
	     if(quanxuan.checked){
	       checkboxs[i].checked='checked';
	     }else{
	     checkboxs[i].checked='';
	     }
	   }
	   }
	  
