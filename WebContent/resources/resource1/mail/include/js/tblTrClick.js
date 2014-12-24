var aTDClick=new Array();

function _onColor(td,n)
{
    if(!aTDClick[n]){
		td.style.backgroundColor='#efefef';   
		td.style.cursor='hand';		
	}else{
		td.style.backgroundColor='#dfe8f6';
	}
}

function _onClickColor(tr,n)
{
    tr.style.backgroundColor='#dfe8f6';	
    tr.style.color="blue";
	aTDClick[n]=true;
    var tableObj=document.getElementById("the-table");
    var rows=tableObj.rows;
	for(var i=1;i<rows.length;i++){
	   if(i!=(n+1)){
	   	  var trs = rows[i];
		  trs.style.backgroundColor='';
	      trs.style.color='';
	      aTDClick[i-1]=false;
	   }	 
	}
}

function _offColor(td,n)
{
    if(!aTDClick[n]){
		td.style.backgroundColor='';
    	td.style.color='';
	}else{
		td.style.backgroundColor='#dfe8f6';   	
	}
}  