/**
	*
	*���ݹ����г�����������֯
	*@ author :mayun
	*@ date:2014-7-24
	*/
	function _findSyzzNameListForNew(countryCode,orgId,hiddenOrgId){
		$("#"+orgId).val("");//���������֯����
		
		var countryCode = $("#"+countryCode).find("option:selected").val();//����Code
		
		$("#"+orgId).find("option").each(function(){
             $(this).remove();
    	});
		
		//���ڻ��Ե�������֯ID
		var selectId = $("#"+hiddenOrgId).val();
		if(null != countryCode&&""!=countryCode){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=findSyzzNameList&countryCode='+countryCode,
				type: 'POST',
				dataType: 'json',
				timeout: 10000,
				success: function(dataList){
					var st=$("#"+orgId);
			    	var options="<option value=''>--��ѡ��--</option>";
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
			$("#"+orgId).append("<option value=''>--��ѡ��--</option>");
			return false;
		}
	}
	
	
	/**
	*��̬����֯ID
	*@author:mayun
	*@date:2014-11-19
	*/
	function _setOrgID(orgId,orgIdValue){
		$("#"+orgId).val(orgIdValue);
	}