/************************************
 *  Class：SimpleGrid
 * Author：邢进
 *   Date: 20090417
 * Properties:
 * Method:
 ************************************/

function SimpleGrid(tblId,formname,reload){
	//公共属性
	this.htmlonload=htmlonload;
    this.formname=formname;
	this.form=this.$(formname);
	this.tblId=tblId;
	this.oTable=this.$(tblId);
	this.hiddenNum=0;
	this.displayStatus=new Array();
	this.displayCount=0;
	if (reload==null)
	this.htmlonload();


	//公共方法
	if (reload==null)
	this.setColGroup=sg_setColGroup;
	if (reload==null)
	this.setTHead=sg_setThead;
	this.setTBody=sg_setTBody;
	if (reload==null)
	this.initTHead=sg_initTHead;
	this.initTBody=sg_initTBody;
	this.dragMouseDown=sg_dragMouseDown;
	this.dragMouseMove=sg_dragMouseMove;
	this.dragMouseUp=sg_dragMouseUp;
	this.dbclick=sg_ondbclick;
	this.toolClick=sg_toolClick;
	this.disappearToolDiv=sg_disappearToolDiv;
	this.itemCheckChange=sg_itemCheckChange;
	this.sortClick=sg_sortClick;
    this.sort_database_Click=sg_sort_database_Click;
	this.sort_database_Menu=sg_sort_database_Menu;
	this.itemSortMain=sg_itemSortMain;
	//this.styletoolMenuChange=sg_styletoolMenuChange;
	this.styleTitleChange=sg_styleTitleChange;
	this.styleItemChange=sg_styleItemChange;
	//css渲染方法
	this.styleTrChange=sg_styleTrChange;
	this.styleTrColor=sg_styleTrColor;
	this.styleTrClick=sg_styleTrClick;
	//公共接口方法
	this.appendRows=sg_appendRows;
	this.removeRows=sg_removeRows;
	this.getCell=sg_getCell;
	this.getCellText=sg_getCellText;
	this.getRow=sg_getRow;
	this.getCurRow=sg_getCurRow;

	//初始化操作
	if (reload==null)
	this.setColGroup();
	if (reload==null)
	this.setTHead();
	this.setTBody();
	if (reload==null)
	this.bindListener(document,"onmousemove",this.dragMouseMove());
	if (reload==null)
	this.bindListener(document,"onmouseup",this.dragMouseUp());
	if (reload==null)
	this.bindListener(document,"onclick",this.disappearToolDiv());
}

SimpleGrid.prototype.$=function(id){
	var idObj=null;
	if(id!=null){
		idObj=document.getElementById(id)
	}
	return idObj;
}

SimpleGrid.prototype.AtoA=function(ary){
	if(ary.length){
		var oAry=new Array(ary.length);
		for(var i=0;i<oAry.length;i++){
			oAry[i]=ary[i];
		}
		return oAry;
	}else{
		return [ary];
	}
}

SimpleGrid.prototype.bindListener=function(src,ename,handler){
	var oSrc= typeof src=="object"?src:this.$(src);
	oSrc.attachEvent(ename,handler);
}

SimpleGrid.prototype.convert=function(value,type){
	var desc=arguments.length>2?arguments[2]:true;
	if(type=="int"){
		return value==""?(desc?Number.MAX_VALUE:Number.MIN_VALUE):parseInt(value);
	}else if(type=="float"){
		return value==""?(desc?Number.MAX_VALUE:Number.MIN_VALUE):parseFloat(value);
	}else if(type=="date"){
		var val=Date.parse(value);
		return isNaN(val)?(desc?new Date(253402214400000):new Date(-62135769600000)):new Date(val);
	}else{
		return value.toString();
	}
}

SimpleGrid.prototype.sortByType=function(tPosition,sortType){
	var sg=this;	
	return function(oEleA,oEleB){	
		var valueA=sg.convert(oEleA.cells[tPosition].innerText,sortType);
		var valueB=sg.convert(oEleB.cells[tPosition].innerText,sortType);		
		if(valueA==""&&valueB==""){
			return 0;
		}
		if(valueA==""){
			return 1;
		}
		if(valueB==""){
			return -1;
		}
		if(valueA<valueB){
			return -1;
		}else if(valueA>valueB){
			return 1;
		}else{
			return 0;
		}
	}

}

