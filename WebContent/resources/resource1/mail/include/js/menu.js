var $ = function (id) {
	return "string" == typeof id ? document.getElementById(id) : id;
};

function addEventHandler(oTarget, sEventType, fnHandler) {
	if (oTarget.addEventListener) {
		oTarget.addEventListener(sEventType, fnHandler, false);
	} else if (oTarget.attachEvent) {
		oTarget.attachEvent("on" + sEventType, fnHandler);
	} else {
		oTarget["on" + sEventType] = fnHandler;
	}
};

function Event(e){
	var oEvent = document.all ? window.event : e;
	if (document.all) {
		if(oEvent.type == "mouseout") {
			oEvent.relatedTarget = oEvent.toElement;
		}else if(oEvent.type == "mouseover") {
			oEvent.relatedTarget = oEvent.fromElement;
		}
		
		oEvent.stopPropagation = function() { this.cancelBubble = true; }
	}
	return oEvent;
}

function Each(list, fun){
	for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }
};


var Class = {
  create: function() {
	return function() {
	  this.initialize.apply(this, arguments);
	}
  }
}

Object.extend = function(destination, source) {
	for (var property in source) {
		destination[property] = source[property];
	}
	return destination;
}


var CommonMenu = Class.create();
CommonMenu.prototype = {
  //��ʼ������(��������, �˵��ṹ)
  initialize: function(arrContainer, arrMenu, options) {
	if(arrContainer.length <= 0 || arrMenu.lenght <= 0) return;
	
	var oThis = this;
	
	this._timerContainer = null;//������ʱ��
	this._timerMenu = null;//�˵���ʱ��
	this._onmenu = null;//��ǰ�˵�����
	this._index = -1;//Ҫ��������������
	
	this.Container = [];//��������
	this._menu = arrMenu;//�˵��ṹ
	
	this.SetOptions(options);
	
	this.Position = this.options.Position || "right";
	this.Delay = parseInt(this.options.Delay) || 0;
	this.Class = this.options.Class || "";
	this.onClass = this.options.onClass || this.Class;
	this.Tag = this.options.Tag;
	
	//��������
	Each(arrContainer, function(o, i){ oThis.IniContainer(oThis.Container[i] = (o = $(o)), i > 0); });
	
	this.Ini();
  },
  //����Ĭ������
  SetOptions: function(options) {
	this.options = {//Ĭ��ֵ
		Position:	"right",//Ĭ��λ��(up,down,left,right)
		Tag:		"div",//Ĭ�����ɱ�ǩ
		Class:		"",//Ĭ����ʽ
		onClass:	"",//������ʽ
		Delay:		0//�ӳ�ֵ(΢��)
	};
	Object.extend(this.options, options || {});
  },
  //��ʼ������(��������, �Ƿ��Ӳ˵�����)
  IniContainer: function(container, bChild) {
	var oThis = this;
	addEventHandler(container, "mouseover", function(){ clearTimeout(oThis._timerContainer); });
	addEventHandler(container, "mouseout", function(e){
		//�Ƿ��ڲ˵�֮��
		var isIn = false, oT = Event(e).relatedTarget;
		Each(oThis.Container, function(o, i){ if(o.contains ? o.contains(oT) || o == oT : o.compareDocumentPosition(oT) & 16){ isIn = true; } });
		//�ڲ˵�������
		if(!isIn){
			clearTimeout(oThis._timerContainer); clearTimeout(oThis._timerMenu);
			oThis._timerContainer = setTimeout(function(){ oThis.Hide(); }, oThis.Delay);
		}
	});
	//��������
	container.index = -1;
	//�Ӳ˵���������
	if (bChild) { container.style.position = "absolute"; container.style.visibility = "hidden"; }
  },
  //��ʼ����һ������
  Ini: function() {
	this.Container[0].innerHTML = ""; this._index = 0; this.SetMenu(this._menu);
  },
  //ȫ������
  Set: function() {
	//����select
	Each(document.getElementsByTagName("select"), function(o){ o.style.visibility = "hidden"; })
	
	var menu = this._menu;
	//��һ������Ҫ�������Դ�1��ʼ
	var i = 1;
	while (menu.length > 0) {
		//��ȡ�Ӳ˵��ṹ�Ͷ�λ
		var iC = this.Container[i-1].index, position = this.Position;
		if(iC >= 0){
			//����Ҫ��ȡposition����menu
			position = menu[iC].position || this.Position; menu = menu[iC].menu || [];
		} else { menu = []; }
		
		//������������͸���ǰһ���Զ�����
		if(!this.Container[i]){
			var oPre = this.Container[i-1], oNew = document.body.appendChild(document.createElement(oPre.tagName));
			oNew.style.cssText = oPre.style.cssText; oNew.className = oPre.className;
			this.IniContainer(this.Container[i] = oNew, true);
		}
		
		//������һ���˵�
		if(this._index == i++){ this.SetContainer(menu, position); break; }
	}
  },
  //��������(�˵��ṹ, λ��)
  SetContainer: function(menu, position) {
	var oContainer = this.Container[this._index];
	
	//��������
	oContainer.innerHTML = ""; oContainer.index = -1; oContainer.style.visibility = "hidden";
	
	if(menu.length > 0){
		//���ò˵�
		this.SetMenu(menu);
		
		//������λ
		//offsetȡֵ����ƫ�Ҫע��
		var o = this._onmenu, iLeft = o.offsetLeft, iTop = o.offsetTop;
		//ע�����displayΪnone�Ļ�ȡ����offsetֵ������Ҫ��visibility
		switch (position.toLowerCase()) {
			case "up" :
				iTop -= oContainer.offsetHeight;
				break;
			case "down" :
				iTop += o.offsetHeight;
				break;
			case "left" :
				iLeft -= oContainer.offsetWidth;
				break;
			case "right" :
			default :
				iLeft += o.offsetWidth;
		}
		while (o.offsetParent) { o = o.offsetParent; iLeft += o.offsetLeft; iTop += o.offsetTop; }
		oContainer.style.left = iLeft + "px"; oContainer.style.top = iTop + "px";
		oContainer.style.visibility = "visible";
	}
	
	//���ز���Ҫ������
	for(var i = this._index + 1, len = this.Container.length; i < len; i++){ this.Container[i].style.visibility = "hidden";  }
  },
  //�˵�����(�˵��ṹ)
  SetMenu: function(menu) {
	var oThis = this, index = this._index, oContainer = this.Container[index];
	Each(menu, function(o, i){
		var oMenu = document.createElement(oThis.Tag);
		if(o.show==null||(o.show!=null&&o.show!="false"))
		{
			oMenu.innerHTML = o.txt;
			oMenu.onmouseover = function(){
				clearTimeout(oThis._timerMenu);
				
				//�������ò˵�
				oThis._timerMenu = setTimeout(function(){
					oContainer.index = i; oThis._onmenu = oMenu; oThis._index = index + 1;  oThis.Set();
				}, oThis.Delay);
				
				//����������ʽ
				//Ϊ���������ʱ����ʽ������ÿ�ζ�ȫ����������
				Each(oThis.Container, function(o, i){
					if(i > index) return;
					Each(o.getElementsByTagName(oThis.Tag), function(o){ o.className = oThis.Class; });
					if(i == index){
						oMenu.className = oThis.onClass;
					} else if(o.index >= 0) {
						o.getElementsByTagName(oThis.Tag)[o.index].className = oThis.onClass;
					} else return;
				});
			}
			oContainer.appendChild(oMenu);
		}
	});	
  },
  //���ز˵�
  Hide: function() {
	var oThis = this;
	//����һ��������
	Each(this.Container, function(o, i){
		if(i == 0){
			Each(o.getElementsByTagName(oThis.Tag), function(o, i){ o.className = oThis.Class; })
		} else { o.style.visibility = "hidden"; }
		o.index = -1;
	});
	
	//��ʾselect
	Each(document.getElementsByTagName("select"), function(o){ o.style.visibility = "visible"; })
  },
  //���Ӳ˵�(һ���˵��ṹ)
  Add: function(arrMenu) {
	this._menu.push(arrMenu); this.Ini();
  },
  //ɾ���˵�
  Delete: function(index) {
	if(index < 0 || index >= this._menu.length) return;
	for(var i = index, len = this._menu.length - 1; i < len; i++){ this._menu[i] = this._menu[i + 1]; }
		this._menu.pop(); this.Ini();
  }
};