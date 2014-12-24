<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>��ͥ�ļ���˫�ף����������</title>
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
		      /*��������*/
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
		      /*Ů������*/
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
	    	var lbTokg = 0.4535924;       // ��TOǧ��
	    	var kgTolb = 2.2046226;       // ǧ��TO��
	    	var feetToinche = 12;         // Ӣ��TOӢ��
	    	var feetTocm = 30.48;         // Ӣ��To����
	    	var incheTofeet = 0.0833333;  // Ӣ��TOӢ��
	    	var incheTocm = 2.54;         // Ӣ��To����
	    	var cmToinche = 0.3937008;    // ����ToӢ��
	    	var cmTofeet = 0.0328084;     // ����ToӢ��
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
	     * ����һλС����
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
	     * ����ָ�� �� ����/�����*��ߣ�
	     */
	    function calBmi(_weightObj,_heightObj,_bmiObj){
	    	var _weightVal = $(_weightObj).val();
	    	var _heightVal =$(_heightObj).val();
	    	if(null != _weightVal && ""!=_weightVal && null != _heightVal && "" != _heightVal){
	    		$(_bmiObj).val(Math.round(_weightVal/((_heightVal*_heightVal)/10000)*10)/10);
	    	}
	    }
	    /*
	     * �����鼸��
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
	     * ���㾻�ʲ�
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
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action" desc="��ť��">
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="����Ԥ��" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="��ӡ" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<!-- �༭���� ��ʼ -->
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
						<td class="bz-edit-data-title">������֯(CN)</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������֯(EN)</td>
						<td class="bz-edit-data-value" colspan="5"> 
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���ı��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" codeName="SYLX" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ƿ�Լ����</td>
						<td class="bz-edit-data-value"><BZ:dataValue field="IS_CONVENTION_ADOPT" checkValue="0=��;1=��" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">֮ǰ���ı��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ƿ�Ԥ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_ALERT" checkValue="0=��;1=��" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ƿ�ת��֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_CHANGE_ORG" checkValue="0=��;1=��" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ԭ������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORIGINAL_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͣ״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="IS_PAUSE" checkValue="0=δ��ͣ;1=����ͣ" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ͣԭ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAUSE_REASON" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ĩ���ļ�����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUPPLY_STATE" checkValue="0=δ����;1=�Ѳ���" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" checkValue="0=��ȷ��;1=��ȷ��;2=������;3=�Ѵ���" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<div id="tab-container" class='tab-container'>
		<ul class='etabs'>
			<li class='tab'><a href="#tab1">������Ϣ(����)</a></li>
			<li class='tab'><a href="#tab2">������Ϣ(Ӣ��)</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab3">��˼�¼</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab4">�����¼</a></li>
			<li class='tab'><a href="<%=path%>/ffs/jbraudit/ajaxaction.action #ajaxtab" data-target="#tab5">�޸ļ�¼</a></li>
			<li class='tab'><a href="#tab6">�����¼</a></li>
		</ul>
		<div class='panel-container'>
			<div id="tab1">
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">�����˻�����Ϣ</th>
				  </tr>
				  <tr>
				    <th width="16%">&nbsp;</th>
				    <th colspan="2">��������</th>
				    <th colspan="3">Ů������</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td width="23%">
				    	<BZ:input field="MALE_NAME" prefix="P_" type="String" notnull="������������������" formTitle="������������" defaultValue=""/>
				    </td>
				    <td width="12%" rowspan="5">&nbsp;</td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_NAME" prefix="P_" type="String" notnull="������Ů����������" formTitle="Ů����������" defaultValue="" />
				    </td>
				    <td width="12%" rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td>
				    	<BZ:input field="MALE_BIRTHDAY" prefix="P_" type="date" formTitle="�г�������" defaultValue="" style="width:165px;"/>
				    </td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_BIRTHDAY" prefix="P_" type="date" formTitle="Ů��������" defaultValue="" style="width:165px;"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td>
				    	<BZ:input field="FEMALE_BIRTHDAY" prefix="P_" type="String" formTitle="������������" defaultValue="" disabled="true" size="10"/>
				    </td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_BIRTHDAY" prefix="P_" type="String" formTitle="Ů����������" defaultValue="" disabled="ture" size="10"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td>
				    	<BZ:select field="MALE_NATION" formTitle="����" codeName="GJSY" isCode="true" defaultValue="" width="165"></BZ:select>
				    </td>
				    <td colspan="2">
				    	<BZ:select field="FEMALE_NATION" formTitle="����" codeName="GJSY" isCode="true"  defaultValue=""></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���պ���</td>
				    <td>
				    	<BZ:input field="MALE_PASSPORT_NO" prefix="P_" type="String" formTitle="�������˻��պ���" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:input field="FEMALE_PASSPORT_NO" prefix="P_" type="String" formTitle="Ů�����˻��պ���" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�ܽ����̶�</td>
				    <td colspan="2">
				    	<BZ:select field="MALE_EDUCATION" formTitle="���������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue=""></BZ:select>
				    </td>
				    <td colspan="3">
				    	<BZ:select field="FEMALE_EDUCATION" formTitle="Ů�������ܽ����̶�" isCode="true"  codeName="ADOPTER_EDU" defaultValue=""></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">ְҵ</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_JOB_CN" prefix="P_" type="String" formTitle="��������ְҵ" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_JOB_CN" prefix="P_" type="String" formTitle="Ů������ְҵ" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����״��</td>
				    <td colspan="2">
				    	<BZ:select width="100px" field="MALE_HEALTH" prefix="P_" formTitle="�������˽���״��" isCode="true"  codeName="ADOPTER_HEALTH" defaultValue=""></BZ:select>
				    	<textarea style="height: 20px;width: 60%;" name="P_MALE_HEALTH_CONTENT_CN" id="P_MALE_HEALTH_CONTENT_CN">
				    		<BZ:dataValue field="MALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				    <td colspan="3">
				    	<BZ:select width="100px" field="FEMALE_HEALTH" prefix="P_" formTitle="Ů�����˽���״��"  isCode="true" codeName="ADOPTER_HEALTH" defaultValue=""></BZ:select>
				    	<textarea style="height: 20px;width: 60%;" name="P_FEMALE_HEALTH_CONTENT_CN" id="P_FEMALE_HEALTH_CONTENT_CN">
				    		<BZ:dataValue field="FEMALE_HEALTH_CONTENT_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���</td>
				    <td colspan="2">
				    	<input type="text" id="yingchi_m" size="4"/>Ӣ��<input type="text" id="yingcun_m" size="4"/>Ӣ��
				    	<BZ:input field="MALE_HEIGHT" prefix="P_"  id="P_MALE_HEIGHT" type="String" formTitle="�����������" defaultValue="" size="5"/>
				    	����
				    </td>
				    <td colspan="3">
				    	<input type="text" id="yingchi_w" size="4"/>Ӣ��<input type="text" id="yingcun_w" size="4"/>Ӣ��
				    	<BZ:input field="FEMALE_HEIGHT" prefix="P_" id="P_FEMALE_HEIGHT" type="String" formTitle="Ů���������" defaultValue="" size="5"/>
				    	����
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td colspan="2">
				    	<input type="text" id="tizhong_m" name="tizhong_m" size="4"/>��
				    	<BZ:input field="MALE_WEIGHT" prefix="P_" type="String" formTitle="������������" defaultValue="" size="5" id="P_MALE_WEIGHT"/>
				    	ǧ��
				    </td>
				    <td colspan="3">
				    	<input type="text" id="tizhong_w" size="4" onchange="lbToKg(this,P_FEMALE_WEIGHT);"/>��
				    	<BZ:input field="FEMALE_WEIGHT" prefix="P_" id="P_FEMALE_WEIGHT" type="String" formTitle="������������" defaultValue="" size="5"/>
				    	ǧ��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����ָ��</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_BMI" prefix="P_" type="String" formTitle="������������ָ��" defaultValue="" disabled="true" id="P_MALE_BMI"/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_BMI" prefix="P_" type="String" formTitle="������������ָ��" defaultValue="" disabled="true" id="P_FEMALE_BMI"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">Υ����Ϊ�����´���</td>
				    <td colspan="2">
				    	<%-- <BZ:radios prefix="P_" field="MALE_PUNISHMENT_FLAG" formTitle="��������Υ����Ϊ�����´���" codeValues="0=��;1=��"/> --%>
				    	
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	
				    	<textarea style="height: 30px;width: 50%;" id="P_MALE_PUNISHMENT_CN" name="P_MALE_PUNISHMENT_CN"></textarea>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<textarea style="height: 30px;width: 50%;" id="P_FEMALE_PUNISHMENT_CN" name="P_FEMALE_PUNISHMENT_CN"></textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���޲����Ⱥ�</td>
				    <td colspan="2">
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<textarea style="height: 30px;width: 50%;" id="P_MALE_ILLEGALACT_CN" name="P_MALE_ILLEGALACT_CN"></textarea>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<textarea style="height: 30px;width: 50%;" id="P_FEMALE_ILLEGALACT_CN" name="P_FEMALE_ILLEGALACT_CN"></textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�ڽ�����</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_RELIGION_CN" prefix="P_" type="String" formTitle="���������ڽ�����" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_RELIGION_CN" prefix="P_" type="String" formTitle="Ů�������ڽ�����" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���ҵ�λ</td>
				    <td colspan="5">
				    	<BZ:select field="CURRENCY" formTitle="���ҵ�λ"></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_YEAR_INCOME" prefix="P_" type="String" formTitle="��������������" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_YEAR_INCOME" prefix="P_" type="String" formTitle="Ů������������" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">ǰ�����</td>
				    <td colspan="2">
				    	<BZ:input field="MALE_MARRY_TIMES" prefix="P_" type="String" formTitle="��������ǰ�����" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:input field="FEMALE_MARRY_TIMES" prefix="P_" type="String" formTitle="Ů������ǰ�����" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����״��</td>
				    <td>
				    	<BZ:select field="MARRY_CONDITION" formTitle="����״��" isCode="true" codeName="ADOPTER_MARRYCOND"></BZ:select>
				    </td>
				    <td class="edit-data-title">�������</td>
				    <td width="20%">
				    	<BZ:input field="MARRY_DATE" prefix="P_" type="date" onchange="calMarrayYear(this,N_MARRY_TIME);" formTitle="�������" defaultValue="" style="width:165px;"/>
				    </td>
				    <td class="edit-data-title" >����ʱ��</td>
				    <td width="12%">
				    	<BZ:input field="MARRY_TIME" prefix="N_" id="N_MARRY_TIME" type="String" formTitle="����ʱ��" defaultValue="" disabled="true" size="10"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥ���ʲ�</td>
				    <td>
				    	<BZ:input field="TOTAL_ASSET" prefix="P_" id="P_TOTAL_ASSET" type="String" formTitle="��ͥ���ʲ�" defaultValue="" onchange="calNetworth(this,P_TOTAL_DEBT,N_ASSET);"/>
				    </td>
				    <td class="edit-data-title">��ͥ��ծ��</td>
				    <td>
				    	<BZ:input field="TOTAL_DEBT" prefix="P_" id="P_TOTAL_DEBT" type="String" formTitle="��ͥ��ծ��" defaultValue="" onchange="calNetworth(this,P_TOTAL_ASSET,N_ASSET);"/>
				    </td>
				    <td class="edit-data-title">��ͥ���ʲ�</td>
				    <td>
				    	<BZ:input field="ASSET" prefix="N_" id="N_ASSET" type="String" formTitle="��ͥ���ʲ�" defaultValue="" disabled="true" size="10"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">18����������Ů����</td>
				    <td>
				    	<BZ:input field="UNDERAGE_NUM" prefix="P_" type="String" formTitle="18����������Ů����" defaultValue=""/>
				    </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��Ů���������</td>
				    <td colspan="5">
				    	<textarea title="��Ů���������" style="height: 30px;width: 97%;" name="P_CHILD_CONDITION_CN" id="P_CHILD_CONDITION_CN">
				    		<BZ:dataValue field="CHILD_CONDITION_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥסַ</td>
				    <td colspan="5">
				    	<BZ:input field="ADDRESS" prefix="P_" type="String" formTitle="��ͥסַ" defaultValue="" style="width:97%;"/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����Ҫ��</td>
				    <td colspan="5">
				    	<BZ:input field="ADOPT_REQUEST_CN" prefix="P_" type="String" formTitle="����Ҫ��" defaultValue="" style="width:97%;"/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">��ͥ���鼰��֯�����Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ɼҵ���֯����</td>
				    <td>
				    	<BZ:select field="HOMESTUDY_ORG_NAME" formTitle="��ɼҵ���֯����" isCode="true" codeName="GJSY" defaultValue="" width="165"></BZ:select>
				    </td>
				    <td class="edit-data-title">��ͥ�����������</td>
				    <td>
				    	<BZ:input field="FINISH_DATE" prefix="P_" type="date" formTitle="��ͥ�����������" defaultValue="" style="width:165px;"/>
				    </td>
				    <td class="edit-data-title">�������</td>
				    <td>
				    	<BZ:input field="TERVIEW_TIMES" prefix="P_" type="String" formTitle="�������" defaultValue="" size="5"/>��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�Ƽ���</td>
				    <td>
				    	<BZ:input field="RECOMMENDATION_NUM" prefix="P_" type="String" formTitle="�Ƽ���" defaultValue="" size="5"/>��
				    </td>
				    <td class="edit-data-title">������������</td>
				    <td>
				    	<BZ:select prefix="P_" field="HEART_REPORT" formTitle="������������" isCode="true" codeName="ADOPTER_HEART_REPORT"></BZ:select>
				    </td>
				    <td class="edit-data-title">��������</td>
				    <td>
				    	<BZ:select prefix="P_" field="ADOPT_MOTIVATION" formTitle="��������" isCode="true" codeName="ADOPTER_ADOPT_MOTIVATION"></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
				    <td>
				    	<BZ:select prefix="P_" field="CHILDREN_ABOVE" isCode="true" formTitle="����10���꼰���Ϻ��Ӷ����������" codeName="ADOPTER_CHILDREN_ABOVE"></BZ:select>
				    </td>
				    <td class="edit-data-title">����ָ���໤��</td>
				    <td>
				    	<BZ:radio field="IS_FORMULATE" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="IS_FORMULATE" value="1" formTitle=""></BZ:radio>��
				    </td>
				    <td class="edit-data-title">��������Ű������</td>
				    <td>
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="1" formTitle=""></BZ:radio>��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�����ƻ�</td>
				    <td colspan="2">
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="IS_ABUSE_ABANDON" value="1" formTitle=""></BZ:radio>��
				    </td>
				    <td class="edit-data-title">����ǰ׼��</td>
				    <td colspan="2">
				    	<BZ:radio field="ADOPT_PREPARE" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="ADOPT_PREPARE" value="1" formTitle=""></BZ:radio>��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������ʶ</td>
				    <td colspan="2">
				    	<BZ:radio field="RISK_AWARENESS" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="RISK_AWARENESS" value="1" formTitle=""></BZ:radio>��
				    </td>
				    <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
				    <td colspan="2">
				    	<BZ:radio field="IS_SUBMIT_REPORT" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="IS_SUBMIT_REPORT" value="1" formTitle=""></BZ:radio>��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������������ͬס</td>
				    <td colspan="2">
				    	<BZ:radio field="IS_FAMILY_OTHERS_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="IS_FAMILY_OTHERS_FLAG" value="1" formTitle=""></BZ:radio>��
				    </td>
				    <td class="edit-data-title">����������ͬס˵��</td>
				    <td colspan="2">
				    	<textarea title="����������ͬס˵��" style="height: 20px;width: 90%;" name="P_IS_FAMILY_OTHERS_CN" id="P_IS_FAMILY_OTHERS_CN">
				    		<BZ:dataValue field="IS_FAMILY_OTHERS_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td colspan="2">
				    	<BZ:radio field="PARENTING" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="PARENTING" value="1" formTitle=""></BZ:radio>��
				    </td>
				    <td class="edit-data-title">�繤���</td>
				    <td colspan="2">
				    	<BZ:select field="SOCIALWORKER" formTitle="�繤���">
				    		<BZ:option value="֧��">֧��</BZ:option>
				    		<BZ:option value="��֧��">��֧��</BZ:option>
				    		<BZ:option value="�������">�������</BZ:option>
				    	</BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥ��˵������������</td>
				    <td colspan="5">
				    	<textarea title="��ͥ��˵������������" style="height: 20px;width: 97%;" name="P_REMARK_CN" id="P_REMARK_CN">
				    		<BZ:dataValue field="REMARK_CN" onlyValue="true" defaultValue=""/>
				    	</textarea>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">������׼��Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��׼����</td>
				    <td>
				    	<BZ:input field="GOVERN_DATE" prefix="P_" type="date" formTitle="��׼����" defaultValue="" style="width:165px;"/>
				    </td>
				    <td class="edit-data-title">��Ч����</td>
				    <td>
				    	<select id="" name="" style="width:80px;">
				    		<option>��Ч����</option>
				    		<option>����</option>
				    	</select>
				    	<BZ:input field="VALID_PERIOD" prefix="P_" type="date" formTitle="��Ч����" defaultValue="" style="width:100px;"/>
				    </td>
				    <td class="edit-data-title">��׼��ͯ����</td>
				    <td>
				    	<BZ:input field="APPROVE_CHILD_NUM" prefix="P_" type="String" formTitle="��׼��ͯ����" defaultValue="" size="5"/>��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������ͯ����</td>
				    <td>
				    	<BZ:input field="AGE_FLOOR" prefix="P_" type="String" formTitle="������ͯ����" defaultValue="" size="5"/>
				    	��-
				    	<BZ:input field="AGE_UPPER" prefix="P_" type="String" formTitle="������ͯ����" defaultValue="" size="5"/>
				    	��
				    </td>
				    <td class="edit-data-title">������ͯ�Ա�</td>
				    <td>
				    	<BZ:select field="CHILDREN_SEX" formTitle="������ͯ�Ա�" isCode="true" codeName="ADOPTER_CHILDREN_SEX"></BZ:select>
				    </td>
				    <td class="edit-data-title">������ͯ����״��</td>
				    <td>
				    	<BZ:select field="CHILDREN_HEALTH_CN" formTitle="������ͯ����״��" isCode="true" codeName="ADOPTER_CHILDREN_HEALTH"></BZ:select>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">������Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�������������</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">����֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����״��֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">ְҵ֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�������뼰����״��֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">���彡�����֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�����ܹ����´���֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">��ͥ���鱨��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������������</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">�������������ڹ����ܻ���ͬ������������Ů��֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥ������Ƭ</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">�Ƽ���</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				</table>
				
				<!-- �����Ԥ����Ϣ -->
				
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">Ԥ��������ͯ������Ϣ</th>
				  </tr>
				  <tr>
				    <td width="19%" class="edit-data-title">ʡ��</td>
				    <td width="26%">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td width="14%" class="edit-data-title">����Ժ</td>
				    <td colspan="2">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">�Ա�</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">�ر��ע</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">���г̶�</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�ļ��ݽ�����</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">����ͬ��</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�������</td>
				    <td colspan="5"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">Ԥ�������Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˼���</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">���ʱ��</td>
				    <td width="15%">&nbsp;</td>
				    <td class="edit-data-title" width="14%">�����</td>
				    <td width="12%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˽��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˼���</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">���ʱ��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">�����</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˽��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˼���</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">���ʱ��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">�����</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˽��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				</table>
			</div>
			<!-- Ӣ�� -->
			<div id="tab2">
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">�����˻�����Ϣ</th>
				  </tr>
				  <tr>
				    <th width="16%">&nbsp;</th>
				    <th colspan="2">��������</th>
				    <th colspan="3">Ů������</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
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
				    <td class="edit-data-title">��������</td>
				    <td>
				    	<BZ:dataValue field="MALE_BIRTHDAY" type="date" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_BIRTHDAY" type="date" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td>
				    	<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td>
				    	<BZ:dataValue field="MALE_NATION" codeName="GJSY" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_NATION" codeName="GJSY" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���պ���</td>
				    <td>
				    	<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/>
				    </td>
				    <td colspan="2">
				    	<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�ܽ����̶�</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">ְҵ</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_JOB_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="MALE_JOB_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����״��</td>
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
				    <td class="edit-data-title">���</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_HEIGHT" defaultValue=""/>����
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_HEIGHT" defaultValue=""/>����
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_WEIGHT" defaultValue=""/>
				    	ǧ��
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_WEIGHT" defaultValue=""/>
				    	ǧ��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����ָ��</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_BMI" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_BMI" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">Υ����Ϊ�����´���</td>
				    <td colspan="2">
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="MALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<BZ:dataValue field="MALE_PUNISHMENT_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<BZ:dataValue field="FEMALE_PUNISHMENT_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���޲����Ⱥ�</td>
				    <td colspan="2">
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="MALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<BZ:dataValue field="MALE_ILLEGALACT_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle=""></BZ:radio>��
				    	<BZ:radio field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle=""></BZ:radio>��
				    	<BZ:dataValue field="FEMALE_ILLEGALACT_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�ڽ�����</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_RELIGION_EN" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_RELIGION_EN" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">���ҵ�λ</td>
				    <td colspan="5">
				    	<BZ:dataValue field="CURRENCY" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_YEAR_INCOME"  defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">ǰ�����</td>
				    <td colspan="2">
				    	<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue=""/>
				    </td>
				    <td colspan="3">
				    	<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����״��</td>
				    <td>
				    	<BZ:dataValue field="MARRY_CONDITION" defaultValue="" codeName="ADOPTER_MARRYCOND"/>
				    </td>
				    <td class="edit-data-title">�������</td>
				    <td width="20%">
				    	<BZ:dataValue field="MARRY_DATE" defaultValue="" type="date" />
				    </td>
				    <td class="edit-data-title" >����ʱ��</td>
				    <td width="12%">
				    	<BZ:dataValue field="MARRY_TIME" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥ���ʲ�</td>
				    <td>
				    	<BZ:dataValue field="TOTAL_ASSET" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��ͥ��ծ��</td>
				    <td>
				    	<BZ:dataValue field="TOTAL_DEBT" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��ͥ���ʲ�</td>
				    <td>
				    	<BZ:dataValue field="ASSET" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">18����������Ů����</td>
				    <td>
				    	<BZ:dataValue field="UNDERAGE_NUM" defaultValue=""/>
				    </td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��Ů���������</td>
				    <td colspan="5">
				    	<BZ:dataValue field="CHILD_CONDITION_CN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥסַ</td>
				    <td colspan="5">
				    	<BZ:dataValue field="ADDRESS" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����Ҫ��</td>
				    <td colspan="5">
				    	<BZ:dataValue field="ADOPT_REQUEST_EN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">��ͥ���鼰��֯�����Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ɼҵ���֯����</td>
				    <td>
				    	<BZ:dataValue field="HOMESTUDY_ORG_NAME" onlyValue="true" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��ͥ�����������</td>
				    <td>
				    	<BZ:dataValue field="FINISH_DATE" onlyValue="true" defaultValue="" type="date"/>
				    </td>
				    <td class="edit-data-title">�������</td>
				    <td>
				    	<BZ:dataValue field="TERVIEW_TIMES" onlyValue="true" defaultValue=""/>��
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�Ƽ���</td>
				    <td>
				    	<BZ:dataValue field="RECOMMENDATION_NUM" onlyValue="true" defaultValue=""/>
				    	��
				    </td>
				    <td class="edit-data-title">������������</td>
				    <td>
				    	<BZ:dataValue field="HEART_REPORT" codeName="ADOPTER_HEART_REPORT" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��������</td>
				    <td>
				    	<BZ:dataValue field="ADOPT_MOTIVATION" codeName="ADOPTER_ADOPT_MOTIVATION" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����10���꼰���Ϻ��Ӷ����������</td>
				    <td>
				    	<BZ:dataValue field="CHILDREN_ABOVE" codeName="ADOPTER_CHILDREN_ABOVE" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">����ָ���໤��</td>
				    <td>
				    	<BZ:dataValue field="IS_FORMULATE" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��������Ű������</td>
				    <td>
				    	<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�����ƻ�</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_ABUSE_ABANDON" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">����ǰ׼��</td>
				    <td colspan="2">
				    	<BZ:dataValue field="ADOPT_PREPARE" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������ʶ</td>
				    <td colspan="2">
				    	<BZ:dataValue field="RISK_AWARENESS" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">ͬ��ݽ����ú󱨸�����</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_SUBMIT_REPORT" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������������ͬס</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_FAMILY_OTHERS_FLAG" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">����������ͬס˵��</td>
				    <td colspan="2">
				    	<BZ:dataValue field="IS_FAMILY_OTHERS_EN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td colspan="2">
				    	<BZ:dataValue field="PARENTING" checkValue="0=��;1=��" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">�繤���</td>
				    <td colspan="2">
				    	<BZ:dataValue field="SOCIALWORKER" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥ��˵������������</td>
				    <td colspan="5">
				    	<BZ:dataValue field="REMARK_EN" onlyValue="true" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">������׼��Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��׼����</td>
				    <td>
				    	<BZ:dataValue field="GOVERN_DATE" type="date" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��Ч����</td>
				    <td>
				    	<BZ:dataValue field="VALID_PERIOD" defaultValue=""/>
				    </td>
				    <td class="edit-data-title">��׼��ͯ����</td>
				    <td>
				    	<BZ:dataValue field="APPROVE_CHILD_NUM" defaultValue=""/>
				    </td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������ͯ����</td>
				    <td>
				    	<BZ:dataValue field="AGE_FLOOR" defaultValue=""/>
				    	��-
				    	<BZ:dataValue field="AGE_UPPER" defaultValue=""/>
				    	��
				    </td>
				    <td class="edit-data-title">������ͯ�Ա�</td>
				    <td>
				    	<BZ:dataValue field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
				    </td>
				    <td class="edit-data-title">������ͯ����״��</td>
				    <td>
				    	<BZ:dataValue field="CHILDREN_HEALTH_EN" defaultValue="" codeName="ADOPTER_CHILDREN_HEALTH"/>
				    </td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">������Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�������������</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">����֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����״��֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">ְҵ֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�������뼰����״��֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">���彡�����֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�����ܹ����´���֤��</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">��ͥ���鱨��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">������������</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">�������������ڹ����ܻ���ͬ������������Ů��֤��</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��ͥ������Ƭ</td>
				    <td colspan="2">&nbsp;</td>
				    <td class="edit-data-title">�Ƽ���</td>
				    <td colspan="2">&nbsp;</td>
				  </tr>
				</table>
				
				<!-- �����Ԥ����Ϣ -->
				
				<table width="100%" border="1" class="specialtable">
				  <tr>
				    <th colspan="6" align="center">Ԥ��������ͯ������Ϣ</th>
				  </tr>
				  <tr>
				    <td width="19%" class="edit-data-title">ʡ��</td>
				    <td width="26%">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td width="14%" class="edit-data-title">����Ժ</td>
				    <td colspan="2">
				    	<BZ:dataValue field="S" onlyValue="true" defaultValue=""/>
				    </td>
				    <td rowspan="5">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">����</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">�Ա�</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">�ر��ע</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��������</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">���г̶�</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�ļ��ݽ�����</td>
				    <td><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				    <td class="edit-data-title">����ͬ��</td>
				    <td colspan="2"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">�������</td>
				    <td colspan="5"><BZ:dataValue field="S" onlyValue="true" defaultValue=""/></td>
				  </tr>
				  <tr>
				    <th colspan="6" align="center">Ԥ�������Ϣ</th>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˼���</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">���ʱ��</td>
				    <td width="15%">&nbsp;</td>
				    <td class="edit-data-title" width="14%">�����</td>
				    <td width="12%">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˽��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˼���</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">���ʱ��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">�����</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˽��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">������</td>
				    <td colspan="3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˼���</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">���ʱ��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">�����</td>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="edit-data-title">��˽��</td>
				    <td>&nbsp;</td>
				    <td class="edit-data-title">������</td>
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
			<!-- �����¼ -->
			<div id="tab6">
				<%-- <table class="table table-striped table-bordered table-hover dataTable" adsorb="both" id="sample-table">
					<thead>
						<tr>
							<th style="width: 10%; text-align: center">
								<div class="sorting">���</div>
							</th>
							<th style="width: 15%; text-align: center">
								<div class="sorting">���뵥λ</div>
							</th>
							<th style="width: 30%; text-align: center">
								<div class="sorting">�ͷ�ʱ��</div>
							</th>
							<th style="width: 15%; text-align: center">
								<div class="sorting">������</div>
							</th>
							<th style="width: 30%; text-align: center">
								<div class="sorting">���ʱ��</div>
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
	<!-- �����Ϣ -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					������
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<!-- �༭���� ��ʼ -->
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
						<td class="bz-edit-data-title">����֤���</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="ACCEPTED_CARD" value="1" prefix="P_" formTitle="" defaultChecked="true"></BZ:radio>��ȫ
				    		<BZ:radio field="ACCEPTED_CARD" value="2" prefix="P_" formTitle=""></BZ:radio>����ȫ
						</td>
						<td class="bz-edit-data-title">���뵥λ</td>
						<td class="bz-edit-data-value">
							<BZ:select field="TRANSLATION_COMPANY" formTitle="���뵥λ" prefix="P_">
								<BZ:option value="����">����</BZ:option>
								<BZ:option value="��֮��">��֮��</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:radio field="TRANSLATION_QUALITY" onclick="fanyizhiliangClick();" prefix="P_" value="1" formTitle="��������" defaultChecked="true"></BZ:radio>�ϸ�
				    		<BZ:radio field="TRANSLATION_QUALITY" onclick="fanyizhiliangClick();" prefix="P_" value="2" formTitle="��������"></BZ:radio>���ϸ�
						</td>
						
					</tr>
					<tr>
						<td class="bz-edit-data-title">��˽��</td>
						<td class="bz-edit-data-value">
							<BZ:select field="AUD_STATE" formTitle="��˽��">
								<BZ:option value="-1">-��ѡ��-</BZ:option>
								<BZ:option value="�ϱ�">�ϱ�</BZ:option>
								<BZ:option value="ͨ��">ͨ��</BZ:option>
								<BZ:option value="�����ļ�">�����ļ�</BZ:option>
								<BZ:option value="�����ļ�����">�����ļ�����</BZ:option>
								<BZ:option value="���·���">���·���</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title">�����</td>
						<td class="bz-edit-data-value">
							<BZ:input field="RED" defaultValue="" disabled="disabled" prefix="AUD_"/>					
						</td>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:input field="RED" defaultValue="" type="date" prefix="AUD_"/>			
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 30px;width: 97%;" name="AUD_YJIAN"></textarea>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 30px;width: 97%;" name="AUD_YJIAN"></textarea>
						</td>
					</tr>
					<tr id="fanyiNohege">
						<td class="bz-edit-data-title">���벻�ϸ�ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<textarea style="height: 30px;width: 97%;" name="AUD_YJIAN"></textarea>
						</td>
					</tr>
				</table>
				<!-- �༭���� ���� -->
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="��ӡ" class="btn btn-sm btn-primary" onclick="tijiao();"/>
			</a>
			<a href="reporter_files_list.html" >
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="window.location.href='reporter_files_list.html'"/>
			</a>
		</div>7
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