SimpleGrid.prototype.manuSortByType=function(tPosition,sortType,desc){
	var sg=this;
	return function(oEleA,oEleB){
		var valueA=sg.convert(oEleA.cells[tPosition].innerText,sortType,desc);
		var valueB=sg.convert(oEleB.cells[tPosition].innerText,sortType,desc);
		if(valueA==""&&valueB==""){
			return 0;
		}
		if(valueA==""){
			return 1;
		}
		if(valueB==""){
			return -1;
		}
		if(valueA<valueB){
			return desc ? -1 : 1;
		}else if(valueA>valueB){
			return desc ? 1 : -1;
		}else{
			return 0;
		}
	}
}

SimpleGrid.prototype._isEmptyStr=function(str){
   var flag = true;
   for(var i=0;i<str.length;i++){
      if(str.charAt(i)!=" ")
      { 
         flag = false; 
         break;
      }
   }
   return flag;
}

SimpleGrid.prototype.getLeft=function getLeft(o){
	var offset=o.offsetLeft;
	if(o.offsetParent!=null) offset+=getLeft(o.offsetParent);
	return offset;
}

SimpleGrid.prototype.getTop=function getTop(o){
	var offset=o.offsetTop;
	if(o.offsetParent!=null) offset+=getTop(o.offsetParent);
	return offset;
}

SimpleGrid.prototype.getScrollLeft=function getScrollLeft(o){
	var scrollLeft=o.scrollLeft;
	if(o.offsetParent!=null&&o.offsetParent.tagName!="BODY"){
		scrollLeft+=getScrollLeft(o.offsetParent);
	}
	return scrollLeft;
}

SimpleGrid.prototype.getScrollTop=function getScrollTop(o){
	var scrollTop=o.scrollTop;
	if(o.offsetParent!=null&&o.offsetParent.tagName!="BODY"){
		scrollTop+=getScrollTop(o.offsetParent)
	}
	return scrollTop;
}

function sg_setColGroup(){
	if(this.oTable!=null){
		var colgroups=this.oTable.getElementsByTagName("colgroup");
		if(colgroups!=null){
			this.colgroup=colgroups[0];
			var col=null;
			for(var i=0;i<this.colgroup.childNodes.length;i++){
				col=this.colgroup.childNodes[i];
				if(col.style.display=="none"){
					this.displayStatus[i]=true;
					this.displayCount++;
				}else{
					this.displayStatus[i]=false;
				}
			}
		}else{
			throw new Error("对不起，没有发现colgroup标签！");
		}
	}
}

function sg_setThead(){
	if(this.oTable!=null){
		this.oTHead=this.oTable.tHead;
	}
	this.initTHead();	
	this.initTableWidth=this.oTable.offsetWidth;
}

function sg_setTBody(){
	if(this.oTable!=null){
		this.oTBody=this.oTable.tBodies[0];
	}
	this.initTBody();
}

function sg_initTHead(){
	if(this.oTHead!=null&&this.oTHead.rows[0]!=null){
		var oThs=this.oTHead.rows[0].cells;
		this.oTitles=new Array(oThs.length);
		 var compositor="";
		var ordertype="";
		try{
        compositor=document.getElementById('compositor').value;
		ordertype=document.getElementById('ordertype').value;
		}catch(e){
		}
		for(var i=0;i<oThs.length;i++){
			this.oTitles[i]=oThs[i].firstChild;
			this.oTitles[i].tCaption=this.oTitles[i].getAttribute("tCaption");
			this.oTitles[i].tPosition=i;
			var sortType=this.oTitles[i].getAttribute("sortType");
			try{
			this.bindListener(this.oTitles[i].childNodes[2].childNodes[1],"onmousedown",this.dragMouseDown());
			//this.bindListener(this.oTitles[i].childNodes[2].childNodes[0],"onmouseover",this.styletoolMenuChange(this.oTitles[i].childNodes[2].childNodes[0],true));
			//this.bindListener(this.oTitles[i].childNodes[2].childNodes[0],"onmouseout",this.styletoolMenuChange(this.oTitles[i].childNodes[2].childNodes[0],false));
			this.bindListener(this.oTitles[i].childNodes[2].childNodes[0],"onclick",this.toolClick());
			}catch(e){
			}
			if(sortType!="none"){
                 if(this.oTitles[i].name=='jsp'){
				this.bindListener(this.oTitles[i].childNodes[0],"onclick",this.sortClick());
               }
			  else if(this.oTitles[i].name=='database'){
			    this.bindListener(this.oTitles[i].childNodes[0],"onclick",this.sort_database_Click());
			  }
			}
			this.bindListener(oThs[i],"onmouseover",this.styleTitleChange(oThs[i],true));
			this.bindListener(oThs[i],"onmouseout",this.styleTitleChange(oThs[i],false));
             if(this.oTitles[i].id==compositor){
			if(ordertype=='asc'){
			this.oTitles[i].childNodes[1].className='compositor';
			}else if(ordertype=='desc'){
			this.oTitles[i].childNodes[1].className='compositor-fx';
			}else{
			this.oTitles[i].childNodes[1].className='compositor_cs';
			}
			}
		}		
	}
}

