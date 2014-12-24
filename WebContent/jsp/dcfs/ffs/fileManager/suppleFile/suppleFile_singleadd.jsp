<%
/**   
 * @Title: suppleFile_singleadd.jsp
 * @Description:  ���������ļ���Ϣ�޸�ҳ
 * @author yangrt   
 * @date 2014-7-22 17:27:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//Ů������Υ����Ϊ�����´�����ʶ,0=�ޣ�1=��
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//Ů���������޲����Ⱥñ�ʶ,0=�ޣ�1=��
	
	String path = request.getContextPath();
	String xmlstr = (String)request.getAttribute("xmlstr");
	String af_id = (String)request.getAttribute("AF_ID");
	String org_id = (String)request.getAttribute("ADOPT_ORG_ID");
	String org_af_id = "org_id=" + org_id + ";af_id=" + af_id;
	String strPar = "org_id=" + org_id + ",af_id=" + af_id;
	
%>
<BZ:html>
	<BZ:head language="EN">
		<title>���������ļ���Ϣ�޸�ҳ</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
		<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//���ݳ������ڳ�ʼ������
			var female_briDate = $("#R_FEMALE_BIRTHDAY").val();	//Ů�����˵ĳ�������
			if(female_briDate != ""){
				$("#FEMALE_AGE").text(_getAge(female_briDate));
			}
			
			//��ʼ������״��˵������ʾ������
			var female_health = $("#R_FEMALE_HEALTH").find("option:selected").text();	//Ů�����˵Ľ���״��
			if(female_health == "����/����/����/��ҩ��"){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
			}
			
			//��ʼ����ߡ����ص���ʾ��ʽ�����ơ�Ӣ�ƣ�
			var measurement = $("#R_MEASUREMENT").find("option:selected").val();
			var female_height = $("#R_FEMALE_HEIGHT").val();	//Ů���������
			if(measurement == "0"){
				$("#FEMALE_HEIGHT_INCH").hide();
				$("#FEMALE_HEIGHT_METRE").show();
				$("#FEMALE_WEIGHT_POUNDS").hide();
				$("#FEMALE_WEIGHT_KILOGRAM").show();
				
			}else{
				$("#FEMALE_HEIGHT_INCH").show();
				$("#FEMALE_HEIGHT_METRE").hide();
				$("#FEMALE_WEIGHT_POUNDS").show();
				$("#FEMALE_WEIGHT_KILOGRAM").hide();
				
				var femaletempfeet = parseInt(female_height) / 30.48 + "";
				var femalefeet = femaletempfeet.split(".")[0];
				var femaleinch = (femaletempfeet - femalefeet) * 12;
				$("#R_FEMALE_FEET").val(femalefeet);
				$("#R_FEMALE_INCH").val(femaleinch.toFixed(2));
				
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//Ů����������
				$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
			}
			
			//��ʼ������ָ��
			$("#FEMALE_BMI_SHOW").text($("#R_FEMALE_BMI").val());
			
			//��ʼ��Υ����Ϊ�����´���˵������ʾ������
			var FEMALE_PUNISHMENT_FLAG = "<%=FEMALE_PUNISHMENT_FLAG%>";
			if(FEMALE_PUNISHMENT_FLAG == "1"){
				$("#R_FEMALE_PUNISHMENT_EN").show();
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").hide();
			}
			
			//��ʼ�������Ⱥ�˵������ʾ������
			var FEMALE_ILLEGALACT_FLAG = "<%=FEMALE_ILLEGALACT_FLAG%>";
			if(FEMALE_ILLEGALACT_FLAG == "1"){
				$("#R_FEMALE_ILLEGALACT_EN").show();
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").hide();
			}
			
			//��ʼ����ͥ���ʲ�
			_setTotalManny();
			
			//���ø����ϴ���
			var file_type = $("#R_FILE_TYPE").val();
			if(file_type == "22"){
				$("#tj").show();
				$("#tp_ts").hide();
			}else{
				$("#tp_ts").show();
				$("#tj").hide();
			}
		});
		
		//�����ļ���¼��Ϣ
		function _submit(){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else{
				//���帽��ID����������
				var att_arrays = new Array();
				//����ʼ������
				att_arrays = ["R_FEMALE_PHOTO","Ů��������Ƭ"]; 
				//��֤�����Ƿ��ϴ�
				var att_name = [];	//����δ�ϴ��ĸ�����������
				var name_length = 0;	//δ�ϴ�������������
				for(var i = 0; i < att_arrays.length; i+=2){
					var table = document.getElementById("infoTable" + att_arrays[i]);
					var trslen = table.rows.length;
					if(trslen == 0){
						//��δ�ϴ��ĸ����������Ʒ�������att_name�У�����¼δ�ϴ��ĸ���������
						att_name[name_length++] = att_arrays[i+1];
					}
				}
				if(name_length > 0){
					//page.alert("���ϴ�" + att_name.join("��") + "!");
					alert("���ϴ�" + att_name.join("��") + "!");
					return;
				}else
					if(confirm("Are you sure you want to submit?")){
					//��Ӣ�Ƶ�λת��Ϊ���ƽ��б���
					var typeval = $("#R_MEASUREMENT").find("option:selected").val();
					if(typeval == 1){
						var femalefeetval = $("#R_FEMALE_FEET").val();
						var femaleinchval = $("#R_FEMALE_INCH").val();
						
						//��Ӣ�����ת��Ϊ�������,1Ӣ��=0.3048�ף�1Ӣ��=0.0254��
						var femaleheightval = parseInt(femalefeetval) * 30.48 + parseInt(femaleinchval) * 2.54;
						$("#R_FEMALE_HEIGHT").val(femaleheightval);
						//��Ӣ������ת��Ϊ��������,1��=0.45359237ǧ��
						var femaleweightval = parseInt($("#R_FEMALE_WEIGHT").val()) * 0.45359237;
						$("#R_FEMALE_WEIGHT").val(femaleweightval);
					}
					
					//���ύ
					document.srcForm.action = path+"ffs/filemanager/BasicInfoSave.action";
					document.srcForm.submit();
					window.close();
				}
			}
			
		}
		//���صݽ���ͨ�ļ��б�ҳ��
		function _close(){
			window.close();
		}
		
		//������ʾ������Ů�����˵Ľ���״������
		function _setFemaleHealthContent(){
			var val = $("#R_FEMALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				$("#R_FEMALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive mother's health condition!");
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				$("#R_FEMALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//������������صļ�����ʽ
		function _setHeightWeight(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			if(typeval == 1){	//��ѡ��Ӣ��ʱ
				var female_height = $("#R_FEMALE_HEIGHT").val();	//Ů�����˹������
				if(female_height != ""){
					var femaletempfeet = parseInt(female_height) / 30.48 + "";
					var femalefeet = femaletempfeet.split(".")[0];
					var femaleinch = (femaletempfeet - femalefeet) * 12;
					$("#R_FEMALE_FEET").val(femalefeet);
					$("#R_FEMALE_INCH").val(femaleinch.toFixed(2));
				}
				$("#FEMALE_HEIGHT_INCH").show();
				$("#FEMALE_HEIGHT_METRE").hide();
				$("#R_FEMALE_FEET").attr("notnull","This cannot be empty��");
				$("#R_FEMALE_INCH").attr("notnull","This cannot be empty��");
				$("#R_FEMALE_HEIGHT").removeAttr("notnull");
				
				//����������ת��ΪӢ������,1��=0.45359237ǧ��
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//Ů����������
				if(female_weight != ""){
					$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));	
				}
				$("#FEMALE_WEIGHT_POUNDS").show();
				$("#FEMALE_WEIGHT_KILOGRAM").hide();
			}else{
				var female_height = $("#R_FEMALE_HEIGHT").val();	//Ů�����˹������
				if(female_height == ""){
					var female_feet = $("#R_FEMALE_FEET").val();
					var female_inch = $("#R_FEMALE_INCH").val();
					if(female_feet != "" || female_inch != ""){
						//��Ӣ�����ת��Ϊ�������,1Ӣ��=0.3048�ף�1Ӣ��=0.0254��
						$("#R_FEMALE_HEIGHT").val(parseInt(female_feet) * 30.48 + parseInt(female_inch) * 2.54);
					}
				}
				$("#FEMALE_HEIGHT_INCH").hide();
				$("#FEMALE_HEIGHT_METRE").show();
				$("#R_FEMALE_HEIGHT").attr("notnull","This cannot be empty��");
				$("#R_FEMALE_FEET").removeAttr("notnull");
				$("#R_FEMALE_INCH").removeAttr("notnull");
				
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//Ů����������
				if(female_weight != ""){
					$("#R_FEMALE_WEIGHT").val(parseFloat(parseInt(female_weight) * 0.45359237).toFixed(2));	
				}
				$("#FEMALE_WEIGHT_POUNDS").hide();
				$("#FEMALE_WEIGHT_KILOGRAM").show();
			}
		}
		
		//�Զ�����Ů�����˵�����ָ��
		function _setFemaleBMI(){
			var typeval = $("#R_MEASUREMENT").find("option:selected").val();
			if(typeval == 1){
				var feetval = $("#R_FEMALE_FEET").val();
				var inchval = $("#R_FEMALE_INCH").val();
				if(feetval == "" || inchval == ""){
					alert("Please input the adoptive mother's height information before weight!");
					$("#R_FEMALE_WEIGHT").val("");
					$("#R_FEMALE_WEIGHT").text("");
					return;
				}else{
					//��Ӣ�����ת��Ϊ�������,1Ӣ��=0.3048�ף�1Ӣ��=0.0254��
					var heightval = parseInt(feetval) * 0.3048 + parseInt(inchval) * 0.0254;
					//��Ӣ������ת��Ϊ��������,1��=0.45359237ǧ��
					var weightval = parseInt($("#R_FEMALE_WEIGHT").val()) * 0.45359237;
					//��������ָ��
					var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
					$("#R_FEMALE_BMI").val(weightindex);
					$("#FEMALE_BMI_SHOW").text(weightindex);
				}
			}else{
				if($("#R_FEMALE_HEIGHT").val() == ""){
					alert("Please input the adoptive mother's height information before weight!");
					$("#R_FEMALE_WEIGHT").val("");
					$("#R_FEMALE_WEIGHT").text("");
					return;
				}else{
					var heightval = parseInt($("#R_FEMALE_HEIGHT").val()) / 100;
					var weightval = $("#R_FEMALE_WEIGHT").val();
					var weightindex = parseFloat(weightval / (heightval * heightval)).toFixed(2);
					$("#R_FEMALE_BMI").val(weightindex);
					$("#FEMALE_BMI_SHOW").text(weightindex);
				}
			}
		}
		
		//��ʩŮ������Υ����Ϊ�����´�����������ʾ������
		function _setFemalePunishment(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_FEMALE_PUNISHMENT_EN").hide();
				$("#R_FEMALE_PUNISHMENT_EN").val("");
				$("#R_FEMALE_PUNISHMENT_EN").removeAttr("notnull");
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").show();
				$("#R_FEMALE_PUNISHMENT_EN").attr("notnull","Please fill in the adoptive mother's criminal records!");
			}
		}
		
		//��ʩŮ�����˲����Ⱥ���������ʾ������
		function _setFemaleIllegalact(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_FEMALE_ILLEGALACT_EN").hide();
				$("#R_FEMALE_ILLEGALACT_EN").val("");
				$("#R_FEMALE_ILLEGALACT_EN").removeAttr("notnull");
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").show();
				$("#R_FEMALE_ILLEGALACT_EN").attr("notnull","Please fill in the adoptive father's bad habits.");
			}
		}
		
		//����ͬ��ʱ���Ƿ�ɱ༭
		function _setConabitaPartnersTime(obj){
			var val = obj.value;
			if(val == "0"){
				$("#R_CONABITA_PARTNERS_TIME").attr("disabled","true");
			}else{
				$("#R_CONABITA_PARTNERS_TIME").removeAttr("disabled");
			}
		}
		
		//���ݼ�ͥ���ʲ�����ծ����㾻�ʲ�
		function _setTotalManny(){
			var total_asset = $("#R_TOTAL_ASSET").val();	//���ʲ�
			var total_debt = $("#R_TOTAL_DEBT").val();	//��ծ��
			if(total_asset == ""){
				$("#TOTAL_MANNY").text("");
			}else{
				if(total_debt == ""){
					$("R_TOTAL_DEBT").val(0);
					$("R_TOTAL_DEBT").text(0);
					total_debt = 0;
				}
				$("#TOTAL_MANNY").text(total_asset - total_debt);
			}
		}
		
		//���ݳ������ڻ�ȡ��������
		function _getAge(strBirthday)
		{       
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//ͬ�� ��Ϊ0��
		    }else{
		        var ageDiff = nowYear - birthYear ; //��֮��
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//��֮��
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//��֮��
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//����-1 ��ʾ��������������� ���ڽ���
		        }
		    }
		    return returnAge;//������������
		}
		//***********�����ϴ�����JS****************************************************
		function getIframeVal(val)  
		{
			//document.getElementById("textareaid").value=urlDecode(val);
			//alert(document.getElementById("frmUpload"));
			//document.getElementById("frmUpload").location.reload();
			if(p=="0"){
				frmUpload.window.location.reload();
			}else{
				frmUpload1.window.location.reload();
			}
		}	
		
		var p = "0";
		//�����ϴ�
		function _toipload(fn){
			p = fn;		
			var packageId,isEn;
			//p=0���ϴ������
			if(p=="0"){
				packageId = "<BZ:dataValue field="PACKAGE_ID_CN" onlyValue="true"/>";
				isEn = "false";
			}else{//p=0���ϴ�ԭ��
				packageId = "<%=af_id%>";
				isEn = "true";
			}
			popWin.showWinIframe("750","450","fileframe","��������","iframe","#");
			document.uploadForm.PACKAGE_ID.value = packageId;
			document.uploadForm.IS_EN.value = isEn;
			document.uploadForm.action="<%=path%>/uploadManager";
			document.uploadForm.target="fileframe";
			document.uploadForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;SYLX;ETXB;BCZL">
		<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BMI" id="R_FEMALE_BMI" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����˻�����Ϣ(Information about the adoptive parents)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="18%">Female</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" packageId="<%=af_id%>" name="R_FEMALE_PHOTO" queueStyle="border:solid 1px #CCCCCC;" queueTableStyle="padding:2px" imageStyle="width:150px;height:160px;" autoUpload="true" hiddenSelectTitle="true" hiddenProcess="true" hiddenList="true" selectAreaStyle="width:100%" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"  bigType="AF" diskStoreRuleParamValues="<%=org_af_id%>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">����<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>����<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="Nationality" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" notnull="Please select the nationality of adoptive mother!" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�ܽ������<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_EDUCATION" id="R_FEMALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" notnull="Please select the education of adoptive mother!" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>ְҵ<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" formTitle="" defaultValue="" notnull="����дŮ������ְҵ��" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>����״��<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" notnull="Please select the health status of adoptive mother!" onchange="_setFemaleHealthContent()">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���<br>Height</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" formTitle="" defaultValue="" notnull="Please select the type of height and weight!" onchange="_setHeightWeight()">
									<BZ:option value="0" selected="true">Metric system</BZ:option>
									<BZ:option value="1">British system</BZ:option>
								</BZ:select>
								<span id="FEMALE_HEIGHT_INCH">
									<BZ:input prefix="R_" field="FEMALE_FEET" id="R_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>Ӣ��(Feet)
									<BZ:input prefix="R_" field="FEMALE_INCH" id="R_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>Ӣ��(Inch)
								</span>
								<span id="FEMALE_HEIGHT_METRE"><BZ:input prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:40%"/>����(Centimeter)</span>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>����<br>Weight</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" formTitle="" defaultValue="" notnull="Please write the weight of adoptive mother!" restriction="number" onblur="_setFemaleBMI()" maxlength="50" style="width:20%"/><span id="FEMALE_WEIGHT_POUNDS" style="display: none">��(Pound)</span><span id="FEMALE_WEIGHT_KILOGRAM">ǧ��(Kilogram)</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����ָ��<br>BMI</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_BMI_SHOW"></span>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>Υ����Ϊ�����´���<br>Criminal records</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemalePunishment(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���޲����Ⱥ�<br>Any bad habits</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemaleIllegalact(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ڽ�����<br>Religious belief</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_RELIGION_EN" id="R_FEMALE_RELIGION_EN" formTitle="" defaultValue="" maxlength="500"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>����״��<br>Marital status</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select prefix="R_" field="MARRY_CONDITION" id="R_MARRY_CONDITION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" isShowEN="true" notnull="Please select the Marital status!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>ͬ�ӻ��<br>Cohabitant partner</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">Yes</BZ:radio>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ͬ��ʱ��<br>Cohabitation period</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="CONABITA_PARTNERS_TIME" id="R_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" disabled="true" style="width:30%;"/>��(Year)
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>��ͬ��������<br>Non-Homosexual statement</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="1" formTitle="" >Yes</BZ:radio>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���ҵ�λ<br>Currency</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="Currency" defaultValue="" isCode="true" codeName="HBBZ"  isShowEN="true" notnull="Please select the Currency Unit!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>������<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="Please write the annual income of adoptive mother!" maxlength="22"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��ͥ���ʲ�<br>Assets</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" formTitle="" defaultValue="" restriction="number" notnull="Please write the asset of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��ͥ��ծ��<br>Debts</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" formTitle="" defaultValue="" restriction="number" notnull="Please write the debt of family!" onblur="_setTotalManny()"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��ͥ���ʲ�<br>Net assets</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="TOTAL_MANNY"></span>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>18����������Ů����<br>Number and age of children under 18 years old</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="Please write the number and age of children under 18 years old!" />��
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="18%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��Ů���������<br>Number of children</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="CHILD_CONDITION_EN" id="R_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="Please write the number of children!" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��ͥסַ<br>Address</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ADDRESS" id="R_ADDRESS" formTitle="" defaultValue="" notnull="Please write the family address!" maxlength="500" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">����Ҫ��<br>Adoption preference</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ADOPT_REQUEST_EN" id="R_ADOPT_REQUEST_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ(Attachment)&nbsp;&nbsp;
						<input type="button" class="btn btn-sm btn-primary" value="Upload attachment" onclick="_toipload('1')"/>
					</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-value">
								<IFRAME ID="frmUpload1" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&IS_EN=true&packID=<%=AttConstants.AF_SIGNALPARENT%>&packageID=<%=af_id %>" frameborder=0 width="100%" ></IFRAME>
							</td>
						</tr>
					</table>
				</div>			
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
		<form name="uploadForm" method="post" action="/uploadManager" target="fileframe">
		<!--����ʹ�ã�start-->
			<input type="hidden" id="IFRAME_NAME"	name="IFRAME_NAME"	value=""/>
			<input type="hidden" id="PACKAGE_ID"	name="PACKAGE_ID"	value="<%=af_id %>"/>
			<input type="hidden" id="SMALL_TYPE"	name="SMALL_TYPE"	value='<%=xmlstr%>'/>
			<input type="hidden" id="ENTITY_NAME"	name="ENTITY_NAME"	value="ATT_AF"/>
			<input type="hidden" id="BIG_TYPE"		name="BIG_TYPE"		value="AF"/>
			<input type="hidden" id="IS_EN"			name="IS_EN"		value="false"/>
			<input type="hidden" id="CREATE_USER"	name="CREATE_USER"	value=""/>
			<input type="hidden" id="PATH_ARGS"		name="PATH_ARGS"	value='<%=strPar%>'/>		
		<!--����ʹ�ã�end-->
		</form>
	</BZ:body>
</BZ:html>