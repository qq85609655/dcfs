<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: wjdl_handreg.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-8-7 ����13:57:23
 * @version V1.0   
 */
   
    /******Java���빦������Start******/
 	//�������ݶ���
	Data wjdlData = new Data();
	request.setAttribute("wjdlData",wjdlData);
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java���빦������End******/
	
	//��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	String paidNum = (String)request.getAttribute("paidNum");
	
	//��ȡ������ϢID
	String cheque_id = (String)request.getAttribute("CHEQUE_ID");
%>
<BZ:html>

<BZ:head language="CN">
	<title>�ļ��ֹ��Ǽ�</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
</BZ:head>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
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
			
			//�ж��ļ���Ϣ�Ƿ�Ϊ��
			var infoNum = document.getElementsByName("P_COUNTRY_CODE");
			if (infoNum.length < 1){
				alert("������������һ���ļ���Ϣ��");
				return;
			}
			
			//ͨ�������б�ѡ��������ֶθ�ֵ
			var temp1 = $("#P_COUNTRY_CODE").find("option:selected").text();
			var temp2 = $("#P_ADOPT_ORG_ID").find("option:selected").text();
			$("#P_COUNTRY_CN").val(temp1);//����CN
			$("#P_NAME_CN").val(temp2);//��֯CN
			
			//ֻ�������б�����Ϊ�ɱ༭��Ŀ��Ϊ�˺�̨��ô�����
			$("#P_PAID_SHOULD_NUM").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			
			//���ύ
			var obj = document.forms["srcForm"];
			obj.action=path+'ffs/registration/saveFileHandReg.action';
			obj.submit();
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'ffs/registration/findList.action';
	}
	
	//ɾ��ѡ����ļ���Ϣ
	function _deleteRow() {
		var num = 0;
		var totalCost = $("#P_PAID_SHOULD_NUM").val();
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				var tempCost = arrays[i].value;
				totalCost=Number(totalCost)-Number(tempCost);
				num += 1;
			}
		}
		if(num == 0){
			alert("��ѡ����Ҫɾ������Ϣ��");
			return;
		}
		if(confirm("ȷ��ɾ�������ļ���Ϣ��")){
			if(arrays.length - num < 1){
				alert("������������һ���ļ���Ϣ��");
				return;
			}else{
				
				
				$("#P_PAID_SHOULD_NUM").val(totalCost);//��̬����Ӧ�ɷ���
				$(':checkbox[name=xuanze]').each(function(){
					if($(this).attr('checked')){
						$(this).closest('tr').remove();
					}
				});
			}
		}
	}
	
	//�����������ͣ���̬����Ů�������������ڽ���ֻ���ͱ���������
	function _dynamicHide(){
		var optionText = $("#P_FAMILY_TYPE").find("option:selected").text();
		if(optionText=="����������Ů��"){
			//��̬��ʾ�������*
			$("#nf").hide();
			$("#nfcs").hide();
			$("#ff").show();
			$("#ffcs").show();
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
		}else if(optionText=="�����������У�"){
			//��̬��ʾ�������*
			$("#nf").show();
			$("#nfcs").show();
			$("#ff").hide();
			$("#ffcs").hide();
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
		}else if(optionText=="˫������"){
			//��̬��ʾ�������*
			$("#nf").show();
			$("#nfcs").show();
			$("#ff").show();
			$("#ffcs").show();
			//�Ƴ���Ů����������������Ϊֻ������
			$("#P_MALE_NAME").attr("disabled",false);
			$("#P_MALE_BIRTHDAY").attr("disabled",false);
			$("#P_FEMALE_NAME").attr("disabled",false);
			$("#P_FEMALE_BIRTHDAY").attr("disabled",false);
			//�����з���������������Ϊ������
			$("#P_MALE_NAME").attr("notnull","�������з�����");
			$("#P_MALE_BIRTHDAY").attr("notnull","�������з���������");
			$("#P_FEMALE_NAME").attr("notnull","������Ů����������");
			$("#P_FEMALE_BIRTHDAY").attr("notnull","������Ů����������");
		}
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
</script>

<BZ:body codeNames="GJSY;WJLX_DL;WJLX;FYLB;JFFS;FWF;SYZZ" property="wjdlData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_CN"/>
		<BZ:input type="hidden" prefix="P_" field="COUNTRY_EN"/>
		<BZ:input type="hidden" field="ISPIAOJUVALUE" prefix="P_" id="P_ISPIAOJUVALUE"/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>���Ǽ��ļ���Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" style="text-align: right; border-right:none;">
							</td>
							<td class="bz-edit-data-title" width="75%" style="text-align: right; border-left:none; border-right:none;">
							</td>
							<td class="bz-edit-data-title" width="5%" style="text-align: left; border-left:none;">
								<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_deleteRow()"/>
							</td>
						</tr>
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table table-striped table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
										<tr style="background-color: rgb(180, 180, 249);">
											<th style="width: 3%; text-align: center; border-left: 0;">
												<div class="sorting_disabled">
													<input type="checkbox" class="ace">
												</div>
											</th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="AF_SEQ_NO">��ˮ��</div></th>
											<th style="width: 6%; text-align: center;">
												<div class="sorting_disabled" id="COUNTRY_CODE">����</div></th>
											<th style="width: 15%; text-align: center;">
												<div class="sorting_disabled" id="ADOPT_ORG_ID">������֯</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="FILE_TYPE">�ļ�����</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="FAMILY_TYPE">��������</div></th>
											<th style="width: 13%; text-align: center;">
												<div class="sorting_disabled" id="MALE_NAME">�з�</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="MALE_BIRTHDAY">�г�������</div></th>
											<th style="width: 13%; text-align: center;">
												<div class="sorting_disabled" id="FEMALE_NAME">Ů��</div></th>
											<th style="width: 10%; text-align: center;">
												<div class="sorting_disabled" id="FEMALE_BIRTHDAY">Ů��������</div></th>
										</tr>
									</thead>
									<tbody>
										<BZ:for property="List" fordata="fordata">
											<script type="text/javascript">
												<%
												String file_type = ((Data)pageContext.getAttribute("fordata")).getString("FILE_TYPE","");
												String male_name = ((Data)pageContext.getAttribute("fordata")).getString("MALE_NAME","");
												String female_name = ((Data)pageContext.getAttribute("fordata")).getString("FEMALE_NAME","");
												%>
											</script>
											<tr>
												<td class="center">
													<input name="xuanze" type="checkbox" class="ace" value="<BZ:data field="AF_COST" onlyValue="true"/>">
													<BZ:input prefix="P_" field="AF_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="RI_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="CI_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="AF_COST" type="hidden" property="fordata" />
												</td>
												<td><BZ:data field="AF_SEQ_NO" defaultValue="" onlyValue="true"/></td>
												<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/>
													<BZ:input prefix="P_" field="COUNTRY_CODE" type="hidden" property="fordata" /></td>
												<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
													<BZ:input prefix="P_" field="ADOPT_ORG_ID" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="NAME_CN" type="hidden" property="fordata" />
													<BZ:input prefix="P_" field="NAME_EN" type="hidden" property="fordata" /></td>
												<%
													if("10".equals(file_type)||"30".equals(file_type)||"31".equals(file_type)||"32".equals(file_type)||"34".equals(file_type)||"35".equals(file_type)){
												%>
												<td>
													<BZ:select field="FILE_TYPE" id="P_FILE_TYPE"  isCode="false" notnull="�������ļ�����" formTitle="" prefix="P_" property="fordata" width="95%">
														<BZ:option value="10">����</BZ:option>
														<BZ:option value="30">�쵼����</BZ:option>
														<BZ:option value="31">����</BZ:option>
														<BZ:option value="32">�ڻ�</BZ:option>
														<BZ:option value="34">��������</BZ:option>
														<BZ:option value="35">����</BZ:option>
													</BZ:select>
												</td>
												<%
													}else{
												%>
												<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/>
												<BZ:input prefix="P_" field="FILE_TYPE" type="hidden" property="fordata" /></td>
												<%
													}
												%>
												<td><BZ:data field="FAMILY_TYPE" defaultValue="" onlyValue="true" checkValue="1=˫������;2=��������;"/></td>
												<%
													if(!"".equals(male_name)){
												%>
												<td><BZ:input field="MALE_NAME" id="P_MALE_NAME" prefix="P_" type="String"  formTitle="�з�" property="fordata" defaultValue="" style="width:93%" maxlength="150"/></td>
												<td><BZ:input field="MALE_BIRTHDAY" id="P_MALE_BIRTHDAY" prefix="P_" property="fordata" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/></td>
												<%
													}else{
												%>
												<td><BZ:input prefix="P_" field="MALE_NAME" defaultValue="" type="hidden" property="fordata" /></td>
												<td><BZ:input prefix="P_" field="MALE_BIRTHDAY" defaultValue="" type="hidden" property="fordata" /></td>
												<%
													}
													if(!"".equals(female_name)){
												%>
												<td><BZ:input field="FEMALE_NAME" id="P_FEMALE_NAME" prefix="P_" type="String"  formTitle="Ů��" property="fordata" defaultValue="" style="width:93%" maxlength="150"/></td>
												<td><BZ:input field="FEMALE_BIRTHDAY" id="P_FEMALE_BIRTHDAY" prefix="P_" property="fordata" style="width:92%" type="date" dateExtend="maxDate:'%y-%M-%d'"/></td>
												<%
													}else{
												%>
												<td><BZ:input prefix="P_" field="FEMALE_NAME" defaultValue="" type="hidden" property="fordata" /></td>
												<td><BZ:input prefix="P_" field="FEMALE_BIRTHDAY" defaultValue="" type="hidden" property="fordata" /></td>
												<%
													}
												%>
											</tr>
										</BZ:for>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">�Ƿ�¼��Ʊ����Ϣ</td>
							<td class="bz-edit-data-value" colspan="4">
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
								<BZ:input field="PAID_SHOULD_NUM" id="P_PAID_SHOULD_NUM" prefix="P_" formTitle="Ӧ�ɷ���" defaultValue="<%=paidNum%>" style="width:67%"/>
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
									bigType="<%=AttConstants.FAM %>"
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
				<input type="button" value="�Ǽ�" class="btn btn-sm btn-primary" onclick="_submit()"/>
				<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:form>
</BZ:body>
</BZ:html>