function sg_initTBody(){
	if(this.oTBody!=null&&this.oTBody.rows!=null){
		var oTrs=this.oTBody.rows;
		for(var i=0;i<oTrs.length;i++){
		
			this.styleTrColor(oTrs[i],i);
			this.bindListener(oTrs[i],"onmouseover",this.styleTrChange(oTrs[i],true,i));
			this.bindListener(oTrs[i],"onmouseout",this.styleTrChange(oTrs[i],false,i));
			this.bindListener(oTrs[i],"onclick",this.styleTrClick(oTrs[i]));
			this.bindListener(oTrs[i],"ondblclick",this.dbclick(oTrs[i]));
		}
	}
}

function sg_ondbclick(trObj){
return function(){
try{
tr_ondblclick(trObj);
}catch(e){
}
}
}

function sg_dragMouseDown(){
	var sg=this;
	return function(){
		var srcEle=event.srcElement
		//创建div
		var oLine=document.createElement("div");
		oLine.style.position="absolute";
		oLine.style.width="1px";
		oLine.style.height=sg.oTable.parentElement.offsetHeight;
		oLine.style.top=sg.getTop(sg.oTable);//sg.oTable.offsetTop;
		oLine.style.left=document.body.scrollLeft+event.x;
		oLine.style.backgroundColor="black";
		sg.oLine=oLine;
		sg.isMouseDown=true;
		document.body.appendChild(oLine);
		//记录当前位置参数
		sg.startX=event.x;
		sg.resizeTd=srcEle.parentElement.parentElement.parentElement;
		sg.startWidth=parseInt(sg.resizeTd.offsetWidth);
		sg.tableWidth=sg.oTable.offsetWidth;
		sg.containerWidth=sg.getLeft(sg.oTable.offsetParent)+sg.oTable.offsetParent.offsetWidth;
		var resizeDiv=sg.resizeTd.firstChild;
		sg.limitedWidth=resizeDiv.childNodes[0].offsetWidth+resizeDiv.childNodes[1].offsetWidth;
		
	}
}
function sg_dragMouseMove(){
	var sg=this;
	return function(){
		if(sg.isMouseDown){			
			var resizeWidth=event.x-sg.startX+sg.startWidth;
			if(event.x<=sg.containerWidth&&resizeWidth>sg.limitedWidth+31){	
				if(sg.oLine.style.display=="none"){
					sg.oLine.style.display="";
				}
				sg.oLine.style.left=document.body.scrollLeft+event.x;
			}else if(resizeWidth<=sg.limitedWidth){
				
			}else{
				//sg.oLine.style.display="none";
			}
		}
		return false;
	}
}

SimpleGrid.prototype.resizeTitle=function(resizeWidth,width){
	var trObj=this.resizeTd.parentNode;
	//单行表格不允许移动
	if(trObj.childNodes.length<=1){
		//还原参数
		this.startX=0;
		this.startWidth=0;
		this.isMouseDown=false;
		this.oLine&&document.body.removeChild(this.oLine);
		this.oLine=null; 
		return false;
	}
	with(trObj){
		//用于记录td的改变前的宽度
		var temArray=new Array(childNodes.length);
		for(var i=0;i<childNodes.length;i++){
			temArray[i]=childNodes[i].offsetWidth;
		}
		for(var i=0;i<childNodes.length;i++){
			childNodes[i].removeAttribute("width");
			childNodes[i].getAttribute("style").removeAttribute("width");
			this.colgroup.childNodes[i].getAttribute("style").removeAttribute("width");
			this.colgroup.childNodes[i].removeAttribute("width");
			if(childNodes[i]==this.resizeTd){
				this.resizeTd.width=resizeWidth;
				var newTableWidth=this.tableWidth+width;
				if(newTableWidth<this.initTableWidth){
					var j=1;
					(function x(resizeTd,sg){
						if(resizeTd.nextSibling==null){
							sg.resizeTd.previousSibling.width=Math.abs(temArray[i-j]-width);						
						}else if(sg.colgroup.childNodes[i+1].style.display=="none"){
							i++;
							j++;
							x(resizeTd.nextSibling,sg);
						}else{
							resizeTd.nextSibling.width=Math.abs(temArray[i+1]-width);
							i++;
						}
					})(this.resizeTd,this);	
				}
				this.oTable.width=(newTableWidth>this.initTableWidth)?newTableWidth:this.initTableWidth;
			}else{
				if(!this.displayStatus[i]){
					childNodes[i].width=temArray[i];
				}
			}
		}
	}
}

