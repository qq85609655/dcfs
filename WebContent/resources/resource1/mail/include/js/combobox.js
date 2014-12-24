
   var    optionDiv    =    document.createElement("div");  
  
 function hideOptions()
 {
 		var div = document.getElementById("optionDiv");
 		//alert("optionDiv=="+div.style.visibility);
 		if(div!=null){
			div.style.visibility = "hidden";
			div.style.display = "none";	
		}
		_displayLoad();
		
		
 }
  
  
  function createselectelements(obj,arr,all){
   var    oWhere    =    document.body;   
   //设置下拉菜单选项的坐标和宽度   
   with(optionDiv.style)    {    
    var    xy    =    getSelectPosition(obj);   
    pixelLeft    =    xy[0];   
    pixelTop    =    xy[1]+obj.offsetHeight;   
    width    =    obj.offsetWidth; 
    optionDiv.className    =    "optionDiv"; 
    optionDiv.id = "optionDiv";
    
   }   
   //下拉菜单内容   
   var    val1=null;
   if(all)
	{	
	   val1 = "";
	}  
	else
	{
	   val1 = obj.value;
	}
   var    optionsindexs=0;
   
   for(var i=optionDiv.childNodes.length;i>0;i--){
       optionDiv.removeChild(optionDiv.childNodes[i-1]);
   }
   
   var    Options    =    new    Array();   
   for    (var    i=0;i<arr.length;i++)    {  
    if(arr[i].indexOf(val1)==0){  
       Options[optionsindexs]    =    optionDiv.appendChild(document.createElement("div")); 
       Options[optionsindexs].innerText= arr[i];   
       optionsindexs++;
    }  
   }   
   //移动Option时的动态效果   
   for (i=0;i<Options.length;i++)    {   
    Options[i].attachEvent("onmouseover",function(){moveWithOptions("highlight","white")});   
    Options[i].attachEvent("onmouseout",function(){moveWithOptions("","")});   
    Options[i].attachEvent("onmouseup",function(){selectedText(obj)});   
   }  
   oWhere.appendChild(optionDiv);  

  }
   optionDiv.onselectstart    =    function()    {return    false;}   
   
   function showOptions(obj,selected,all){
	  if(all==false&&(obj.value==null||TrimStr(obj.value)==""))
	  {
	  		return;
	  }
	  
	  var    arr =new Array();  
	
	for(var i=0;i<selected.options.length;i++){
	  arr[i]=selected.options[i].innerText;
	}
	    createselectelements(obj,arr,all);
	    //alert(optionDiv.childNodes.length);
	 if(optionDiv.childNodes.length==0){
	    optionDiv.style.visibility    =    "hidden";
	    optionDiv.style.display    =    "none";
	 }else{
	     optionDiv.style.visibility  = "visible"; 
	     optionDiv.style.display    =    "";
	    }
    }
   
   document.onclick    =    function()    {   
    optionDiv.style.visibility    =    "hidden";
    optionDiv.style.display    =    "none";
   }   

   function    moveWithOptions(bg,color)    {   
    with(event.srcElement)    {   
     style.backgroundColor    =    bg;   
     style.color    =    color;   
    }   
   }   
   function    selectedText(obj)    {   
    with(event.srcElement)    {   
      obj.innerText    =    innerText;   
    }   
       optionDiv.style.visibility =  "hidden"; 
       optionDiv.style.display    =    "none";
   }   
   /*通用函数*/   
   //获取对象坐标   
   function    getSelectPosition(obj)    {   
    var    objLeft    =    obj.offsetLeft;   
    var    objTop    =    obj.offsetTop;   
    var    objParent    =    obj.offsetParent;
   
    while    (objParent.tagName    !=    "BODY"&&objParent.tagName    !=    "HTML")    {   
     objLeft    +=    objParent.offsetLeft;   
     objTop    +=    objParent.offsetTop;   
     objParent    =    objParent.offsetParent;   
    
     }   
    return([objLeft,objTop]);   
   }   
   function TrimStr(his)
{

   Pos_Start = -1;
   for(var i=0;i<his.length;i++)
   {
     if(his.charAt(i)!=" ")
      {
         Pos_Start = i;
         break; 
      }
   }

   Pos_End = -1;
   for(var i=his.length-1;i>=0;i--)
   {
     if(his.charAt(i)!=" ")
      {
         Pos_End = i; 
         break; 
      }
   }

   Str_Return = ""
   if(Pos_Start!=-1 && Pos_End!=-1)
   {   
		for(var i=Pos_Start;i<=Pos_End;i++)
		{
			   Str_Return = Str_Return + his.charAt(i); 
		}
   }
   return Str_Return;
}  
   