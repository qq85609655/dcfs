/**
	*
	*根据国家列出所属收养组织
	*@ author :mayun
	*@ date:2014-7-24
	*/
	function _findSyzzNameListForNew(countryCode,orgId,hiddenOrgId){
		$("#"+orgId).val("");//清空收养组织名称
		
		var countryCode = $("#"+countryCode).find("option:selected").val();//国家Code
		
		$("#"+orgId).find("option").each(function(){
             $(this).remove();
    	});
		
		//用于回显得收养组织ID
		var selectId = $("#"+hiddenOrgId).val();
		if(null != countryCode&&""!=countryCode){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=findSyzzNameList&countryCode='+countryCode,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(dataList){
					var st=$("#"+orgId);
			    	var options="<option value=''>--请选择--</option>";
				    for(var i=0;i<dataList.length;i++){
				         var data=dataList[i];
				         var name=data.CODENAME;
				         var id=data.CODEVALUE;
				         name="("+id+")"+name;
				         if(selectId == id){
				        	 options+="<option value="+id+" selected>"+name+"</option>";
				         }else{
				        	 options+="<option value="+id+">"+name+"</option>";
				         }
				     }
				     st.append(options);
				}
			  });
		}else{
			$("#"+orgId).append("<option value=''>--请选择--</option>");
			return false;
		}
	}
	
	
	/**
	*动态赋组织ID
	*@author:mayun
	*@date:2014-11-19
	*/
	function _setOrgID(orgId,orgIdValue){
		$("#"+orgId).val(orgIdValue);
	}