function sg_dragMouseUp(){
	var sg=this;
	return function(){
		if(sg.isMouseDown){
			//改变列宽
			if(event.x<=sg.containerWidth){
				var width=event.x-sg.startX;
				var resizeWidth=width+sg.startWidth;				
				if(resizeWidth>sg.limitedWidth+31&&width!=0){
					sg.resizeTitle(resizeWidth,width);			
				}else if(resizeWidth<=sg.limitedWidth+31){
					sg.resizeTitle(sg.limitedWidth+34,sg.limitedWidth-sg.startWidth+3);
				}
			}
			//还原参数
			sg.startX=0;
			sg.startWidth=0;
			sg.isMouseDown=false;
			sg.oLine&&document.body.removeChild(sg.oLine);
			sg.oLine=null; 			
		}		
	}
}

function sg_toolClick(){
	var sg=this;
	return function toolClickHandler(srcObj){
			var srcEle=event.srcElement||srcObj;
		if(!sg.isToolClick){
			//创建toolDiv
			var div=document.createElement("div");
			div.style.position="absolute";		
			div.className="simpleGridToolDiv";
			var left=sg.getLeft(srcEle);
			var tableLeft=sg.getLeft(sg.oTable);
			var menos=tableLeft+sg.oTable.offsetWidth-left-110;
			var scrollLeft=sg.getScrollLeft(sg.oTable.offsetParent);
			if(menos<0){
				div.style.left=left-scrollLeft+menos;
			}else{
				div.style.left=left-scrollLeft;
			}
			var top=sg.getTop(srcEle);
			var scrollTop=sg.getScrollTop(srcEle);
			div.style.top=top-scrollTop+srcEle.offsetHeight;
			sg.toolDiv=div;
			var oTitle=srcEle.parentElement.parentElement;
			if(oTitle.getAttribute("sortType")!="none"){
				//创建正序排序条目
				var up_item=document.createElement("div");
				var up_itemText=document.createTextNode(" 正序")
				var span_item = document.createElement("span");
				span_item.className="simpleGridToolDivASC";
				up_item.appendChild(span_item);
				up_item.appendChild(up_itemText);
				var clickTd=srcEle.parentElement.parentElement;
				sg.clickTd=clickTd;
				var thisTool=srcEle.parentElement.parentElement.tPosition;
				if(clickTd.id=='true'&&sg.lastItem==thisTool){
					up_item.className="sortclick";
				}else{
					sg.bindListener(up_item,"onmouseover",sg.styleItemChange(up_item,true));
					sg.bindListener(up_item,"onmouseout",sg.styleItemChange(up_item,false));
                   if(srcEle.parentElement.parentElement.name=='database'){
					sg.bindListener(up_item,"onclick",sg.sort_database_Menu('asc',srcEle.parentElement.parentElement.id));
					}else{
					sg.bindListener(up_item,"onclick",sg.itemSortMain(true));
                    }
				}
				div.appendChild(up_item);
				//创建逆序排序条目
				var down_item=document.createElement("div");
				var down_itemText=document.createTextNode(" 逆序");
				var span_item1 = document.createElement("span");
				span_item1.className="simpleGridToolDivDESC";
				down_item.appendChild(span_item1);
				down_item.appendChild(down_itemText);
				if(clickTd.id=='false'&&sg.lastItem==thisTool){
					down_item.className="sortclick";
				}else{
					sg.bindListener(down_item,"onmouseover",sg.styleItemChange(down_item,true));
					sg.bindListener(down_item,"onmouseout",sg.styleItemChange(down_item,false));
					if(srcEle.parentElement.parentElement.name=='database'){
					sg.bindListener(down_item,"onclick",sg.sort_database_Menu('desc',srcEle.parentElement.parentElement.id));
					}else{
					sg.bindListener(down_item,"onclick",sg.itemSortMain(false));
					}
				}
				div.appendChild(down_item);
				var jg_item=document.createElement("<hr>");
				jg_item.className="popMenuLine";
				div.appendChild(jg_item);
			}
			//创建div条目
			for(var i=0;i<sg.oTitles.length;i++){
				//
				if(sg.displayStatus[i]){
					continue;
				}
				var check=null;
				var col=sg.colgroup.childNodes[i];
				if(col.style.display==""){
					check=document.createElement("<input type='checkbox' checked>");
				}else{
					check=document.createElement("<input type='checkbox'>");
				}
				check.value=sg.oTitles[i].tPosition;
				sg.bindListener(check,"onclick",sg.itemCheckChange());
				var item=document.createElement("div");
				var itemText=document.createTextNode(sg.oTitles[i].tCaption);
				item.appendChild(check);
				item.appendChild(itemText);
				sg.bindListener(item,"onmouseover",sg.styleItemChange(item,true));
				sg.bindListener(item,"onmouseout",sg.styleItemChange(item,false));
				sg.bindListener(item,"onclick",sg.itemCheckChange());
				div.appendChild(item);
			}
			document.body.appendChild(div);
			sg.isToolClick=true;
			sg.lastTool=srcEle.parentElement.parentElement.tPosition;			
		}else{
			var thisTool=srcEle.parentElement.parentElement.tPosition;
			if(sg.lastTool!=thisTool){
				document.body.removeChild(sg.toolDiv);
				sg.toolDiv=null;
				sg.isToolClick=false;
				toolClickHandler(srcEle);
			}else{
				document.body.removeChild(sg.toolDiv);
				sg.toolDiv=null;
				sg.isToolClick=false;
			}
		}
		event.cancelBubble=true; 
	}
}

