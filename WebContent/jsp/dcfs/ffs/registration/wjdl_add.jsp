<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: wjdl_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-7-14 ����3:00:34 
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
 	//�������ݶ���
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	//��ȡ������ϢID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
%>
<BZ:html>

<BZ:head language="CN">
	<title>�ļ���¼</title>
	<up:uploadResource/>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
		_dynamicHide();
		_getAfCost();
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID');
	});
	
	
	//�����ļ���¼��Ϣ
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//�Ƿ�¼�������Ϣ
			_dyShowPjInfo();
			
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//ͨ�������б�ѡ��������ֶθ�ֵ
			var temp1 = $("#P_COUNTRY_CODE").find("option:selected").text();
			var temp2 = $("#P_ADOPT_ORG_ID").find("option:selected").text();
			$("#P_COUNTRY_CN").val(temp1);//����CN
			$("#P_NAME_CN").val(temp2);//��֯CN
			
			//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
			$("#P_FAMILY_TYPE").attr("disabled",false);
			$("#P_PAID_SHOULD_NUM").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveFlieRecord.action';
			obj.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	
	//�����������ͣ���̬����Ů�������������ڽ���ֻ���ͱ���������
	function _dynamicHide(){
		var val = $("#P_FAMILY_TYPE_VIEW2").val();//��������
		var val2 = $("#P_FILE_TYPE").val();//�ļ�����
		var val3 = $("#P_ADOPTER_SEX").val();//�������Ա�
		if(val=="����������Ů��"){
			//��̬��ʾ�������*
			$("#nf").hide();
			$("#nfcs").hide();
			$("#ff").show();
			$("#ffcs").show();
			$("#syrxb").show();
			$("#syrxb2").show();
			//��̬������Ů��������������ֻ�����Ժͳ�ʼֵ
			$("#P_MALE_NAME").val("");
			$("#P_MALE_BIRTHDAY").val("");
			$("#P_MALE_NAME").attr("disabled",true);
			$("#P_MALE_BIRTHDAY").attr("disabled",true);
			$("#P_FEMALE_NAME").attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
			//����Ů����������������Ϊ������
			$("#P_FEMALE_NAME").attr("notnull","������Ů������");
			$("#P_FEMALE_BIRTHDAY").attr("notnull","������Ů����������");
			$("#P_MALE_NAME").removeAttr("notnull");
			$("#P_MALE_BIRTHDAY").removeAttr("notnull");
		}else if(val=="�����������У�"){
			//��̬��ʾ�������*
			$("#nf").show();
			$("#nfcs").show();
			$("#ff").hide();
			$("#ffcs").hide();
			$("#syrxb").show();
			$("#syrxb2").show();
			//��̬������Ů��������������ֻ�����Ժͳ�ʼֵ
			$("#P_FEMALE_BIRTHDAY").val("");
			$("#P_MALE_NAME").attr("disabled",false);
			$("#P_MALE_BIRTHDAY").attr("disabled",false);
			$("#P_FEMALE_NAME").attr("disabled",true);
			$("#P_FEMALE_BIRTHDAY").attr("disabled",true);
			//�����з���������������Ϊ������
			$("#P_MALE_NAME").attr("notnull","�������з�����");
			$("#P_MALE_BIRTHDAY").attr("notnull","�������з���������");
			$("#P_FEMALE_NAME").removeAttr("notnull");
			$("#P_FEMALE_BIRTHDAY").removeAttr("notnull");
		}else if(val=="˫������"){
			if(val2=="33"&&val3=="1"){//����ļ�����Ϊ����Ů�����������������Ա�Ϊ��
				$("#P_MALE_NAME").attr("disabled",false);
				$("#P_MALE_BIRTHDAY").attr("disabled",false);
				$("#P_FEMALE_NAME").attr("disabled",true);
				$("#P_FEMALE_BIRTHDAY").attr("disabled",true);
				$("#P_MALE_NAME").attr("notnull","�������з�����");
				$("#P_MALE_BIRTHDAY").attr("notnull","�������з���������");
				$("#P_FEMALE_NAME").removeAttr("notnull");
				$("#P_FEMALE_BIRTHDAY").removeAttr("notnull");
				$("#syrxb").show();
				$("#nf").show();
				$("#nfcs").show();
				$("#ff").hide();
				$("#ffcs").hide();
				
			}else if(val2=="33"&&val3=="2"){//����ļ�����Ϊ����Ů�����������������Ա�ΪŮ
				$("#P_MALE_NAME").attr("disabled",true);
				$("#P_MALE_BIRTHDAY").attr("disabled",true);
				$("#P_FEMALE_NAME").attr("disabled",false);
				$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
				$("#P_FEMALE_NAME").attr("notnull","������Ů������");
				$("#P_FEMALE_BIRTHDAY").attr("notnull","������Ů����������");
				$("#P_MALE_NAME").removeAttr("notnull");
				$("#P_MALE_BIRTHDAY").removeAttr("notnull");
				$("#syrxb").show();
				$("#ff").show();
				$("#ffcs").show();
				$("#nf").hide();
				$("#nfcs").hide();
			}else{
				$("#P_FEMALE_NAME").attr("disabled",false);
				$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
				$("#P_MALE_NAME").attr("disabled",false);
				$("#P_MALE_BIRTHDAY").attr("disabled",false);
				$("#P_FEMALE_NAME").attr("notnull","������Ů������");
				$("#P_FEMALE_BIRTHDAY").attr("notnull","������Ů����������");
				$("#P_MALE_NAME").attr("notnull","�������з�����");
				$("#P_MALE_BIRTHDAY").attr("notnull","�������з���������");
				$("#syrxb").hide();
				$("#nf").show();
				$("#nfcs").show();
				$("#ff").show();
				$("#ffcs").show();
			}
		}
	}
	
	
	/**
	*ѡ���ļ�ת��֯
	*@author:mayun
	*@date:2014-7-17
	*/
	function _chosefile(){
		var temp=document.getElementsByName("P_IS_CHANGE_ORG");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var num = temp[i].value;
				if(num==0){//��
					$("#yswbh").hide();
					$("#yswbh2").hide();
					$("#P_ORIGINAL_FILE_NO").val("");
					$("#P_ORIGINAL_FILE_NO").removeAttr("notnull");
				}else{//��
					$("#yswbh").show();
					$("#yswbh2").show();
					$("#P_ORIGINAL_FILE_NO").attr("notnull","������ԭ���ı��");
					//window.open(path+"ffs/registration/toChoseFile.action","",",'height=500,width=800,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
				}
			}
		}
	}
	
	
	function _openchosefile(){
		window.open(path+"ffs/registration/toChoseFile.action","",",'height=500,width=800,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
	}
	
	
	
	
	
	
	
	
	//��̬��ʾƱ��¼����Ϣ
	function _dyShowPjInfo(){
		var temp=document.getElementsByName("P_ISPIAOJU");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var num = temp[i].value;
				$("#P_ISPIAOJUVALUE").val(num);
				if(num==0){//��
					$("#pjInfo").hide();
					$("#P_PAID_WAY").val("");
					$("#P_PAR_VALUE").val("");
					$("#P_PAID_WAY").removeAttr("notnull");
					$("#P_PAR_VALUE").removeAttr("notnull");
				}else{//��
					$("#pjInfo").show();
					$("#P_PAID_WAY").attr("notnull","������ɷѷ�ʽ");
					$("#P_PAR_VALUE").attr("notnull","������Ʊ����");
				}
			}
		}
	}
	
	//�������ı�Ż�ȡ�����ļ�������Ϣ������ҳ�涯̬��ֵ
	function _dySetFileInfo(fileNo){
		if(null!=fileNo&&""!=fileNo){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=getFileInfo&fileNo='+fileNo,
				type: 'POST',
				timeout:1000,
				dataType: 'json',
				success: function(data){
					$("#P_FILE_TYPE").val(data.FILE_TYPE);//�ļ�����
					$("#P_FAMILY_TYPE").val(data.FAMILY_TYPE);//��������
					$("#P_MALE_NAME").val(data.MALE_NAME);//��������
					$("#P_MALE_BIRTHDAY").val(data.MALE_BIRTHDAY);//�г�������
					$("#P_FEMALE_NAME").val(data.FEMALE_NAME);//Ů������
					$("#P_FEMALE_BIRTHDAY").val(data.FEMALE_BIRTHDAY);//Ů��������
					//$("#P_COUNTRY_CODE").val(data.COUNTRY_CODE);//����
					//$("#P_ADOPT_ORG_ID").val(data.ADOPT_ORG_ID);//������֯code
					//$("#P_ADOPT_ORG_NAME").val(data.NAME_CN);//������֯Name
					$("#P_ORIGINAL_FILE_NO").val(data.FILE_NO);//ԭ���ı��
				}
		  	  });
		}
	}
	
	function _goup(){
		var obj = document.forms["srcForm"];
		obj.action=path+"/ffs/registration/toAddFlieRecordChoise.action";
		obj.submit();
	}
	
	
	//��ȡӦ�ɽ��
	function _getAfCost(){
		$.ajax({
			url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=getAfCost&file_type=ZCWJFWF',
			type: 'POST',
			timeout:1000,
			dataType: 'json',
			success: function(data){
				$("#P_AF_COST").val(data.VALUE1);
				$("#P_PAID_SHOULD_NUM").val(data.VALUE1);
			}
	  	  });
	}
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;WJLX_DL;FYLB;JFFS;FWF" property="wjdlData" >

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_CN"/>
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_EN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_CN"/>
		<BZ:input type="hidden" prefix="P_" field="NAME_EN"/>
		<BZ:input type="hidden" prefix="P_" field="AF_COST" id="P_AF_COST"/>
		<BZ:input type="hidden" field="ISPIAOJUVALUE" prefix="P_" id="P_ISPIAOJUVALUE"/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�ļ�������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">�ļ�����</td>
							<td class="bz-edit-data-value"  width="30%">
								<BZ:dataValue field="FILE_TYPE_VIEW" codeName="WJLX_DL" defaultValue="" onlyValue="true"/>
								<BZ:input type="hidden" field="FILE_TYPE" prefix="P_" id="P_FILE_TYPE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">��������</td>
							<td class="bz-edit-data-value"  width="30%">
								<BZ:dataValue field="FAMILY_TYPE_VIEW" defaultValue="" onlyValue="true"/>
								<BZ:input type="hidden" field="FAMILY_TYPE" defaultValue="" prefix="P_"  id="P_FAMILY_TYPE"/>
								<BZ:input type="hidden" field="FAMILY_TYPE_VIEW2" defaultValue="" prefix="P_"  id="P_FAMILY_TYPE_VIEW2"/>
							</td>
						</tr>
						<tr  id="syrxb" style="display:none">
							<td class="bz-edit-data-title" width="20%">�������Ա�</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="ADOPTER_SEX_VIEW" defaultValue="" onlyValue="true"/>
								<BZ:input type="hidden" field="ADOPTER_SEX" defaultValue="" prefix="P_"  id="P_ADOPTER_SEX"/>
								<BZ:input type="hidden" field="ADOPTER_SEX_VIEW2" defaultValue="" prefix="P_"  id="P_ADOPTER_SEX_VIEW2"/>
							</td>
							<td class="bz-edit-data-title" width="20%"></td>
							<td class="bz-edit-data-value" width="30%"></td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td class="bz-edit-data-value">
								<BZ:select field="COUNTRY_CODE" formTitle=""
									prefix="P_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
									onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--��ѡ��--
									</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
									onchange="_setOrgID('P_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">ת&nbsp;&nbsp;��&nbsp;&nbsp;֯</td>
							<td class="bz-edit-data-value" >
								<BZ:radio field="IS_CHANGE_ORG" value="0" prefix="P_" formTitle="" defaultChecked="true" onclick="_chosefile()">��</BZ:radio>
								<BZ:radio field="IS_CHANGE_ORG" value="1" prefix="P_" formTitle="" onclick="_chosefile()">��</BZ:radio>
							</td>
							<td class="bz-edit-data-title poptitle" style="display:none" id="yswbh"><font color="red">*</font>ԭ���ı��</td>
							<td class="bz-edit-data-value" style="display:none" id="yswbh2">
								<BZ:input field="ORIGINAL_FILE_NO" id="P_ORIGINAL_FILE_NO" prefix="P_" type="String" formTitle="ԭ���ı��" defaultValue="" maxlength="50" />
								<img src="<%=request.getContextPath() %>/resources/resource1/images/page/edit-find.png" onclick="_openchosefile()" title="���ѡ��ԭ���ı��">
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red" id="nf">*</font>��������</td>
							<td class="bz-edit-data-value">
								<BZ:input field="MALE_NAME" id="P_MALE_NAME" prefix="P_" type="String"  formTitle="�з�" defaultValue="" style="width:75%" maxlength="150"/>
							</td>
							<td class="bz-edit-data-title"><font color="red" id="nfcs">*</font>��������</td>
							<td class="bz-edit-data-value">
								<BZ:input field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" prefix="P_" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle"><font color="red" id="ff">*</font>Ů������</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="FEMALE_NAME" id="P_FEMALE_NAME" prefix="P_" type="String"  formTitle="Ů��" defaultValue="" style="width:75%" maxlength="150"/>
							</td>
							<td class="bz-edit-data-title"><font color="red" id="ffcs">*</font>��������</td>
							<td class="bz-edit-data-value">
								<BZ:input field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" prefix="P_" type="date" dateExtend="maxDate:'%y-%M-%d'"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="REG_REMARK" id="P_REG_REMARK" type="textarea" prefix="P_" formTitle="��ע" defaultValue=""  style="width:75%" maxlength="500"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�Ƿ�¼��Ʊ����Ϣ</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:radio field="ISPIAOJU"  prefix="P_" formTitle="�Ƿ�¼��Ʊ����Ϣ" value="0" defaultChecked="true" onclick="_dyShowPjInfo()"/>��
								<BZ:radio field="ISPIAOJU"  prefix="P_" formTitle="�Ƿ�¼��Ʊ����Ϣ" value="1" onclick="_dyShowPjInfo()"/>��
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div> 
		<!-- �༭����end -->
		<br/>
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" id="pjInfo" style="display:none">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ʊ����Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="COST_TYPE" formTitle="" prefix="P_" isCode="true" codeName="FYLB" defaultValue="10" disabled="true" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>Ӧ�ɷ���</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input field="PAID_SHOULD_NUM" id="P_PAID_SHOULD_NUM" prefix="P_" type="String" restriction="number"  formTitle="Ʊ����" defaultValue="" style="width:67%" />
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�ɷѷ�ʽ</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="PAID_WAY"  formTitle="" prefix="P_" isCode="true" codeName="JFFS" width="70%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>Ʊ����</td>
							<td class="bz-edit-data-value">
								<BZ:input field="PAR_VALUE" id="P_PAR_VALUE" prefix="P_" type="String" restriction="number"  formTitle="Ʊ����" defaultValue="" style="width:67%"/>
							</td>
							<td class="bz-edit-data-title">�ɷ�Ʊ��</td>
							<td class="bz-edit-data-value">
								<BZ:input field="BILL_NO" prefix="P_" type="String"  formTitle="�ɷ�Ʊ��" defaultValue="" style="width:67%"/>
							</td>
							<td class="bz-edit-data-title">�ɷ�ƾ��</td>
							<td class="bz-edit-data-value">
								<up:uploadBody 
									attTypeCode="OTHER" 
									bigType="FAM"
									smallType="<%=AttConstants.FAW_JFPJ %>"
									id="P_FILE_CODE" 
									name="P_FILE_CODE"
									packageId="<%=cheque_id %>" 
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="class_code=FAM"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
									/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�ɷѱ�ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input field="REMARKS" id="P_REMARKS" type="textarea" prefix="P_" formTitle="�ɷѱ�ע" maxlength="500" style="width:80%" defaultValue=""/>
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
				<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="��һ��" class="btn btn-sm btn-primary" onclick="_goup()"/>
				<input type="button" value="ȡ��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
