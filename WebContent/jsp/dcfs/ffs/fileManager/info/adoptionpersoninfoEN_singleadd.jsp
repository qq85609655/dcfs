<%
/**   
 * @Title: adoptionpersoninfoEN_singleadd.jsp
 * @Description:  �����˻�����Ϣ���
 * @author yangrt   
 * @date 2014-7-22 ����4:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//Ů������Υ����Ϊ�����´�����ʶ,0=�ޣ�1=��
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//Ů���������޲����Ⱥñ�ʶ,0=�ޣ�1=��
	String CONABITA_PARTNERS = (String)request.getAttribute("CONABITA_PARTNERS");
%>
<BZ:html>
	<BZ:head>
		<title>�����˻�����Ϣ���</title>
		<up:uploadResource isImage="true"/>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-1.9.1.min.js"></script>
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
			
			$("#FEMALE_BMI_SHOW").text($("#R_FEMALE_BMI").val());
			
			var CONABITA_PARTNERS = "<%=CONABITA_PARTNERS %>";
			if(CONABITA_PARTNERS == "0"){
				$("#R_CONABITA_PARTNERS_TIME").attr("disabled","true");
			}else{
				$("#R_CONABITA_PARTNERS_TIME").removeAttr("disabled");
			}
			
			//��ʼ����ͥ���ʲ�
			_setTotalManny();
			
			
		});
		
		//������ʾ������Ů�����˵Ľ���״������
		function _setFemaleHealthContent(){
			var val = $("#R_FEMALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				$("#R_FEMALE_HEALTH_CONTENT_EN").attr("notnull","������Ů�����˽���״��������");
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
				$("#R_FEMALE_FEET").attr("notnull","����Ϊ�գ�");
				$("#R_FEMALE_INCH").attr("notnull","����Ϊ�գ�");
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
				$("#R_FEMALE_HEIGHT").attr("notnull","����Ϊ�գ�");
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
					page.alert("������дŮ�����������Ϣ������д������Ϣ��");
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
					page.alert("������дŮ�����������Ϣ������д������Ϣ��");
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
				$("#R_FEMALE_PUNISHMENT_EN").attr("notnull","����дŮ�����˵�Υ����Ϊ�����´�����");
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
				$("#R_FEMALE_ILLEGALACT_EN").attr("notnull","����д�������˵Ĳ����Ⱥã�");
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
		
		//�����ļ���¼��Ϣ
		function _adoptionSubmit(){
			//�������飬����ʼ������
			var att_arrays = ["R_FEMALE_PHOTO","Ů��������Ƭ"];
			var table = document.getElementById("infoTable" + att_arrays[0]);
			var trslen = table.rows.length;
			if(trslen == 0){
				alert("���ϴ�" + att_arrays[1] + "!");
				return;
			}else{
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
				return "true";
			}
		}
	</script>
	<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;ADOPTER_CHILDREN_SEX;ADOPTER_CHILDREN_HEALTH;HBBZ;ADOPTER_HEART_REPORT;ADOPTER_ADOPT_MOTIVATION;ADOPTER_CHILDREN_ABOVE;ORG_LIST;SYLX;ETXB;BCZL">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BMI" id="R_FEMALE_BMI" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue="2"/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
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
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�</td>
							<td class="bz-edit-data-value" width="18%">Ů</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" name="R_FEMALE_PHOTO" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' autoUpload="true" imageStyle="width:100%;height:100%" hiddenProcess="false" proContainerStyle="width:50%;" hiddenList="true" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
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
								<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="����" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" notnull="Please select the nationality of adoptive mother!" width="70%">
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
									<BZ:option value="0" selected="true">����</BZ:option>
									<BZ:option value="1">Ӣ��</BZ:option>
								</BZ:select>
								<span id="FEMALE_HEIGHT_INCH" style="display: none">
									<BZ:input prefix="R_" field="FEMALE_FEET" id="R_FEMALE_FEET" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>Ӣ��(Feet)
									<BZ:input prefix="R_" field="FEMALE_INCH" id="R_FEMALE_INCH" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:16%"/>Ӣ��(Inch)
								</span>
								<span id="FEMALE_HEIGHT_METRE"><BZ:input prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" formTitle="" defaultValue="" restriction="int" maxlength="" style="width:40%"/>����</span>
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
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemalePunishment(this)">��</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">��</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���޲����Ⱥ�<br>Any bad habits</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemaleIllegalact(this)">��</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">��</BZ:radio>
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
							<td class="bz-edit-data-title"><font color="red">*</font>ͬ�ӻ��</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">��</BZ:radio>
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">��</BZ:radio>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ͬ��ʱ��</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="CONABITA_PARTNERS_TIME" id="R_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" disabled="true"/>��(Year)
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>��ͬ��������</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">��</BZ:radio>
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="1" formTitle="" >��</BZ:radio>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���ҵ�λ<br>Currency</td>
							<td class="bz-edit-data-value" colspan="4">
								<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  isShowEN="true" notnull="Please select the Currency Unit!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>������<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" notnull="Please write the annual income of adoptive mother!" maxlength="22"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��ͥ���ʲ�<br>Asset</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="Please write the asset of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��ͥ��ծ��<br></td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="Please write the debt of family!" onblur="_setTotalManny()"/>
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
		<!-- �༭����end -->
	</BZ:body>
</BZ:html>