function sg_itemCheckChange(){
	var sg=this;
	return function(){	
		var srcEle;
		//判断当前是点击div还是checkbox
		if(event.srcElement.firstChild!=null){
			srcEle=event.srcElement.firstChild;
			srcEle.checked=!srcEle.checked;
		}else{
			srcEle=event.srcElement;
		}
		var col=sg.colgroup.childNodes[srcEle.value];
		if(srcEle.checked){
			sg.hiddenNum--;
			col.style.display="";
			
		}else{
			if(sg.hiddenNum<sg.oTitles.length-sg.displayCount-1){
				col.style.display="none";
				
				sg.hiddenNum++;
			}else{
				srcEle.checked=true;
			}
		}
		event.cancelBubble=true; 
	}
}

function sg_disappearToolDiv(){
	var sg=this;
	return function(){
		if(sg.isToolClick){
			document.body.removeChild(sg.toolDiv)
			sg.isToolClick=false;
		}
	}
}

/************重置排序按钮*************/
function resetbutton(obj){
 for(var i=0;i<obj.childNodes.length;i++){
 obj.childNodes[i].childNodes[0].childNodes[1].className="compositor_cs";
 }
}
/************数据库排序**************/
function sg_sort_database_Menu(type,sortname){
	var sg=this;
	return function(){ 
	var srcEle=event.srcElement;
	var form=sg.form;
	document.getElementById('compositor').value=sortname;
	document.getElementById('ordertype').value=type;
	form.submit(); 
 	}
}

function sg_sort_database_Click(){
	var sg=this;
	return function(){ 
	var srcEle=event.srcElement;
	var form=sg.form;
	document.getElementById('compositor').value=srcEle.parentElement.id;
	if(document.getElementById('ordertype').value==""){
	document.getElementById('ordertype').value="asc";
	}else if(document.getElementById('ordertype').value=="asc"){
	document.getElementById('ordertype').value="desc";
	}else if(document.getElementById('ordertype').value=="desc"){
	document.getElementById('ordertype').value="asc";
	}
	form.submit(); 
 	}
}

