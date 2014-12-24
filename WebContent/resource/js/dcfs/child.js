
/***省、福利院联动JS：start********/

/**
 * citys = {city:[{code:'',name:''},{....}]} 省份结构
 * organs = {city:[code:'',organ:[{code:'',name:''},{....}]]} 省份组织对应结构
 * 
 */
//var citys;
var organs;
var selWelfareId;
/*
 * 1.省厅福利院查询条件联动所需方法
 */
function selectWelfare(node) {
	
	var curCity = node.value;
	
	//初始化
	if(organs == null || organs == "undefined"){
		//eval("citys = "+getStr("com.dcfs.mkr.organesupp.AjaxInitCity","t="+new Date()));
		eval("organs = "+getStr("com.dcfs.mkr.organesupp.AjaxInitOrgan","t="+new Date()));
	}

	//清空
	document.getElementById("S_WELFARE_ID").options.length = 0;
	document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--", ""));

	//所有省份的组织库
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
 * 2.省厅福利院查询条件联动所需方法
 */
function initProvOrg(wid) {
	var pObj = document.getElementById("S_PROVINCE_ID");
	selWelfareId = wid;
	selectWelfare(pObj);
}

/***省、福利院联动JS：end********/