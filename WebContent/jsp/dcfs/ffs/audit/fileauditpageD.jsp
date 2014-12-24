<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>家庭文件（双亲）经办人审核</title>
	<BZ:webScript edit="true"/>
	<BZ:webScript list="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
</script>
<BZ:body property="filedata" codeNames="SYLX;WJLX;GJSY;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_CHILDREN_ABOVE;ADOPTER_MARRYCOND;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH">
	<script type="text/javascript">
	    $(document).ready( function() {
		      $('#tab-container').easytabs();
		      $("#P_MALE_HEALTH_CONTENT_CN").attr('disabled','true');
		      $("#P_FEMALE_HEALTH_CONTENT_CN").attr('disabled','true');
		      $("#P_MALE_HEALTH").change(function(){
					var val = $(this).val();
					if("2"==val){
						$("#P_MALE_HEALTH_CONTENT_CN").removeAttr('disabled');;
					}else{
						$("#P_MALE_HEALTH_CONTENT_CN").attr('disabled','true');
					}
			  });
		      $("#P_FEMALE_HEALTH").change(function(){
					var val = $(this).val();
					if("2"==val){
						$("#P_FEMALE_HEALTH_CONTENT_CN").removeAttr('disabled');;
					}else{
						$("#P_FEMALE_HEALTH_CONTENT_CN").attr('disabled','true');
					}
			  });
		      $("#tizhong_m").bind("change",function(){
		    	  fromConverToValue(this,"P_MALE_WEIGHT","lbTokg");
		    	  calBmi($("#P_MALE_WEIGHT"),$("#P_MALE_HEIGHT"),$("#P_MALE_BMI"));
		      });
		      $("#P_MALE_WEIGHT").bind("change",function(){
		    	  fromConverToValue(this,"tizhong_m","kgTolb");
		    	  calBmi(this,$("#P_MALE_HEIGHT"),$("#P_MALE_BMI"));
		      });
		      $("#tizhong_w").bind("change",function(){
		    	  fromConverToValue(this,"P_FEMALE_WEIGHT","lbTokg");
		    	  calBmi($("#P_FEMALE_WEIGHT"),$("#P_FEMALE_HEIGHT"),$("#P_FEMALE_BMI"));
		      });
		      $("#P_FEMALE_WEIGHT").bind("change",function(){
		    	  fromConverToValue(this,"tizhong_w","kgTolb");
		    	  calBmi(this,$("#P_FEMALE_HEIGHT"),$("#P_FEMALE_BMI"));
		      });
		      /*男收养人*/
		      $("#yingchi_m").bind("change",function(){
		    	  fromConverToValue(this,"yingcun_m","feetToinche");
		    	  fromConverToValue(this,"P_MALE_HEIGHT","feetTocm");
		    	  calBmi($("#P_MALE_WEIGHT"),$("#P_MALE_HEIGHT"),$("#P_MALE_BMI"));
		      });
		      $("#yingcun_m").bind("change",function(){
		    	  fromConverToValue(this,"yingchi_m","incheTofeet");
		    	  fromConverToValue(this,"P_MALE_HEIGHT","incheTocm");
		    	  calBmi($("#P_MALE_WEIGHT"),$("#P_MALE_HEIGHT"),$("#P_MALE_BMI"));
		      });
		      $("#P_MALE_HEIGHT").bind("change",function(){
		    	  fromConverToValue(this,"yingchi_m","cmTofeet");
		    	  fromConverToValue(this,"yingcun_m","cmToinche");
		    	  calBmi($("#P_MALE_WEIGHT"),this,$("#P_MALE_BMI"));
		      });
		      /*女收养人*/
		      $("#yingchi_w").bind("change",function(){
		    	  fromConverToValue(this,"yingcun_w","feetToinche");
		    	  fromConverToValue(this,"P_FEMALE_HEIGHT","feetTocm");
		    	  calBmi($("#P_FEMALE_WEIGHT"),$("#P_FEMALE_HEIGHT"),$("#P_FEMALE_BMI"));
		      });
		      $("#yingcun_w").bind("change",function(){
		    	  fromConverToValue(this,"yingchi_m","incheTofeet");
		    	  fromConverToValue(this,"P_FEMALE_HEIGHT","incheTocm");
		    	  calBmi($("#P_FEMALE_WEIGHT"),$("#P_FEMALE_HEIGHT"),$("#P_FEMALE_BMI"));
		      });
		      $("#P_FEMALE_HEIGHT").bind("change",function(){
		    	  fromConverToValue(this,"yingchi_w","cmTofeet");
		    	  fromConverToValue(this,"yingcun_w","cmToinche");
		    	  calBmi($("#P_FEMALE_WEIGHT"),this,$("#P_FEMALE_BMI"));
		      });
		      $("#fanyiNohege").hide();
		      
	    });
	    function fanyizhiliangClick(){
	    	 var val = $("input[name='AUD_TRANSLATION_QUALITY']:checked").val();
	    	 if(val == '2'){
	   			  $("#fanyiNohege").show();
	   		  }else{
	   			  $("#fanyiNohege").hide();
	   		  }
	    }
	    function fromConverToValue(fromObj,toObj,converType){
	    	var lbTokg = 0.4535924;       // 磅TO千克
	    	var kgTolb = 2.2046226;       // 千克TO磅
	    	var feetToinche = 12;         // 英尺TO英寸
	    	var feetTocm = 30.48;         // 英尺To厘米
	    	var incheTofeet = 0.0833333;  // 英寸TO英尺
	    	var incheTocm = 2.54;         // 英寸To厘米
	    	var cmToinche = 0.3937008;    // 厘米To英寸
	    	var cmTofeet = 0.0328084;     // 厘米To英尺
	    	var fromVal = $(fromObj).val();
	    	var toVal = 0.0;
	    	if(null != fromVal && "" != fromVal){
	    	    if(converType == 'lbTokg'){
	    	    	toVal = fromVal * lbTokg;
	    	    }
	    	    if(converType == 'kgTolb'){
	    	    	toVal = fromVal * kgTolb;
	    	    }
	    	    if(converType == 'feetToinche'){
	    	    	toVal = fromVal * feetToinche;
	    	    }
	    	    if(converType == 'feetTocm'){
	    	    	toVal = fromVal * feetTocm;
	    	    }
	    	    if(converType == 'incheTofeet'){
	    	    	toVal = fromVal * incheTofeet;
	    	    }
	    	    if(converType == 'incheTocm'){
	    	    	toVal = fromVal * incheTocm;
	    	    }
	    	    if(converType == 'cmToinche'){
	    	    	toVal = fromVal * cmToinche;
	    	    }
	    	    if(converType == 'cmTofeet'){
	    	    	toVal = fromVal * cmTofeet;
	    	    }
	    	    $("#"+toObj).val(toDecimal(toVal));
	    	}
	    	return toDecimal(toVal);
		}
	    /*
	     * 保留一位小数点
	     */
	    function toDecimal(x) {  
	        var f = parseFloat(x); 
	        if (isNaN(f)) {  
	            return;  
	        }  
	        f = Math.round(x*10)/10;  
	        return f;  
	    }
	    /*
	     * 体重指数 ： 体重/（身高*身高）
	     */
	    function calBmi(_weightObj,_heightObj,_bmiObj){
	    	var _weightVal = $(_weightObj).val();
	    	var _heightVal =$(_heightObj).val();
	    	if(null != _weightVal && ""!=_weightVal && null != _heightVal && "" != _heightVal){
	    		$(_bmiObj).val(Math.round(_weightVal/((_heightVal*_heightVal)/10000)*10)/10);
	    	}
	    }
	    /*
	     * 计算结婚几年
	     */
	    function calMarrayYear(marrayTimeObj,marrayYearObj){
	    	var marrayTimeVal = $(marrayTimeObj).val();
	    	if(null != marrayTimeVal && ""!=marrayTimeVal){
	    		var d = new Date(); 
	    		var curYear = d.getFullYear(); 
	    		var marrayYear = marrayTimeVal.substring(0,marrayTimeVal.indexOf('-'));
	    		$(marrayYearObj).val(curYear-marrayYear);
	    	}
	    }
	    /*
	     * 计算净资产
	     */
	    function calNetworth(total_asset,total_debt,valObj){
	    	var assetVal = $(total_asset).val();
	    	var debtVal  = $(total_debt).val();
	    	if(""!=assetVal && ""!=debtVal){
	    		var val = parseFloat(assetVal) - parseFloat(debtVal);
	    		if(val < 0){
	    			val = val * (-1);
	    		}
	    		$(valObj).val(toDecimal(val));
	    	}
	    }
	</script>
	<BZ:form name="srcForm" method="post">
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action" desc="按钮区">
			<a href="reporter_files_list.html" >
				<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="附件预览" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="打印" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">收养组织(CN)</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养组织(EN)</td>
						<td class="bz-edit-data-value" colspan="5"> 
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">收文日期</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">收文编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">收养类型</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">是否公约收养</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">之前收文编号</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否预警名单</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_ALERT" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">是否转组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=否;1=是" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">原收养组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">暂停状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PAUSE" checkValue="0=未暂停;1=已暂停" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">暂停原因</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_REASON" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">末次文件补充状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_STATE" checkValue="0=未补充;1=已补充" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">退文状态</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" checkValue="0=待确认;1=已确认;2=待处置;3=已处置" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">退文原因</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">文件补充次数</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
			<li class='tab'><a href="#tab1">基本信息(中文)</a></li>
			<li class='tab'><a href="#tab2">基本信息(英文)</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab3">审核记录</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab4">补充记录</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab5">修改记录</a></li>
			<li class='tab'><a href="#tab6">翻译记录</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">收养人基本信息</th>
				  </tr>
				  <tr>
				    <th width="16%">&nbsp;</th>
				    <th colspan="2">男收养人</th>
				    <th colspan="3">女收养人</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">外文姓名</td>
				    <td width="23%">
				    	<BZ:input field="MALE_NAME" prefix="P_" type="String" notnull="请输入男收养人姓名" formTitle="男收养人姓名" defaultValue=""/>
				    </td>
				    <td width="12%" rowspan="5">&nbsp;</td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_NAME" prefix="P_" type="String" notnull="请输入女收养人姓名" formTitle="女收养人姓名" defaultValue="" />
				    </td>
				    <td width="12%" rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">出生日期</td>
				    <td>
				    	<BZ:input field="MALE_BIRTHDAY" prefix="P_" type="date" formTitle="男出生日期" defaultValue="" style="width:165px;"/>
				    </td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_BIRTHDAY" prefix="P_" type="date" formTitle="女出生日期" defaultValue="" style="width:165px;"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">年龄</td>
				    <td>
				    	<BZ:input field="FEMALE_BIRTHDAY" prefix="P_" type="String" formTitle="男收养人年龄" defaultValue="" disabled="true" size="10"/>
				    </td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_BIRTHDAY" prefix="P_" type="String" formTitle="女收养人年龄" defaultValue="" disabled="ture" size="10"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">国籍</td>
				    <td>
				    	<BZ:select field="MALE_NATION" formTitle="国籍" codeName="GJSY" isCode="true" defaultValue="" width="165"></BZ:select>
				    </td>
				    <td colspan="2">
				    	<BZ:select field="FEMALE_NATION" formTitle="国籍" codeName="GJSY" isCode="true"  defaultValue=""></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">护照号码</td>
				    <td>
				    	<BZ:input field="MALE_PASSPORT_NO" prefix="P_" type="String" formTitle="男收养人护照号码" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_PASSPORT_NO" prefix="P_" type="String" formTitle="女收养人护照号码" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">受教育程度</td>
				    <td colspan="2">
				    	<BZ:select field="MALE_EDUCATION" formTitle="男收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" defaultValue=""></BZ:select>
				    </td>
				    <td colspan="3">
				    	<BZ:select field="FEMALE_EDUCATION" formTitle="女收养人受教育程度" isCode="true"  codeName="ADOPTER_EDU" defaultValue=""></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">职业</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_JOB_CN" prefix="P_" type="String" formTitle="男收养人职业" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_JOB_CN" prefix="P_" type="String" formTitle="女收养人职业" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">健康状况</td>
				    <td colspan="2">
				    	<BZ:select width="100px" field="MALE_HEALTH" prefix="P_" formTitle="男收养人健康状况" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue=""></BZ:select>
				    	<textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_CN" id="P_MALE_HEALTH_CONTENT_CN">
				    		<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				    <td colspan="3">
				    	<BZ:select width="100px" field="FEMALE_HEALTH" prefix="P_" formTitle="女收养人健康状况"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue=""></BZ:select>
				    	<textarea style="height: 20px;width: 60%;" name="P_FEMALE_HEALTH_CONTENT_CN" id="P_FEMALE_HEALTH_CONTENT_CN">
				    		<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">身高</td>
				    <td colspan="2">
				    	<input type="text" id="yingchi_m" size="4"/>英尺<input type="text" id="yingcun_m" size="4"/>英寸
				    	<BZ:input field="MALE_HEIGHT" prefix="P_"  id="P_MALE_HEIGHT" type="String" formTitle="男收养人身高" defaultValue="" size="5"/>
				    	厘米
				    </td>
				    <td colspan="3">
				    	<input type="text" id="yingchi_w" size="4"/>英尺<input type="text" id="yingcun_w" size="4"/>英寸
				    	<BZ:input field="FEMALE_HEIGHT" prefix="P_" id="P_FEMALE_HEIGHT" type="String" formTitle="女收养人身高" defaultValue="" size="5"/>
				    	厘米
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">体重</td>
				    <td colspan="2">
				    	<input type="text" id="tizhong_m" name="tizhong_m" size="4"/>磅
				    	<BZ:input field="MALE_WEIGHT" prefix="P_" type="String" formTitle="男收养人体重" defaultValue="" size="5" id="P_MALE_WEIGHT"/>
				    	千克
				    </td>
				    <td colspan="3">
				    	<input type="text" id="tizhong_w" size="4" onchange="lbToKg(this,P_FEMALE_WEIGHT);"/>磅
				    	<BZ:input field="FEMALE_WEIGHT" prefix="P_" id="P_FEMALE_WEIGHT" type="String" formTitle="男收养人体重" defaultValue="" size="5"/>
				    	千克
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">体重指数</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_BMI" prefix="P_" type="String" formTitle="男收养人体重指数" defaultValue="" disabled="true" id="P_MALE_BMI"/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_BMI" prefix="P_" type="String" formTitle="男收养人体重指数" defaultValue="" disabled="true" id="P_FEMALE_BMI"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">违法行为及刑事处罚</td>
				    <td colspan="2">
				    	<%-- <BZ:radios prefix="P_" field="MALE_PUNISHMENT_FLAG" formTitle="男收养人违法行为及刑事处罚" codeValues="0=无;1=有"/> --%>
				    	
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	
				    	<textarea style="height: 30px;width: 50%;" id="P_MALE_PUNISHMENT_CN" name="P_MALE_PUNISHMENT_CN"></textarea>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<textarea style="height: 30px;width: 50%;" id="P_FEMALE_PUNISHMENT_CN" name="P_FEMALE_PUNISHMENT_CN"></textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">有无不良嗜好</td>
				    <td colspan="2">
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<textarea style="height: 30px;width: 50%;" id="P_MALE_ILLEGALACT_CN" name="P_MALE_ILLEGALACT_CN"></textarea>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<textarea style="height: 30px;width: 50%;" id="P_FEMALE_ILLEGALACT_CN" name="P_FEMALE_ILLEGALACT_CN"></textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">宗教信仰</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_RELIGION_CN" prefix="P_" type="String" formTitle="男收养人宗教信仰" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_RELIGION_CN" prefix="P_" type="String" formTitle="女收养人宗教信仰" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">货币单位</td>
				    <td colspan="5">
				    	<BZ:select field="CURRENCY" formTitle="货币单位"></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">年收入</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_YEAR_INCOME" prefix="P_" type="String" formTitle="男收养人年收入" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_YEAR_INCOME" prefix="P_" type="String" formTitle="女收养人年收入" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">前婚次数</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_MARRY_TIMES" prefix="P_" type="String" formTitle="男收养人前婚次数" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_MARRY_TIMES" prefix="P_" type="String" formTitle="女收养人前婚次数" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">婚姻状况</td>
				    <td>
				    	<BZ:select field="MARRY_CONDITION" formTitle="婚姻状况" isCode="true" codeName="ADOPTER_MARRYCOND"></BZ:select>
				    </td>
				    <td class="edit-data-title">结婚日期</td>
				    <td width="20%">
				    	<BZ:input field="MARRY_DATE" prefix="P_" type="date" onchange="calMarrayYear(this,N_MARRY_TIME);" formTitle="结婚日期" defaultValue="" style="width:165px;"/>
				    </td>
				    <td class="edit-data-title" >婚姻时长</td>
				    <td width="12%">
				    	<BZ:input field="MARRY_TIME" prefix="N_" id="N_MARRY_TIME" type="String" formTitle="婚姻时长" defaultValue="" disabled="true" size="10"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭总资产</td>
				    <td>
				    	<BZ:input field="TOTAL_ASSET" prefix="P_" id="P_TOTAL_ASSET" type="String" formTitle="家庭总资产" defaultValue="" onchange="calNetworth(this,P_TOTAL_DEBT,N_ASSET);"/>
				    </td>
				    <td class="edit-data-title">家庭总债务</td>
				    <td>
				    	<BZ:input field="TOTAL_DEBT" prefix="P_" id="P_TOTAL_DEBT" type="String" formTitle="家庭总债务" defaultValue="" onchange="calNetworth(this,P_TOTAL_ASSET,N_ASSET);"/>
				    </td>
				    <td class="edit-data-title">家庭净资产</td>
				    <td>
				    	<BZ:input field="ASSET" prefix="N_" id="N_ASSET" type="String" formTitle="家庭净资产" defaultValue="" disabled="true" size="10"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">18周岁以下子女数量</td>
				    <td>
				    	<BZ:input field="UNDERAGE_NUM" prefix="P_" type="String" formTitle="18周岁以下子女数量" defaultValue=""/>
				    </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">子女数量及情况</td>
				    <td colspan="5">
				    	<textarea title="子女数量及情况" style="height: 30px;width: 97%;" name="P_CHILD_CONDITION_CN" id="P_CHILD_CONDITION_CN">
				    		<BZ:dataValue field="CHILD_CONDITION_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭住址</td>
				    <td colspan="5">
				    	<BZ:input field="ADDRESS" prefix="P_" type="String" formTitle="家庭住址" defaultValue="" style="width:97%;"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">收养要求</td>
				    <td colspan="5">
				    	<BZ:input field="ADOPT_REQUEST_CN" prefix="P_" type="String" formTitle="收养要求" defaultValue="" style="width:97%;"/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">家庭调查及组织意见信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">完成家调组织名称</td>
				    <td>
				    	<BZ:select field="HOMESTUDY_ORG_NAME" formTitle="完成家调组织名称" isCode="true" codeName="GJSY" defaultValue="" width="165"></BZ:select>
				    </td>
				    <td class="edit-data-title">家庭报告完成日期</td>
				    <td>
				    	<BZ:input field="FINISH_DATE" prefix="P_" type="date" formTitle="家庭报告完成日期" defaultValue="" style="width:165px;"/>
				    </td>
				    <td class="edit-data-title">会见次数</td>
				    <td>
				    	<BZ:input field="TERVIEW_TIMES" prefix="P_" type="String" formTitle="会见次数" defaultValue="" size="5"/>次
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">推荐信</td>
				    <td>
				    	<BZ:input field="RECOMMENDATION_NUM" prefix="P_" type="String" formTitle="推荐信" defaultValue="" size="5"/>封
				    </td>
				    <td class="edit-data-title">心理评估报告</td>
				    <td>
				    	<BZ:select prefix="P_" field="HEART_REPORT" formTitle="心理评估报告" isCode="true" codeName="ADOPTER_HEART_REPORT"></BZ:select>
				    </td>
				    <td class="edit-data-title">收养动机</td>
				    <td>
				    	<BZ:select prefix="P_" field="ADOPT_MOTIVATION" formTitle="收养动机" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION"></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
				    <td>
				    	<BZ:select prefix="P_" field="CHILDREN_ABOVE" isCode="true" formTitle="家中10周岁及以上孩子对收养的意见" codeName="ADOPTER_CHILDREN_ABOVE"></BZ:select>
				    </td>
				    <td class="edit-data-title">有无指定监护人</td>
				    <td>
				    	<BZ:radio field="IS_FORMULATE" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="IS_FORMULATE" value="1" formTitle=""></BZ:radio>有
				    </td>
				    <td class="edit-data-title">不遗弃不虐待声明</td>
				    <td>
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="1" formTitle=""></BZ:radio>有
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">抚育计划</td>
				    <td colspan="2">
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="1" formTitle=""></BZ:radio>有
				    </td>
				    <td class="edit-data-title">收养前准备</td>
				    <td colspan="2">
				    	<BZ:radio field="ADOPT_PREPARE" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="ADOPT_PREPARE" value="1" formTitle=""></BZ:radio>有
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">风险意识</td>
				    <td colspan="2">
				    	<BZ:radio field="RISK_AWARENESS" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="RISK_AWARENESS" value="1" formTitle=""></BZ:radio>有
				    </td>
				    <td class="edit-data-title">同意递交安置后报告声明</td>
				    <td colspan="2">
				    	<BZ:radio field="IS_SUBMIT_REPORT" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="IS_SUBMIT_REPORT" value="1" formTitle=""></BZ:radio>有
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家中有无其他人同住</td>
				    <td colspan="2">
				    	<BZ:radio field="IS_FAMILY_OTHERS_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="IS_FAMILY_OTHERS_FLAG" value="1" formTitle=""></BZ:radio>有
				    </td>
				    <td class="edit-data-title">家中其他人同住说明</td>
				    <td colspan="2">
				    	<textarea title="家中其他人同住说明" style="height: 20px;width: 90%;" name="P_IS_FAMILY_OTHERS_CN" id="P_IS_FAMILY_OTHERS_CN">
				    		<BZ:dataValue field="IS_FAMILY_OTHERS_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">育儿经验</td>
				    <td colspan="2">
				    	<BZ:radio field="PARENTING" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="PARENTING" value="1" formTitle=""></BZ:radio>有
				    </td>
				    <td class="edit-data-title">社工意见</td>
				    <td colspan="2">
				    	<BZ:select field="SOCIALWORKER" formTitle="社工意见">
				    		<BZ:option value="支持">支持</BZ:option>
				    		<BZ:option value="不支持">不支持</BZ:option>
				    		<BZ:option value="保留意见">保留意见</BZ:option>
				    	</BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭需说明的其他事项</td>
				    <td colspan="5">
				    	<textarea title="家庭需说明的其他事项" style="height: 20px;width: 97%;" name="P_REMARK_CN" id="P_REMARK_CN">
				    		<BZ:dataValue field="REMARK_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">政府批准信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">批准日期</td>
				    <td>
				    	<BZ:input field="GOVERN_DATE" prefix="P_" type="date" formTitle="批准日期" defaultValue="" style="width:165px;"/>
				    </td>
				    <td class="edit-data-title">有效期限</td>
				    <td>
				    	<select id="" name="" style="width:80px;">
				    		<option>有效期限</option>
				    		<option>长期</option>
				    	</select>
				    	<BZ:input field="VALID_PERIOD" prefix="P_" type="date" formTitle="有效期限" defaultValue="" style="width:100px;"/>
				    </td>
				    <td class="edit-data-title">批准儿童数量</td>
				    <td>
				    	<BZ:input field="APPROVE_CHILD_NUM" prefix="P_" type="String" formTitle="批准儿童数量" defaultValue="" size="5"/>个
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">收养儿童年龄</td>
				    <td>
				    	<BZ:input field="AGE_FLOOR" prefix="P_" type="String" formTitle="收养儿童年龄" defaultValue="" size="5"/>
				    	岁-
				    	<BZ:input field="AGE_UPPER" prefix="P_" type="String" formTitle="收养儿童年龄" defaultValue="" size="5"/>
				    	岁
				    </td>
				    <td class="edit-data-title">收养儿童性别</td>
				    <td>
				    	<BZ:select field="CHILDREN_SEX" formTitle="收养儿童性别" isCode="true" codeName="ADOPTER_CHILDREN_SEX"></BZ:select>
				    </td>
				    <td class="edit-data-title">收养儿童健康状况</td>
				    <td>
				    	<BZ:select field="CHILDREN_HEALTH_CN" formTitle="收养儿童健康状况" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH"></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">附件信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">跨国收养申请书</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">出生证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">婚姻状况证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">职业证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">经济收入及财政状况证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">身体健康检查证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">有无受过刑事处罚证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">家庭调查报告</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">心理评估报告</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">收养申请人所在国主管机关同意其跨国收养子女的证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭生活照片</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">推荐信</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				</table>
				
				<!-- 如果有预批信息 -->
				
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">预批锁定儿童基本信息</th>
				  </tr>
				  <tr>
				    <td width="19%" class="edit-data-title">省份</td>
				    <td width="26%">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td width="14%" class="edit-data-title">福利院</td>
				    <td colspan="2">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">姓名</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">性别</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">出生日期</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">特别关注</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">病残种类</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">病残程度</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">文件递交期限</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">有无同胞</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">病残诊断</td>
				    <td colspan="5"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">预批审核信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核级别</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核时间</td>
				    <td width="15%">&nbsp;</td>
				    <td class="edit-data-title" width="14%">审核人</td>
				    <td width="12%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核结果</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核级别</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核时间</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核人</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核结果</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核级别</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核时间</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核人</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核结果</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
			</div>
			<!-- 英文 -->
			<div id="tab2">
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">收养人基本信息</th>
				  </tr>
				  <tr>
				    <th width="16%">&nbsp;</th>
				    <th colspan="2">男收养人</th>
				    <th colspan="3">女收养人</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">外文姓名</td>
				    <td width="23%">
				    	<BZ:dataValue field="MALE_NAME" defaultValue=""/>
				    </td>
				    <td width="12%" rowspan="5">&nbsp;</td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
				    </td>
				    <td width="12%" rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">出生日期</td>
				    <td>
				    	<BZ:dataValue field="MALE_BIRTHDAY" type="date" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_BIRTHDAY" type="date" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">年龄</td>
				    <td>
				    	<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">国籍</td>
				    <td>
				    	<BZ:dataValue field="MALE_NATION" codeName="GJSY" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_NATION" codeName="GJSY" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">护照号码</td>
				    <td>
				    	<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">受教育程度</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">职业</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_JOB_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="MALE_JOB_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">健康状况</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
				    	<BZ:dataValue field="MALE_HEALTH_CONTENT_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue=""/>
				    	<BZ:dataValue field="FEMALE_HEALTH_CONTENT_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">身高</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_HEIGHT" defaultValue=""/>厘米
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/>厘米
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">体重</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_WEIGHT" defaultValue=""/>
				    	千克
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/>
				    	千克
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">体重指数</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_BMI" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">违法行为及刑事处罚</td>
				    <td colspan="2">
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">有无不良嗜好</td>
				    <td colspan="2">
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>无
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>有
				    	<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">宗教信仰</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_RELIGION_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">货币单位</td>
				    <td colspan="5">
				    	<BZ:dataValue field="CURRENCY" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">年收入</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_YEAR_INCOME"  defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">前婚次数</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">婚姻状况</td>
				    <td>
				    	<BZ:dataValue field="MARRY_CONDITION" defaultValue="" codeName="ADOPTER_MARRYCOND"/>
				    </td>
				    <td class="edit-data-title">结婚日期</td>
				    <td width="20%">
				    	<BZ:dataValue field="MARRY_DATE" defaultValue="" type="date" />
				    </td>
				    <td class="edit-data-title" >婚姻时长</td>
				    <td width="12%">
				    	<BZ:dataValue field="MARRY_TIME" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭总资产</td>
				    <td>
				    	<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">家庭总债务</td>
				    <td>
				    	<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">家庭净资产</td>
				    <td>
				    	<BZ:dataValue field="ASSET" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">18周岁以下子女数量</td>
				    <td>
				    	<BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/>
				    </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">子女数量及情况</td>
				    <td colspan="5">
				    	<BZ:dataValue field="CHILD_CONDITION_CN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭住址</td>
				    <td colspan="5">
				    	<BZ:dataValue field="ADDRESS" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">收养要求</td>
				    <td colspan="5">
				    	<BZ:dataValue field="ADOPT_REQUEST_EN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">家庭调查及组织意见信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">完成家调组织名称</td>
				    <td>
				    	<BZ:dataValue field="HOMESTUDY_ORG_NAME" onlyValue="true" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">家庭报告完成日期</td>
				    <td>
				    	<BZ:dataValue field="FINISH_DATE" onlyValue="true" defaultValue="" type="date"/>
				    </td>
				    <td class="edit-data-title">会见次数</td>
				    <td>
				    	<BZ:dataValue field="TERVIEW_TIMES" onlyValue="true" defaultValue=""/>次
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">推荐信</td>
				    <td>
				    	<BZ:dataValue field="RECOMMENDATION_NUM" onlyValue="true" defaultValue=""/>
				    	封
				    </td>
				    <td class="edit-data-title">心理评估报告</td>
				    <td>
				    	<BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_HEART_REPORT" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">收养动机</td>
				    <td>
				    	<BZ:dataValue field="ADOPT_MOTIVATION" codeName="ADOPTER_ADOPT_MOTIVATION" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家中10周岁及以上孩子对收养的意见</td>
				    <td>
				    	<BZ:dataValue field="CHILDREN_ABOVE" codeName="ADOPTER_CHILDREN_ABOVE" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">有无指定监护人</td>
				    <td>
				    	<BZ:dataValue field="IS_FORMULATE" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">不遗弃不虐待声明</td>
				    <td>
				    	<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">抚育计划</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">收养前准备</td>
				    <td colspan="2">
				    	<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">风险意识</td>
				    <td colspan="2">
				    	<BZ:dataValue field="RISK_AWARENESS" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">同意递交安置后报告声明</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家中有无其他人同住</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">家中其他人同住说明</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_FAMILY_OTHERS_EN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">育儿经验</td>
				    <td colspan="2">
				    	<BZ:dataValue field="PARENTING" checkValue="0=无;1=有" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">社工意见</td>
				    <td colspan="2">
				    	<BZ:dataValue field="SOCIALWORKER" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭需说明的其他事项</td>
				    <td colspan="5">
				    	<BZ:dataValue field="REMARK_EN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">政府批准信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">批准日期</td>
				    <td>
				    	<BZ:dataValue field="GOVERN_DATE" type="date" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">有效期限</td>
				    <td>
				    	<BZ:dataValue field="VALID_PERIOD" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">批准儿童数量</td>
				    <td>
				    	<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">收养儿童年龄</td>
				    <td>
				    	<BZ:dataValue field="AGE_FLOOR" defaultValue=""/>
				    	岁-
				    	<BZ:dataValue field="AGE_UPPER" defaultValue=""/>
				    	岁
				    </td>
				    <td class="edit-data-title">收养儿童性别</td>
				    <td>
				    	<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
				    </td>
				    <td class="edit-data-title">收养儿童健康状况</td>
				    <td>
				    	<BZ:dataValue field="CHILDREN_HEALTH_EN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH"/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">附件信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">跨国收养申请书</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">出生证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">婚姻状况证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">职业证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">经济收入及财政状况证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">身体健康检查证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">有无受过刑事处罚证明</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">家庭调查报告</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">心理评估报告</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">收养申请人所在国主管机关同意其跨国收养子女的证明</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">家庭生活照片</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">推荐信</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				</table>
				
				<!-- 如果有预批信息 -->
				
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">预批锁定儿童基本信息</th>
				  </tr>
				  <tr>
				    <td width="19%" class="edit-data-title">省份</td>
				    <td width="26%">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td width="14%" class="edit-data-title">福利院</td>
				    <td colspan="2">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">姓名</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">性别</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">出生日期</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">特别关注</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">病残种类</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">病残程度</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">文件递交期限</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">有无同胞</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">病残诊断</td>
				    <td colspan="5"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">预批审核信息</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核级别</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核时间</td>
				    <td width="15%">&nbsp;</td>
				    <td class="edit-data-title" width="14%">审核人</td>
				    <td width="12%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核结果</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核级别</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核时间</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核人</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核结果</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核级别</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核时间</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核人</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">审核结果</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">审核意见</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
			</div>
			<div id="tab3">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab4">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<div id="tab5">
				<h2>CSS Styles for these tabs</h2>
			</div>
			<!-- 翻译记录 -->
			<div id="tab6">
				<%-- <table class="table table-striped table-bordered table-hover dataTable" adsorb="both" id="sample-table">
					<thead>
						<tr>
							<th style="width: 10%; text-align: center">
								<div class="sorting">序号</div>
							</th>
							<th style="width: 15%; text-align: center">
								<div class="sorting">翻译单位</div>
							</th>
							<th style="width: 30%; text-align: center">
								<div class="sorting">送翻时间</div>
							</th>
							<th style="width: 15%; text-align: center">
								<div class="sorting">翻译人</div>
							</th>
							<th style="width: 30%; text-align: center">
								<div class="sorting">完成时间</div>
							</th>
							
						</tr>
					</thead>
					<tbody>
						<BZ:for property="traList">
							<tr class="odd">
								<td><BZ:i/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="MALE_BIRTHDAY" defaultValue="" type="Date"/></td>
								<td><BZ:data field="FEMALE_BIRTHDAY" defaultValue="" type="Date"/></td>
							</tr>
						</BZ:for>
					</tbody>
				</table> --%>
			</div>
		</div>
	</div>
	<!-- 审核信息 -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					审核情况
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<!-- 编辑区域 开始 -->
				<table class="bz-edit-data-table" border="0">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr>
						<td class="bz-edit-data-title">公认证情况</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="ACCEPTED_CARD" value="1" prefix="P_" formTitle="" defaultChecked="true"></BZ:radio>齐全
				    		<BZ:radio field="ACCEPTED_CARD" value="2" prefix="P_" formTitle=""></BZ:radio>不齐全
						</td>
						<td class="bz-edit-data-title">翻译单位</td>
						<td class="bz-edit-data-value">
							<BZ:select field="TRANSLATION_COMPANY" formTitle="翻译单位" prefix="P_">
								<BZ:option value="北翻">北翻</BZ:option>
								<BZ:option value="爱之桥">爱之桥</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title">翻译质量</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="TRANSLATION_QUALITY" onclick="fanyizhiliangClick();" prefix="P_" value="1" formTitle="翻译质量" defaultChecked="true"></BZ:radio>合格
				    		<BZ:radio field="TRANSLATION_QUALITY" onclick="fanyizhiliangClick();" prefix="P_" value="2" formTitle="翻译质量"></BZ:radio>不合格
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核结果</td>
						<td class="bz-edit-data-value">
							<BZ:select field="AUD_STATE" formTitle="审核结果">
								<BZ:option value="-1">-请选择-</BZ:option>
								<BZ:option value="上报">上报</BZ:option>
								<BZ:option value="通过">通过</BZ:option>
								<BZ:option value="补充文件">补充文件</BZ:option>
								<BZ:option value="补充文件翻译">补充文件翻译</BZ:option>
								<BZ:option value="重新翻译">重新翻译</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title">审核人</td>
						<td class="bz-edit-data-value">
							<BZ:input field="RED" defaultValue="" disabled="disabled" prefix="AUD_"/>					
						</td>
						<td class="bz-edit-data-title">审核日期</td>
						<td class="bz-edit-data-value">
							<BZ:input field="RED" defaultValue="" type="date" prefix="AUD_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">审核意见</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 30px;width: 97%;" name="AUD_YJIAN"></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">备注</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 30px;width: 97%;" name="AUD_YJIAN"></textarea>
						</td>
					</tr>
					<tr id="fanyiNohege">
						<td class="bz-edit-data-title">翻译不合格原因</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 30px;width: 97%;" name="AUD_YJIAN"></textarea>
						</td>
					</tr>
				</table>
				<!-- 编辑区域 结束 -->
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<a href="reporter_files_list.html" >
				<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="打印" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>7
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