/************页面排序**************/
function sg_sortClick(){
	var sg=this;
	return function(){ 
	var srcEle=event.srcElement;		
 		var tPosition=srcEle.parentElement.tPosition;
 		var sortType=srcEle.parentElement.getAttribute("sortType");
 		var oBodyAry=sg.AtoA(sg.oTBody.rows);
 	    oBodyAry.reverse=function(){
 	    	var j=0;
 	    	var temp;
 	    	for(var i=this.length-1;i>=0&&j<i;i--){	    		
 	    		if(this[i].cells[tPosition].innerText!=""){
 	    			temp=this[j];
 	    			this[j]=this[i];
 	    			this[i]=temp;
 	    			j++;
 	    		}
 	    	}
 	    }
 		if(sg.lastSort==tPosition){
 		oBodyAry.reverse();
 		try{ 		
 		if(srcEle.parentElement.childNodes[1].className!=null&&srcEle.parentElement.childNodes[1].className=='compositor'){
 		srcEle.parentElement.childNodes[1].className='compositor-fx';
 		}else{
 		srcEle.parentElement.childNodes[1].className='compositor';
 		}
 		}catch(e){
 		}
 		}else{
 			oBodyAry.sort(sg.sortByType(tPosition,sortType));
 			try{
 			resetbutton(srcEle.parentElement.parentElement.parentElement);
 			if(srcEle.parentElement.childNodes[1].className!=null){
 			srcEle.parentElement.childNodes[1].className='compositor';
            }
 			}catch(e){
 			}
 		}
 		sg.lastSort=tPosition;
 		//修改页面展现
 		var oFragment = document.createDocumentFragment();
 		var SFDJ = new Array(); 
 		 for(var i=0;i<oBodyAry.length;i++){
 		 try{
 	     if(oBodyAry[i].childNodes[0].childNodes[1].childNodes[0]!=null&&oBodyAry[i].childNodes[0].childNodes[1].childNodes[0].checked){
 	       SFDJ[i]="true";
 	     }else{
 	      SFDJ[i]="false";
 	     }
 	     }catch(e){
 	     }
 			oFragment.appendChild(oBodyAry[i]);
 			sg.styleTrColor(oBodyAry[i],i);
 		}
 		sg.oTBody.appendChild(oFragment);	
 		for(var i=0;i<SFDJ.length;i++){
 		try{
 		 if(SFDJ[i]=="true"){ 
 		 sg.oTBody.childNodes[i].childNodes[0].childNodes[1].childNodes[0].checked="checked";
 		 }
 		 }catch(e){
 		 }
	  }
	}
}

//function sg_styletoolMenuChange(tdObj,isIn){
//	if(isIn){
//		return function(){
//			tdObj.className="toolMenu_xs";
//		}
//	}else{
//		return function(){
//			tdObj.className="toolMenu";
//
//	}
//}



function sg_styleTitleChange(tdObj,isIn){
	if(isIn){
		return function(){
			tdObj.className="thMouseOver";
			tdObj.childNodes[0].childNodes[2].className="toolDiv_xt";
			tdObj.childNodes[0].childNodes[2].childNodes[0].className="toolMenu_xs";

		}
	}else{
		return function(){
			tdObj.className="thMouseOut";
			tdObj.childNodes[0].childNodes[2].className="toolDiv";
			tdObj.childNodes[0].childNodes[2].childNodes[0].className="toolMenu";
		}
	}
}

function sg_styleItemChange(oItem,isIn){
	if(isIn){
		return function(){
			oItem.className="popMenuOver";
		}
	}else{
		return function(){
			oItem.className="popMenuOut";
		}
	}
}

function sg_styleTrChange(trObj,isIn,i){
	var sg=this;
	var pos=i||-1;
	if(isIn){
		return function(){
			sg.oldClass=trObj.className;
			if(pos!=sg.trSelected){
				trObj.className="tbodyTrMouseOver";
			}
			var xzk=trObj.childNodes[0].getAttribute('noselect');
			if(xzk!="true"){
			try{
			if(trObj.childNodes[0].childNodes[1]!=null&&!trObj.childNodes[0].childNodes[1].childNodes[0].checked){
            trObj.childNodes[0].childNodes[0].style.display='none';
            trObj.childNodes[0].childNodes[2].className='tbodydatadiv_quxiao';
            }
			
            }catch(e){            
            }
			}
			for(var i=0;i<trObj.childNodes.length;i++){
				trObj.childNodes[i].style.borderTopColor="#dddddd";
				trObj.childNodes[i].style.borderBottomColor="#dddddd";
			}
			
		}
	}else{
		return function(){
			trObj.className=sg.oldClass;
			var xzk=trObj.childNodes[0].getAttribute('noselect');
			if(xzk!="true"){
			try{
			if(trObj.childNodes[0].childNodes[1]!=null&&!trObj.childNodes[0].childNodes[1].childNodes[0].checked){
            trObj.childNodes[0].childNodes[0].style.display='block'
            //trObj.childNodes[0].childNodes[1].style.display='none'
            trObj.childNodes[0].childNodes[2].className='tbodydatadiv';
            }
            }catch(e){
            }
			}
			for(var i=0;i<trObj.childNodes.length;i++){
				trObj.childNodes[i].style.borderTopColor="";
				trObj.childNodes[i].style.borderBottomColor="";
			}
		}
	}
}

