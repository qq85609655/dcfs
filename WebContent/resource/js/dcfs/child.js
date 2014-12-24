
/***ʡ������Ժ����JS��start********/

/**
 * citys = {city:[{code:'',name:''},{....}]} ʡ�ݽṹ
 * organs = {city:[code:'',organ:[{code:'',name:''},{....}]]} ʡ����֯��Ӧ�ṹ
 * 
 */
//var citys;
var organs;
var selWelfareId;
/*
 * 1.ʡ������Ժ��ѯ�����������跽��
 */
function selectWelfare(node) {
	
	var curCity = node.value;
	
	//��ʼ��
	if(organs == null || organs == "undefined"){
		//eval("citys = "+getStr("com.dcfs.mkr.organesupp.AjaxInitCity","t="+new Date()));
		eval("organs = "+getStr("com.dcfs.mkr.organesupp.AjaxInitOrgan","t="+new Date()));
	}

	//���
	document.getElementById("S_WELFARE_ID").options.length = 0;
	document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--", ""));

	//����ʡ�ݵ���֯��
	var organsArr = organs.city;
	var len = organsArr.length;
	if(organsArr != null && len > 0){
		for (var i = 0; i < len; i++) {
			var city = organsArr[i];
			var cCityCode = city.code;
			if(cCityCode == curCity){
				var orgs = city.organ;
				var le = orgs.length;
				if(orgs != null && le > 0){
					for ( var j = 0; j < le; j++) {
						var org = orgs[j];
						if(selWelfareId == org.code) {
							document.getElementById("S_WELFARE_ID").options.add(new Option(org.name, org.code));
							document.getElementById("S_WELFARE_ID").value = selWelfareId;
							
						} else {
							document.getElementById("S_WELFARE_ID").options.add(new Option(org.name, org.code));
						}
					}
				}
			}
		}
	}
}
/**
 * 2.ʡ������Ժ��ѯ�����������跽��
 */
function initProvOrg(wid) {
	var pObj = document.getElementById("S_PROVINCE_ID");
	selWelfareId = wid;
	selectWelfare(pObj);
}

/***ʡ������Ժ����JS��end********/