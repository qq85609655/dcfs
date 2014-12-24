<%
/**   
 * @Title: normalFile_addFirst.jsp
 * @Description:  ������֯�ݽ���ͨ�ļ���һ������ҳ��
 * @author yangrt   
 * @date 2014-7-22 ����11:13:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
	<BZ:head language="EN">
		<title>������ͨ�ļ���һ������ҳ��</title>
		<BZ:webScript edit="true" isAjax="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		});
		
		//�����ļ���¼��Ϣ
		function _submit(){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			//��ȡ������֯code
			var adopt_org = $("#R_ADOPT_ORG_ID").val();
			//�ļ�����code
			var file_type = $("#R_FILE_TYPE").val();
			//��ȡ������������
			var malename = $("#R_MALE_NAME").val();
			//��ȡŮ����������
			var femalename = $("#R_FEMALE_NAME").val();
			//��������֯code����������������Ů����������ƴ��
			var strname = adopt_org + "#" + malename + "#" + femalename + "#" + file_type;
			
			//��strname����
			var name = encodeURI(strname);
			//����������֯���Ƿ��Ѵ�����ͬ�������ˡ�Ů�����˵ļ�ͥ�ļ�
			var data = getData('com.dcfs.ffs.fileManager.FileManagerAjax','method=getFileData&name=' + name);
			//��ȡ�ļ�ID
			var file_id = data.getString("AF_ID","");
			if(file_id != ""){
				if(confirm("Your agency has unsubmitted adoption applications of families with the same name. Are you sure to fill in a new application?")){
					//���ύ
					$("#R_FAMILY_TYPE").attr("disabled",false);
					var obj = document.forms["srcForm"];
					obj.action=path+'ffs/filemanager/NormalFileSaveFirst.action?AF_ID=' + file_id;
					obj.submit();
				}
			}else if(confirm("Are you sure you want to continue to the next step?")){
				//���ύ
				$("#R_FAMILY_TYPE").attr("disabled",false);
				var obj = document.forms["srcForm"];
				obj.action=path+'ffs/filemanager/NormalFileSaveFirst.action';
				obj.submit();
			}
			
		}
		
		//���صݽ���ͨ�ļ��б�ҳ��
		function _goback(){
			window.location.href=path+'ffs/filemanager/NormalFileList.action';
		}
		
		//�ļ�����Ϊ����Ů����ʱ���������������б�ֻ��ѡ����������Ů����
		function _dynamicJznsy(){
			var sylx = $("#R_FILE_TYPE").find("option:selected").val();
			if(sylx=="33"){
				//������������Ϊ˫�����������û�
				$("#R_FAMILY_TYPE")[0].selectedIndex = 2; 
				$("#R_FAMILY_TYPE").attr("disabled",true);
				$("#AdopterSex").show();
				$("#R_SEX").attr("notnull","please input adopter's sex!");
			}else{
				$("#R_FAMILY_TYPE")[0].selectedIndex = 0; 
				$("#R_FAMILY_TYPE").attr("disabled",false);   
				$("#R_ADOPTER_SEX").val("");
				$("#AdopterSex").hide();
				$("#R_SEX").removeAttr("notnull");
				$("#R_SEX").val("");
			}
			$("#MaleInfo").hide();
			$("#R_MALE_NAME").removeAttr("notnull");
			$("#R_MALE_NAME").val("");
			$("#FemaleInfo").hide();
			$("#R_FEMALE_NAME").removeAttr("notnull");
			$("#R_FEMALE_NAME").val("");
		}
		
		//�����������ͣ���̬����Ů�������������ڽ���ֻ���ͱ���������
		function _dynamicHide(){
			var file_type = $("#R_FILE_TYPE").find("option:selected").val();
			var optionText = $("#R_FAMILY_TYPE").find("option:selected").val();
			if(optionText=="2"){
				if(file_type == "34"){
					$("#AdopterSex").show();
					$("#R_SEX").attr("notnull","please input adopter's sex!");
					$("#MaleInfo").hide();
					$("#R_MALE_NAME").removeAttr("notnull");
					$("#R_MALE_NAME").val("");
					$("#FemaleInfo").hide();
					$("#R_FEMALE_NAME").removeAttr("notnull");
					$("#R_FEMALE_NAME").val("");
				}else{
					$("#R_ADOPTER_SEX").val(optionText);
					$("#MaleInfo").hide();
					$("#R_MALE_NAME").removeAttr("notnull");
					$("#FemaleInfo").show();
					$("#R_FEMALE_NAME").attr("notnull","please input female adopter's name!");
				}
			}else if(optionText=="1"){
				$("#AdopterSex").hide();
				$("#R_SEX").removeAttr("notnull");
				$("#MaleInfo").show();
				$("#FemaleInfo").show();
				$("#R_MALE_NAME").attr("notnull","please input male adopter's name!");
				$("#R_FEMALE_NAME").attr("notnull","please input female adopter's name!");
			}
		}
		
		//�����������Ա�
		function _setAdopterSex(){
			var val = $("#R_SEX").find("option:selected").val();
			$("#R_ADOPTER_SEX").val(val);
			if(val=="2"){
				//$("#R_MALE_NAME").css({background: "rgb(240, 240, 240)" });
				
				$("#MaleInfo").hide();
				$("#R_MALE_NAME").removeAttr("notnull");
				$("#R_MALE_NAME").val("");
				$("#FemaleInfo").show();
				$("#R_FEMALE_NAME").attr("notnull","please input female adopter's name!");
			}else if(val=="1"){
				$("#MaleInfo").show();
				$("#R_MALE_NAME").attr("notnull","please input male adopter's name!");
				$("#FemaleInfo").hide();
				$("#R_FEMALE_NAME").removeAttr("notnull");
				$("#R_FEMALE_NAME").val("");
			}
		}
	</script>
</BZ:html>
<BZ:body property="data" codeNames="ZCWJLX;">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<!-- ��������begin -->
	<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="NAME_CN" id="R_NAME_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="NAME_EN" id="R_NAME_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="COUNTRY_CN" id="R_COUNTRY_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="COUNTRY_EN" id="R_COUNTRY_EN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
	<!-- ��������end -->
	<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 60%;margin-left: auto;margin-right: auot;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">������֯(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" width="80%">
								<BZ:dataValue field="NAME_CN" hrefTitle="������֯(CN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������֯(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_EN" hrefTitle="������֯(EN)" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�ļ�����<br>Document type</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" isShowEN="true" formTitle="Document type" isCode="true" codeName="ZCWJLX" notnull="��ѡ���ļ�����" onchange="_dynamicJznsy()" width="50%">
									<option value="">--Please select--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>��������<br>Adoption type</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FAMILY_TYPE" id="R_FAMILY_TYPE" formTitle="Adoption type" isCode="false" notnull="��ѡ����������" onchange="_dynamicHide()" width="50%">
									<option value="">--Please select--</option>
									<option value="1">Two parents</option>
									<option value="2">Single parent</option>
								</BZ:select>
							</td>
						</tr>
						<tr id="AdopterSex" style="display:none">
							<td class="bz-edit-data-title"><font color="red">*</font>�������Ա�</td>
							<td class="bz-edit-data-value">
								<BZ:select field="SEX" id="R_SEX" formTitle="" prefix="R_" isCode="false" width="50%" onchange="_setAdopterSex()">
									<option value="">--Please select--</option>
									<option value="1">Male</option>
									<option value="2">Female</option>
								</BZ:select>
							</td>
						</tr>
						<tr id="MaleInfo" style="display:none">
							<td class="bz-edit-data-title"><font color="red">*</font>��������<br>Adoptive father</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_NAME" id="R_MALE_NAME" type="String" notnull="sdfafasd"  formTitle="Adoptive father" defaultValue="" style="width:75%;" maxlength="150"/>
							</td>
						</tr>
						<tr id="FemaleInfo" style="display:none">
							<td class="bz-edit-data-title poptitle"><font color="red">*</font>Ů������<br>Adoptive mother</td>
							<td class="bz-edit-data-value" >
								<BZ:input prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" type="String"  formTitle="Adoptive mother" defaultValue="" style="width:75%" maxlength="150"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Next step" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>