function sg_styleTrColor(oTr,i){
		if(i%2==0){
			oTr.className="tbodyTrShuang";
			oTr.position=i;
		}else{
			oTr.className="tbodyTrDan";
			oTr.position=i;
		}
}

function sg_styleTrClick(oTr){
	var sg=this;
	return function(){
		//将上一次点击的行置回原来class
		if(sg.trSelected!=null){
			sg.oTBody.rows[sg.trSelected].className=sg.trSelected%2==0?"tbodyTrShuang":"tbodyTrDan";
		}
		//将当前选择行的class改变
		oTr.className="tbodyTrSelected";
		sg.oldClass="tbodyTrSelected";
		sg.trSelected=oTr.position;
		try{
		var xzk=oTr.childNodes[0].getAttribute('noselect');
		if(xzk!="true"){
		oTr.childNodes[0].childNodes[0].style.display='none';
		if(oTr.childNodes[0].childNodes[1].childNodes[0]!=null&&!oTr.childNodes[0].childNodes[1].childNodes[0].checked){
		oTr.childNodes[0].childNodes[1].childNodes[0].checked='checked';
		oTr.childNodes[0].childNodes[2].className='tbodydatadiv_select';
		}else if(oTr.childNodes[0].childNodes[1].childNodes[0]!=null&&oTr.childNodes[0].childNodes[1].childNodes[0].checked){
		oTr.childNodes[0].childNodes[1].childNodes[0].checked='';
		oTr.childNodes[0].childNodes[2].className='tbodydatadiv_quxiao';
		}
		}
		}catch (e){
		
		}
		
	}
}

function sg_itemSortMain(flag){
	var sg=this;
	return function(){
		var srcEle=sg.clickTd||event.srcElement;
 		var tPosition=srcEle.tPosition;
 		var sortType=srcEle.getAttribute("sortType");
 		var oBodyAry=sg.AtoA(sg.oTBody.rows);
 		oBodyAry.sort(sg.manuSortByType(tPosition,sortType,flag));
 		srcEle.id=flag;
             	resetbutton(srcEle.parentElement.parentElement);
 		if(srcEle.id=='true'){
 		srcEle.childNodes[1].className='compositor';
 		}else{
 		srcEle.childNodes[1].className='compositor-fx';
 		}
 		//修改页面展现
 		var oFragment = document.createDocumentFragment();
 		var SFDJ = new Array(); 
 		for(var i=0;i<oBodyAry.length;i++){
 		   try{
 	     if(oBodyAry[i].childNodes[0].childNodes[1].childNodes[0]!=null&&oBodyAry[i].childNodes[0].childNodes[1].childNodes[0].checked){
 	       SFDJ[i]="true";
 	     }else{
 	      SFDJ[i]="false";
 	     }
 	     }catch(e){
 	     }
 			oFragment.appendChild(oBodyAry[i]);
 			sg.styleTrColor(oBodyAry[i],i);
 		}
		sg.oTBody.appendChild(oFragment);
		for(var i=0;i<SFDJ.length;i++){
		try{
 		 if(SFDJ[i]=="true"){ 
 		 sg.oTBody.childNodes[i].childNodes[0].childNodes[1].childNodes[0].checked="checked";
 		 }
 		 }catch(e){
 		 }

		}
		sg.lastItem=sg.lastTool;
	}
}

function sg_appendRows(newCunt,content){
	//参数1合法性校验
	if(typeof newCunt!="number"){
		throw new Error("参数1类型错误！");
	}
	//获得当前表格信息
	var rowCunt=this.oTBody.rows.length;
	var colCunt=this.oTitles.length;
	//参数2合法性校验
	if(typeof content=="undefined"){
		content=new Array(newCunt);
		for(var i=0;i<newCunt;i++){
			content[i]=new Array(colCunt);
		}
	}else if(content.length<newCunt){
		for(var i=0,bound=newCunt-content.length;i<bound;i++){
			content.push(new Array(colCunt));
		}
	}
	//创建新的表格行
	for(var i=0;i<newCunt;i++){
		var row=document.createElement("tr");
		for(var j=0;j<colCunt;j++){
			var col=document.createElement("td");
			col.innerHTML=content[i][j]||"";
			row.appendChild(col);
		}
		this.styleTrColor(row,rowCunt+i);
		this.bindListener(row,"onmouseover",this.styleTrChange(row,true,rowCunt+i));
		this.bindListener(row,"onmouseout",this.styleTrChange(row,false,rowCunt+i));
		this.bindListener(row,"onclick",this.styleTrClick(row));
		this.oTBody.appendChild(row);
	}
}

