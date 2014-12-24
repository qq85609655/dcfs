//formid表示:你的form是第几个form或者form名字 from表示:包含可选择项目的select对象名字
//to表示:列出可选择项目的select对象名字 limit表示:不能选的值,NotremoveFrom是否删除from中
//的值,NotAddTo不把值加到to中;flag为1提示已经存在项
//被选择元素得textname不能重名
function copyToList(formid,from,to,limit,NotRemoveFrom,NotAddTo,flag)
{

	fromList = eval('document.forms[' + formid + '].' + from);
	toList = eval('document.forms[' + formid + '].' + to);
//	if(toList.options.length > 0 && toList.options[0].value == '0')
//	{
//		toList.options.length = 0;
//	}
	var sel = false;
	for (i=0;i<fromList.options.length;i++)
	{
		var current = fromList.options[i];
		if(current.selected)
		{
			sel = true;
			if(current.value == '0' || current.value == limit)
			{
				alert (current.text+"不能选！");
//				return;
			}
			else
			{
				txt = current.text;
				val = current.value;
        addFlag = true;
        for(m=0;m<toList.options.length;m++)
        {
          if(txt == toList.options[m].text)
          {
            if (flag == 1)
            {
                //alert("该元素已经存在！");
            }
            addFlag = false;
            break;
          }
        }
        if(addFlag)
  				if(!NotAddTo) toList.options[toList.length] = new Option(txt,val);
  				if(!NotRemoveFrom){
  					fromList.options[i] = null;
					i--;
				}
			}
		}
	}
	if(!sel) alert ('请选择元素！');
}
function copyToListEx(formid,from,to,limit,NotRemoveFrom,NotAddTo) {
	fromList = eval('document.forms[' + formid + '].' + from);
	toList = eval('document.forms[' + formid + '].' + to);
	var sel = false;
	for (i=0;i<fromList.options.length;i++)	{
		var current = fromList.options[i];
		if (current.selected) {
			sel = true;
			if (current.value == '0' || current.value == limit) {
				alert (current.text+"不能选！");
			} else {
				txt = current.text;
				val = current.value;
				addFlag = true;
				for (m=0;m<toList.options.length;m++) {
					if (txt == toList.options[m].text) {
						addFlag = false;
						break;
					}
				}
				if (addFlag) {
					if(!NotAddTo) {
						toList.options[toList.length] = new Option(txt,val);
					}
				}
				if (!NotRemoveFrom) {
                    fromList.options[i] = null;
                    i--;
	            }
	        }
	    }
	}
	if (!sel) {
        alert ('请选择添加元素！');
    }
}
//formid表示:form名称或顺序 from表示:需要删元素的对象
//to表示:删除对象的回收站 limit表示:删除元素value满足的条件
function deleteFromList(formid,from,to,limit)
{
	fromList = eval('document.forms[' + formid + '].' + from);
	toList = eval('document.forms[' + formid + '].' + to);
	for (i=0;i<fromList.options.length;i++)
	{
		if(fromList.options[i].value == limit){
			var current = fromList.options[i];
			sel = true;
			txt = current.text;
			val = current.value;
			toList.options[toList.length] = new Option(txt,val);
			fromList.options[i] = null;
			i--;
		}
	}
}
//这是当用户按下提交按钮时，对列出选择的select对象执行全选工作，让递交至的后台程序能取得相关数据
//formid表示:form名称; item表示:select元素名称; pro表示:返回的字符串值的来源value或text;
function allSelect(formid,item,pro,sign)
{
	List = eval('document.forms[' + formid + '].' + item);
	str = "";
//	if (List.length && List.options[0].value == '0') return;
	for (i=0;i<List.length;i++)
	{
		if(List.options[i].value!=0)
		{
			List.options[i].selected = true;
			str += sign + eval('List.options[i].' + pro) + sign + ',';
		}
		else
		{
			List.options[i].selected = false;
		}
	}
	if(str.length > 0)
		str = str.substring(0,str.length-1);
	return str;
}
//选中所有选中的元素
function allSelected(formid,item,pro,sign)
{
	List = eval('document.forms[' + formid + '].' + item);
	str = "";
	for (i=0;i<List.length;i++)
	{
		if(List.options[i].value != 0 & List.options[i].selected)
		{
			List.options[i].selected = true;
			str += sign + eval('List.options[i].' + pro) + sign + ',';
		}
		else
		{
			List.options[i].selected = false;
		}
	}
	if(str.length > 0)
		str = str.substring(0,str.length-1);
	return str;
}
//将单选列表框中的元素进行上移,formid为页面中的id号码,movename为列表框的名称字符串
function upmove(formid,movename)
{
 movelist = eval('document.forms[' + formid + '].' + movename);
 var sel = false;
	for (i=0;i<movelist.options.length;i++)
	{
		var current = movelist.options[i];
		if(current.selected)
		{
		sel = true;
		if(i==1 || movelist.options[i].value=="0")
		{
			alert ('不能向上移动！');
			return;
		}
		txt = current.text;
		val = current.value;
		uptxt=movelist.options[i-1].text;
		upval=movelist.options[i-1].value;
		movelist.options[i-1].value = val;
		movelist.options[i-1].text=txt;
		movelist.options[i].value=upval;
		movelist.options[i].text=uptxt;
		movelist.options[i-1].selected=true;
		movelist.options[i].selected=false;

		}
	}
	if(!sel) alert ('请选择要移动的元素！');
}
//将单选列表框中的元素进行下移,formid为页面中的id号码,movename为列表框的名称字符串
function downmove(formid,movename)
{
 movelist = eval('document.forms[' + formid + '].' + movename);
 var sel = false;
	for (i=(movelist.options.length-1);i>=0;i--)
	{
		var current = movelist.options[i];
		if(current.selected)
		{
		sel = true;
		if(i==(movelist.options.length-1) || movelist.options[i].value=="0")
		{
			alert ('不能向下移动！');
			return;
		}
		txt = current.text;
		val = current.value;
		downtxt=movelist.options[i+1].text;
		downval=movelist.options[i+1].value;
		movelist.options[i+1].value = val;
		movelist.options[i+1].text=txt;
		movelist.options[i].value=downval;
		movelist.options[i].text=downtxt;
		movelist.options[i+1].selected=true;
		movelist.options[i].selected=false;
		}
	}
	if(!sel) alert ('请选择要移动的元素！');
}
