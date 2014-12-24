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

function Each(arrList, fun){
    for (var i = 0, len = arrList.length; i < len; i++) { fun(arrList[i], i); }
};

function GetOption(val, txt) {
    var op = document.createElement("OPTION");
    op.value = val; op.innerHTML = txt;
    return op;
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


var CommonSelect = Class.create();
CommonSelect.prototype = {
  //select���ϣ��˵�����
  initialize: function(arrSelects, arrMenu, options) {
    if(arrSelects.length <= 0 || arrMenu.lenght <= 0) return;//�˵�����
    
    var oThis = this;
    
    this.Selects = [];//select����
    this.Menu = arrMenu;//�˵�����
    
    this.SetOptions(options);
    
    this.Default = this.options.Default || [];
    
    this.ShowEmpty = !!this.options.ShowEmpty;
    this.EmptyText = this.options.EmptyText.toString();
    
    //����Selects���Ϻ�change�¼�
    Each(arrSelects, function(o, i){
        addEventHandler((oThis.Selects[i] = $(o)), "change", function(){ oThis.Set(i); });
    });
    
    this.ReSet();
  },
  //����Ĭ������
  SetOptions: function(options) {
    this.options = {//Ĭ��ֵ
        Default:    [],//Ĭ��ֵ(��˳��)
        ShowEmpty:    false,//�Ƿ���ʾ��ֵ(λ�ڵ�һ��)
        EmptyText:    "��ѡ��"//��ֵ��ʾ�ı�(ShowEmptyΪtrueʱ��Ч)
    };
    Object.extend(this.options, options || {});
  },
  //��ʼ��select
  ReSet: function() {
  
    this.SetSelect(this.Selects[0], this.Menu, this.Default.shift());
    this.Set(0);
  },
  //ȫ��select����
  Set: function(index) {
    var menu = this.Menu
    
    //��һ��select����Ҫ�������Դ�1��ʼ
    for(var i=1, len = this.Selects.length; i < len; i++){
        if(menu.length > 0){
            //��ȡ�˵�
            var value = this.Selects[i-1].value;
            if(value!=""){
                Each(menu, function(o){ if(o.val == value){ menu = o.menu || []; } });
            } else { menu = []; }
            
            //���ò˵�
            if(i > index){ this.SetSelect(this.Selects[i], menu, this.Default.shift()); }
        } else {
            //û������
            this.SetSelect(this.Selects[i], [], "");
        }
    }
    //���Ĭ��ֵ
    this.Default.length = 0;
  },
  //select����
  SetSelect: function(oSel, menu, value) {
    oSel.options.length = 0; oSel.disabled = false;
    if(this.ShowEmpty){ oSel.appendChild(GetOption("", this.EmptyText)); }
    if(menu.length <= 0){ oSel.disabled = true; return; }
    
    Each(menu, function(o){
		if(o.show==null||(o.show!=null&&o.show!="false"))
		{
			var op = GetOption(o.val, o.txt ? o.txt : o.val); op.selected = (value == op.value);
			oSel.appendChild(op);
		}
    });    
  },
  //��Ӳ˵�
  Add: function(menu) {
    this.Menu[this.Menu.length] = menu;
    this.ReSet();
  },
  //ɾ���˵�
  Delete: function(index) {
    if(index < 0 || index >= this.Menu.length) return;
    for(var i = index, len = this.Menu.length - 1; i < len; i++){ this.Menu[i] = this.Menu[i + 1]; }
    this.Menu.pop()
    this.ReSet();
  }
};