function sg_removeRows(index){
	//参数合法性检验
	if(index.length=="undefined"){
		throw new Error("参数类型不匹配!参数类型应为数组。");
	}
	var oTBody=this.oTBody;
	var bound=oTBody.rows.length;
	var isOK=true;
	var content=this.AtoA(oTBody.rows);
	for(var i=0;i<index.length;i++){
		var pos=parseInt(index[i]);
		if(pos<bound){
			if(pos==this.trSelected){
				this.trSelected=null;
			}
			//进行数据删除
			oTBody.removeChild(content[pos]);
		}else{
			//检测删除位置是否合法
			isOK=false;
			break;
		}
	}
	//进行分行着色
	for(var i=0;i<oTBody.rows.length;i++){
		this.styleTrColor(oTBody.rows[i],i);
	}
	if(!isOK){
		throw new Error("指定的删除位置不正确，删除失败！");
	}
}

function sg_getCell(rowInd,colInd){
	try{
		rowInd=parseInt(rowInd);
		colInd=parseInt(colInd);
		return this.oTBody.rows[rowInd].cells[colInd];
	}catch(e){
		throw new Error("传入参数异常！");
	}
}

function sg_getCellText(rowInd,colInd){
    try{
		rowInd=parseInt(rowInd);
		colInd=parseInt(colInd);
    }catch(e){
    	throw new Error("传入参数异常！");
    }
	var cell=this.getCell(rowInd,colInd);
	return cell.innerText;
}

function sg_getRow(rowInd){
	rowInd=parseInt(rowInd);
	return this.oTBody.rows[rowInd];
}

function sg_getCurRow(){
	return this.trSelected==null?null:this.oTBody.rows[this.trSelected];
}

function htmlonload(){
	var childNodes=document.getElementById(this.tblId).childNodes;
	setcolgroup(childNodes,this.tblId);
	setmenutd(childNodes,this.tblId);
	setdatatd(childNodes,this.tblId);
}
/*添加col标签组*/
function setcolgroup(e,tablename){
	var colgroup=document.createElement("colgroup");
	try{	
	var theadnum=e[0].childNodes[0].childNodes.length;
	}catch(e){
		throw new Error("获取col数量异常！");
	}
	for(var i=0;i<theadnum;i++){
		var col=document.createElement("col");
		colgroup.appendChild(col);
	}
	document.getElementById(tablename).appendChild(colgroup);
}
/*加载菜单中的元素*/
function setmenutd(e,tablename){
	var menutds=e[0].childNodes[0].childNodes;
	for(var i=0;i<menutds.length;i++){
	var span1=document.createElement("span");
	span1.className="toolMenu";
	var span2=document.createElement("span");
	span2.className="toolDrag";
	var div1=document.createElement('div');
	div1.className="toolDiv";
	div1.appendChild(span1);
	div1.appendChild(span2);
	var div2=document.createElement("div");
	div2.className="compositor_cs";
	var div3=document.createElement("div");
	div3.className="titleDiv";
	var title=menutds[i].childNodes[0].getAttribute("tCaption");
	div3.innerHTML=title;
	menutds[i].childNodes[0].appendChild(div3);
	menutds[i].childNodes[0].appendChild(div2);
	menutds[i].childNodes[0].appendChild(div1);
	}
}
/*加载数据td中的元素*/
function setdatatd(e,tablename){
	var datatrnum=e[1].childNodes.length;
	for(var i=0;i<datatrnum;i++){
	  var datatdobj=e[1].childNodes[i].childNodes[0];
	  var type=datatdobj.getAttribute('noselect');
	  var tdvalue=datatdobj.getAttribute('tdvalue');
	  if(type!="true"){
	  var datatdhtml=datatdobj.innerHTML;
	  var datatdinnerhtml="";
	  if(datatdhtml!=""){
	 datatdinnerhtml='<span>'+datatdhtml+'</span><span  class="tbodydatatdspan"><input type="checkbox" name="xuanze" value='+tdvalue+' /></span><div class="tbodydatadiv"></div>'
	 datatdinnerhtml=datatdinnerhtml.replace(/[\r\n]/g,"");
	 datatdobj.innerHTML=datatdinnerhtml;
	  }
	}
	}
	
}
