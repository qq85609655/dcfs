var status = 1;
function switchSysBar(state){
	if (state!=null){
		if(state==1){
			window.status=0;
		}else if(state==2){
			window.status=2;
		}else{
			window.status=1;
		}
	}
	if (2 == window.status){
		//alert('隐藏');
	 	window.status = 0;
        switchPoint.innerHTML = '';
        document.all("frmTitle").style.display="none";
        switchTable.style.display='none';
		return;
	}
     if (1 == window.status){
     	//alert('折叠');

		  window.status = 0;
		  switchTable.style.display='';
          switchPoint.innerHTML = '<img src="'+resourcePath+'/images/left.gif">';
          document.all("frmTitle").style.display="none"
     }
     else{
     //alert('展开');

		  window.status = 1;
		  switchTable.style.display='';
          switchPoint.innerHTML = '<img src="'+resourcePath+'/images/right.gif">';
          document.all("frmTitle").style.display=""
     }
}
function GetAbsoluteLocationEx(element)
{
    //element = document.getElementById("dynTable");
    if ( arguments.length != 1 || element == null )
    {
        return null;
    }
    var elmt = element;
    var offsetTop = elmt.offsetTop;
    var offsetLeft = elmt.offsetLeft;
    var offsetWidth = elmt.offsetWidth;
    var offsetHeight = elmt.offsetHeight;
    while( elmt = elmt.offsetParent )
    {
          // add this judge
        if ( elmt.style.position == 'absolute' || elmt.style.position == 'relative' 
            || ( elmt.style.overflow != 'visible' && elmt.style.overflow != '' ) )
        {
            break;
        } 
        offsetTop += elmt.offsetTop;
        offsetLeft += elmt.offsetLeft;
    }
    return { absoluteTop: offsetTop, absoluteLeft: offsetLeft, offsetWidth: offsetWidth, offsetHeight: offsetHeight };
    //alert(offsetLeft + "\n" + offsetTop);
}
function DvMenuCls(){
	var MenuHides = new Array();
	this.Show = function(obj,depth){
		var childNode = this.GetChildNode(obj);
		if (!childNode){return ;}
		if (typeof(MenuHides[depth])=="object"){
			this.closediv(MenuHides[depth]);
			MenuHides[depth] = '';
		};
		if (depth>0){
			alert(childNode.parentNode.offsetWidth);
			if (childNode.parentNode.offsetWidth>0){
				childNode.style.left= childNode.parentNode.offsetWidth+'px';
				
			}else{
				childNode.style.left='100px';
			};
			
			//childNode.style.top = '-2px';
			
		}else{
			var o = GetAbsoluteLocationEx(obj);
			childNode.style.left=(o["absoluteLeft"]-5)+"px";
			childNode.style.top=(o["absoluteTop"]+o["offsetHeight"])+"px";
		};
		//childNode.style.top = '26px';
		childNode.style.display ='block';   //跟下一句相反 如果用下一行的代码则鼠标放上去显示下拉菜单
		//childNode.style.display ='none';
		MenuHides[depth]=childNode;
		//alert(childNode.outerHTML);
	
	};
	this.closediv = function(obj){
		if (typeof(obj)=="object"){
			if (obj.style.display!='none'){
			obj.style.display='none';
			}
		}
	};
	this.Hide = function(depth){
		var i=0;
		if (depth>0){
			i = depth
		};
		while(MenuHides[i]!=null && MenuHides[i]!=''){
			this.closediv(MenuHides[i]);
			MenuHides[i]='';
			i++;
		};
	
	};
	this.Clear = function(){
		for(var i=0;i<MenuHides.length;i++){
			if (MenuHides[i]!=null && MenuHides[i]!=''){
				MenuHides[i].style.display='none';
				MenuHides[i]='';
			}
		}
	};
	this.GetChildNode = function(submenu){
		for(var i=0;i<submenu.childNodes.length;i++)
		{
			if(submenu.childNodes[i].nodeName.toLowerCase()=="div")
			{
				var obj=submenu.childNodes[i];
				break;
			}
		}
		return obj;
	};

}


function getleftbar(obj){
	var leftobj;
	var titleobj=obj.getElementsByTagName("a");
	leftobj = document.all ? frames["frmleft"] : document.getElementById("frmleft").contentWindow;
	if (!leftobj){return;}
	var menubar = leftobj.document.getElementById("menubar");
	menubar.innerHTML ="";
	
	var state=true;
	if (menubar){
			if (titleobj[0]){
				document.getElementById("leftmenu_title").innerHTML = titleobj[0].innerHTML;
			}
			var a=obj.getElementsByTagName("div");
			for(var i=0;i<a.length;i++){
				menubar.innerHTML = a[i].innerHTML;
				//设置触发事件
				var lis = menubar.getElementsByTagName("li");
				for(var j=0;j<lis.length;j++){
					lis[j].onclick=function(){	
						_addMenu(this);
					};
				}
				state=false;
				//alert(a[i].innerHTML);
			}
	}
	if (state){
		switchSysBar(2);
	}else{
		switchSysBar(1);
	}
	
	//去掉选中，选择新的选中
	//_clearSelect();
	//_setSelect(obj);
	
	
}


