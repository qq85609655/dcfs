var _sortTd = null;
var dom = (document.getElementsByTagName) ? true : false;
var ie5 = (document.getElementsByTagName && document.all) ? true : false;
var arrowUp, arrowDown;
if (ie5 || dom)
    initSortTable();
function initSortTable() {
    arrowUp = document.createElement("SPAN");
    arrowDown = document.createElement("SPAN");
}
function sortTable(tableNode, nCol, bDesc, sType) {
    var tBody = tableNode.tBodies[0];
    var trs = tBody.rows;
    var trl= trs.length;
    var a = new Array();
    
    for (var i = 0; i < trl; i++) {
        a[i] = trs[i];
    }
    
    var _sort = compareByColumn(nCol,bDesc,sType);
    a.sort(_sort);
    for (var i = 0; i < trl; i++) {
        tBody.appendChild(a[i]);
    }
    
    // check for onsort
    if (typeof tableNode.onsort == "string")
        tableNode.onsort = new Function("", tableNode.onsort);
    if (typeof tableNode.onsort == "function")
        tableNode.onsort();
}
function CaseInsensitiveString(s) {
    return String(s).toUpperCase();
}
function parseDate(s) {
    return Date.parse(s.replace(/\-/g, '/'));
}
/* alternative to number function
* This one is slower but can handle non numerical characters in
* the string allow strings like the follow (as well as a lot more)
* to be used:
*    "1,000,000"
*    "1 000 000"
*    "100cm"
*/
function toNumber(s) {
    return Number(s.replace(/[^0-9\.]/g, ""));
}
function compareByColumn(nCol, bDescending, sType) {
    var c = nCol;
    var d = bDescending;
    var fTypeCast = String;
    if (sType == "Number")
        fTypeCast = Number;
    else if (sType == "Date")
        fTypeCast = parseDate;
    else if (sType == "CaseInsensitiveString")
        fTypeCast = CaseInsensitiveString;
    return function (n1, n2) {
        if(_isEmptyStr(getInnerText(n1.cells[c]))){
    		return 1;
    	}else if(_isEmptyStr(getInnerText(n2.cells[c]))){
    		return -1;
    	}else{
	        if (fTypeCast(getInnerText(n1.cells[c])) < fTypeCast(getInnerText(n2.cells[c]))){
	        	return d ? -1 : 1;
	        
	        }
	        if (fTypeCast(getInnerText(n1.cells[c])) > fTypeCast(getInnerText(n2.cells[c]))){
	       			return d ? 1 : -1;
	        }
	    }
        return 0;
        
    };
}

String.prototype.isEmpty = function(){
	flag = true;
   for(var i=0;i<this.length;i++)
   {
      if(this.charAt(i)!=" ")
      { 
         flag = false; 
         break;
      }
   }
   return flag;
   }
function _isEmptyStr(str){
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
function sortColumnWithHold(e) {
    // find table element
    var el = ie5 ? e.srcElement : e.target;
    var table = getParent(el, "TABLE");
    
    // backup old cursor and onclick
    var oldCursor = table.style.cursor;
    var oldClick = table.onclick;
    
    // change cursor and onclick    
    table.style.cursor = "wait";
    table.onclick = null;
    
    // the event object is destroyed after this thread but we only need
    // the srcElement and/or the target
    var fakeEvent = {srcElement : e.srcElement, target : e.target};
    
    // call sortColumn in a new thread to allow the ui thread to be updated
    // with the cursor/onclick
    window.setTimeout(function () {
        sortColumn(fakeEvent);
        // once done resore cursor and onclick
        table.style.cursor = oldCursor;
        table.onclick = oldClick;
    }, 100);
}
function sortColumn(e,_descending) {
	_hiddenSortDiv();
    var tmp = e.target ? e.target : e.srcElement;
    if(_sortTd!=null){
    	tmp = _sortTd;
    }
    var tHeadParent = getParent(tmp, "THEAD");
    var el = getParent(tmp, "TH");
    if (tHeadParent == null)
        return;
    if (el != null) {
        var p = el.parentNode;
        var i;
        // typecast to Boolean
        /*el._descending = !Boolean(el._descending);
        if (tHeadParent.arrow != null) {
            if (tHeadParent.arrow.parentNode != el) {
                tHeadParent.arrow.parentNode._descending = null;    //reset sort order        
            }
            tHeadParent.arrow.parentNode.removeChild(tHeadParent.arrow);
        }
        if (el._descending)
            tHeadParent.arrow = arrowUp.cloneNode(true);
        else
            tHeadParent.arrow = arrowDown.cloneNode(true);
        el.appendChild(tHeadParent.arrow);*/
        // get the index of the td
        el.id=_descending;
        var cells = p.cells;
        var l = cells.length;
        for (i = 0; i < l; i++) {
            if (cells[i] == el) break;
        }
        var table = getParent(el, "TABLE");
        sortTable(table,i,_descending, el.getAttribute("sortType"));
    }
}
function getInnerText(el) {
    if (ie5) return el.innerText;    //Not needed but it is faster
    
    var str = "";
    
    var cs = el.childNodes;
    var l = cs.length;
    for (var i = 0; i < l; i++) {
        switch (cs[i].nodeType) {
            case 1: //ELEMENT_NODE
                str += getInnerText(cs[i]);
                break;
            case 3:    //TEXT_NODE
                str += cs[i].nodeValue;
                break;
        }
        
    }
    
    return str;
}
function getParent(el, pTagName) {
    if (el == null) return null;
    else if (el.nodeType == 1 && el.tagName.toLowerCase() == pTagName.toLowerCase())    // Gecko bug, supposed to be uppercase
        return el;
    else
        return getParent(el.parentNode, pTagName);
}
function _createSortDiv(){
	var sortDiv=document.createElement('div');
	sortDiv.id='sortDiv';
	sortDiv.style.position='absolute';
	sortDiv.style.display='none';
	sortDiv.style.borderWidth='1px';
	sortDiv.style.borderStyle='solid';
	sortDiv.style.borderColor='#DDDDDD';
	sortDiv.style.padding='0px';
	sortDiv.style.zIndex='107';
	sortDiv.innerHTML="<table width='100%' align='center' style='border-width:0px;border-bottom:1px;border-style:solid;border-color:#DDDDDD;margin-bottom:0px;line-height:24px;padding-left:15px;height:20px;color:#2669a0;font-size:14px;text-align:left;background:#fff url(../images/bg_subject.jpg) repeat-x;'><tr id='_sortUp'><td style='cursor:hand' onclick='sortColumn(event,true)' align='center'>ÉýÐò</td></tr><tr id='_sortDown'><td style='cursor:hand' onclick='sortColumn(event,false)' align='center'>½µÐò</td></tr></table>";
	document.body.appendChild(sortDiv);
}
function _hiddenSortDiv(){
	document.getElementById('sortDiv').style.display='none';
}
function _getSelectPosition(obj){   
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