// 修改编辑栏高度
function admin_Size(num,objname)
{
	var obj=document.getElementById(objname)
	if (parseInt(obj.rows)+num>=3) {
		obj.rows = parseInt(obj.rows) + num;	
	}
	if (num>0)
	{
		obj.width="90%";
	}
}

var ColorImg;
var ColorValue;
function hideColourPallete() {
	document.getElementById("colourPalette").style.visibility="hidden";
}
function Getcolor(img_val,input_val){
	var obj = document.getElementById("colourPalette");
	ColorImg = img_val;
	ColorValue = document.getElementById(input_val);
	if (obj){
	obj.style.left = getOffsetLeft(ColorImg) + "px";
	obj.style.top = (getOffsetTop(ColorImg) + ColorImg.offsetHeight) + "px";
	if (obj.style.visibility=="hidden")
	{
	obj.style.visibility="visible";
	}else {
	obj.style.visibility="hidden";
	}
	}
}
//Colour pallete top offset
function getOffsetTop(elm) {
	var mOffsetTop = elm.offsetTop;
	var mOffsetParent = elm.offsetParent;
	while(mOffsetParent){
		mOffsetTop += mOffsetParent.offsetTop;
		mOffsetParent = mOffsetParent.offsetParent;
	}
	return mOffsetTop;
}

//Colour pallete left offset
function getOffsetLeft(elm) {
	var mOffsetLeft = elm.offsetLeft;
	var mOffsetParent = elm.offsetParent;
	while(mOffsetParent) {
		mOffsetLeft += mOffsetParent.offsetLeft;
		mOffsetParent = mOffsetParent.offsetParent;
	}
	return mOffsetLeft;
}
function setColor(color)
{
	if (ColorValue){ColorValue.value = color;}
	if (ColorImg){ColorImg.style.backgroundColor = color;}
	document.getElementById("colourPalette").style.visibility="hidden";
}

//SELECT表单选取
function CheckSel(Voption,Value)
{
	var obj = document.getElementById(Voption);
	for (i=0;i<obj.length;i++){
		if (obj.options[i].value==Value){
		obj.options[i].selected=true;
		break;
		}
	}
}

//单选表单选取
function chkradio(Obj,Val)
{
	if (Obj)
	{
	for (i=0;i<Obj.length;i++){
		if (Obj[i].value==Val){
		Obj[i].checked=true;
		break;
		}
	}
	}
}
//用户组批量更新按钮 <input type="button" value="选择用户组" onclick="getGroup('Select_Group');">
//记录 更新ID的表单 <input name="groupid" type="hidden" value="<%=Request("groupid")%>">
function getGroup(Did)
{
var SGroup = fetch_object(Did);
	if (SGroup){
		if (SGroup.style.display=='none'){
		SGroup.style.top = (document.body.scrollTop+((document.body.clientHeight-300)/2))+"px";
		SGroup.style.left = (document.body.scrollLeft+((document.body.clientWidth-480)/2))+"px";
		SGroup.style.display = '';
		}
		else{
			var SelGroupid = fetch_object("SelGroupid");
			var groupid = fetch_object("groupid");
			var Val="";
			SGroup.style.display='none';
			if (SelGroupid){
				for (var i=0;i<SelGroupid.length;i++){
					if (SelGroupid.options[i].selected){
						Val += SelGroupid.options[i].value;
						Val += ",";
					}
				}
				groupid.value = Val.substr(0,Val.lastIndexOf(","));
			}
		}
	}
}

//复选表单全选事件 form：表单名
function CheckAll(form)  {
	for (var i=0;i<form.elements.length;i++)
	{
		var e = form.elements[i];
		if (e.name != 'chkall'&&e.type=="checkbox")
		{
			e.checked = form.chkall.checked;
		}
	}
}


function BoardJumpListSelect_Admin(boardid,selectname,fristoption,fristvalue,checknopost){
	if(typeof(cache["boardlist"])=="undefined"){
		GetBoardXmlbak(boardxml,'../',boardid);
		if (xslDoc.parseError){
			if (xslDoc.parseError.errorCode!=0){
					return;
			}
		}
		cache["boardlist"] = xslDoc.documentElement.getElementsByTagName("board");
	}

	var sel = 0;
	var sObj = document.getElementById(selectname);
	if (sObj)
	{
		sObj.options[0] =  new Option(fristoption, fristvalue);

		var nodes = cache["boardlist"];
		if (nodes)
		{
			for (var i = 0,k = 1;i<nodes.length;i++) {
				var t = nodes[i].getAttribute("boardtype");
				var v = nodes[i].getAttribute("boardid");
				if (v==boardid)
				{
					sel = k;
				}
				if (nodes[i].getAttribute("depth")==0){
					var outtext="╋";
				}
				else
				{
					var outtext="";
					for (var j=0;j<(nodes[i].getAttribute("depth"));j++)
					{
						if (j>0){outtext+=" |"}
						outtext+="  "
					}
					outtext+="├"
				}
				t = outtext + t
				t = t.replace(/<[^>]*>/g, "")
				t = t.replace(/&[^&]*;/g, "")
				if(checknopost==1 && nodes[i].getAttribute("nopost")=='1')
				{
						t+="(不许转移)"
				}
				sObj.options[k++] = new Option(t, v);
			}
			sObj.options[sel].selected = true;
		}
	}
}