<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="hx.database.databean.DataList"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	Data data = (Data)request.getAttribute("data"); 
	String specil="";
	String ishope=data.getString("IS_HOPE",null);
	String isplan=data.getString("IS_PLAN",null);
	if("1".equals(ishope)){
		specil+=" ϣ��֮��";
	}
	if("1".equals(isplan)){
		specil+=" ����ƻ�";
	}
	//��˼���
	String audit_type=data.getString("AUDIT_TYPE",null);
	//������˼�¼����
	String cua_id=data.getString("CUA_ID",null);
	//���¼�¼����
	String cui_id=data.getString("CUI_ID",null);
	//��ͯ������Ϣ����
	String ci_id=data.getString("CI_ID",null);
	 //��ȡС��
	String smTypeUsed=(String)request.getAttribute("smTypeUsed"); 
	String smTypeUsedStr=(String)request.getAttribute("smTypeUsedStr"); 
	String updateTypes=(String)request.getAttribute("updateTypes"); 
	System.out.println("smTypeUsed"+smTypeUsed);
	System.out.println("smTypeUsedStr"+smTypeUsedStr);
	System.out.println("updateTypes"+updateTypes);
	String packageId="N"+(String)data.getString("FILE_CODE",ci_id);
	System.out.println("packageId:"+packageId);
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";ci_id=" + ci_id;
	System.out.println("org_af_id:"+org_af_id);
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ���ϸ������ҳ��</title>
		<BZ:webScript edit="true" list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			_initData();	
		});
		function addCheckOpinion(){
		     var valueStr=$("#S_AUDIT_OPTION").find("option:selected").val();
			 if(valueStr !=""){
			 $("#S_AUDIT_CONTENT").text($("#S_AUDIT_OPTION").find("option:selected").text());
			 }else{
			 $("#S_AUDIT_CONTENT").text("");
			  }
		}
	   function _goback(audit_type){
				if(audit_type=='2'){
					document.srcForm.action = path+"cms/childupdate/updateAuditListSt.action";
					document.srcForm.submit();
				  }else if(audit_type=='3'){
					document.srcForm.action = path+"cms/childupdate/updateAuditListZX.action";
					document.srcForm.submit();
					}
		}
	   function _submit(){
		   //���¸����Ƿ�Ϊ��У��
		    if(document.getElementById("smTypeUsed").value!="null"&&document.getElementById("smTypeUsed").value!=""){
				 for(var i=0;i<smTypeUsed.length;i++){
	            	 var iframe=window.frames["a"+smTypeUsed[i]];
	                 var table = iframe.document.getElementById("infoTable"+"a"+smTypeUsed[i]);
	                 var trs=table.rows;
	            		var trsLen = trs.length;
	                 if(trsLen == 0){
	                     alert("���ϴ�'"+smTypeUsedStr[i]+"'�ĸ��¸���");
	                     return;
	                 }
	                 if(trsLen > 0){
		                    var tds = trs[0].cells;
		                    var succ = tds[2].innerHTML;
		                    if(succ == "" || succ.indexOf("OK") < 0){
		                    	alert("���ϴ�'"+smTypeUsedStr[i]+"'�ĸ��¸���");
	                          return;
		                    }
	                 }
				}
		    }
		   document.srcForm.action = path+"cms/childupdate/saveUpdateAudit.action";
		   document.srcForm.submit();
	    }
	   //��ʼ�����
	   function _initData(){
		    smTypeUsed=document.getElementById("smTypeUsed").value.split(',');
		    smTypeUsedStr=document.getElementById("smTypeUsedStr").value.split(',');
		    var updateTypes=document.getElementById("updateTypes").value.split(',');
			var packageId=document.getElementById("packageId").value;
			var org_af_id=document.getElementById("org_af_id").value;
			var attPath=path+"cms/childupdate/updateAtt.action";
            //��������smTypeUsed��ʼ���������
            if(document.getElementById("smTypeUsed").value!="null"&&document.getElementById("smTypeUsed").value!=""){
            	for(var i=0;i<smTypeUsed.length;i++){
                    var firsCode=smTypeUsed[i];
                    var firsStr=smTypeUsedStr[i];
                    var updateType=updateTypes[i];//�������� 0Ϊ���� 1Ϊ׷��
                    var newTr=$("<tr>");
     				var newHtml="<td style='text-align: left;padding-left: 6px'><input name='smalltype' id='s"+firsCode+"' value='"+firsCode+"' type='hidden'/>"+firsStr+"</td>";
     				newHtml+=("<td>"+"<iframe src='"+attPath+"?packageId="+packageId+"&uploadId="+"a"+firsCode+"&smallType="+firsCode+"&org_af_id="+org_af_id+"' id='"+"a"+firsCode+"' style='height:90px;width:100%;' frameborder='0' marginwidth='0' marginheight='0'></iframe>"+"</td>");
                    if(updateType=='1'){
                    	newHtml+=("<td><select name='updatetype'><option value='1'>׷��</option><option value='0'>����</option></select></td>");
                    }else{
                    	newHtml+=("<td><select name='updatetype'><option value='0'>����</option><option value='1'>׷��</option></select></td>");
                    }
                    // alert(newHtml);
     				newTr.html(newHtml);
     				$("#attTable").append(newTr);
                 }
            }
            
	}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;BCZL;ETSFLX;TXGXXM;CHILD_TYPE;CHILD_STATE;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<input name="CI_ID" id="CI_ID" type="hidden" value="<%=ci_id%>"/>
		<input name="CUI_ID" id="CUI_ID" type="hidden" value="<%=cui_id%>"/>
		<input name="CUA_ID" id="CUA_ID" type="hidden" value="<%=cua_id%>"/>
		<input name="AUDIT_TYPE" id="AUDIT_TYPE" type="hidden" value="<%=audit_type%>"/>
		<input  id="smTypeUsed" type="hidden" value="<%=smTypeUsed%>"/>
		<input  id="smTypeUsedStr" type="hidden" value="<%=smTypeUsedStr%>"/>
		<input  id="updateTypes" type="hidden" value="<%=updateTypes%>"/>
		<input id="packageId" type="hidden" value="<%=packageId%>"/>
	    <input id="org_af_id" type="hidden" value="<%=org_af_id%>"/>
		<!-- ��������end -->
		
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px" >��ͯ���</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="CHILD_NO" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px"  >ʡ��</td>
							<td class="bz-edit-data-value" width="16%">
							    <BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px" >����Ժ</td>
							<td class="bz-edit-data-value" width="20%">
							    <BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >�Ա�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >��������</td>
							<td class="bz-edit-data-value">
							    <BZ:dataValue field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >��ͯ���</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_IDENTITY" codeName="ETSFLX" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >��ͯ����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >����</td>
							<td class="bz-edit-data-value">
							<%=specil%>
							</td>
						</tr>
						 <tr>
						    <td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >��ͯ״̬</td>
							<td class="bz-edit-data-value">
							    <BZ:dataValue field="AUD_STATE" codeName="CHILD_STATE" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >��������</td>
							<td class="bz-edit-data-value" colspan="3">
							    <BZ:dataValue field="SN_TYPE" codeName="BCZL" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >�������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DISEASE_CN" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class=" clearfix" style="width:100%;margin-left: 0px;margin-right: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" >
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div align="left">&nbsp;���뵥λ��<BZ:dataValue field="ORG_NAME" onlyValue="true" defaultValue=""/>&nbsp;&nbsp;�����ˣ�<BZ:dataValue field="UPDATE_USERNAME" onlyValue="true" defaultValue=""/>&nbsp;&nbsp;�������ڣ�<BZ:dataValue field="UPDATE_DATE" type="Date" onlyValue="true" defaultValue=""/> </div>
				</div>
		   </div>
		 </div>
		 <div class="page-content">
			  <div class="wrapper">
					
					<!-- �������� begin -->
				
							<div class="table-responsive">
							   <%if(((DataList)request.getAttribute("updateList")).size()>0){ %>
			                    <table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
									<thead>
										<tr>
											<th style="width: 30%;">
												<div class="sorting" id="UPDATE_FIELD">������Ŀ</div>
											</th>
											<th style="width: 35%;">
												<div class="sorting" id="ORIGINAL_DATA">ԭ����</div>
											</th>
											<th style="width: 35%;">
												<div class="sorting" id="UPDATE_DATA">��������</div>
											</th>
										</tr>
									</thead>
									<tbody>
									<BZ:for property="updateList" fordata="myData">
							        <%
											Data dat = (Data) pageContext.getAttribute("myData");
											String updateField=dat.getString("UPDATE_FIELD");
											//String updateData=dat.getString("UPDATE_DATA");
										%>
										<tr class="emptyData">
											<td><BZ:data field="UPDATE_FIELD" codeName="TXGXXM" defaultValue=""  onlyValue="true"/></td>
											<%if("CHECKUP_DATE".equals(updateField)){ %>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NCHECKUP_DATE" type="Date" defaultValue=""  />
											  </td>
											<%}else if("ID_CARD".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NID_CARD" defaultValue=""  style="width: 80%" />
											  </td>
											<%}else if("SENDER".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NSENDER" defaultValue=""  style="width: 80%" />
											  </td>
											<%}else if("SENDER_ADDR".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NSENDER_ADDR" defaultValue=""  style="width: 80%" />
											  </td>
											<%}else if("PICKUP_DATE".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NPICKUP_DATE" type="Date" defaultValue=""  />
											  </td>
											<%}else if("ENTER_DATE".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NENTER_DATE" type="Date" defaultValue=""  />
											  </td>
											<%}else if("SEND_DATE".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NSEND_DATE" type="Date" defaultValue=""  />
											  </td>
											<%}else if("IS_ANNOUNCEMENT".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  checkValue="0=��;1=��;" defaultValue=""  onlyValue="true"/></td>
											  <td><BZ:select prefix="N_" field="NIS_ANNOUNCEMENT"  formTitle="" defaultValue="" width="45%">
													<BZ:option value="">--��ѡ��--</BZ:option>
													<BZ:option value="1">��</BZ:option>
													<BZ:option value="0">��</BZ:option>
												 </BZ:select>
											  </td>
											<%}else if("ANNOUNCEMENT_DATE".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NANNOUNCEMENT_DATE" type="Date" defaultValue=""  />
											  </td>
											<%}else if("NEWS_NAME".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td><BZ:input prefix="N_" field="NNEWS_NAME" defaultValue=""  style="width: 80%" />
											  </td>
											<%}else if("SN_TYPE".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
											  <td><BZ:select prefix="N_" field="NSN_TYPE"  isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="60%">
											        <BZ:option value="">--��ѡ��--</BZ:option>
									              </BZ:select>
											  </td>
											<%}else if("DISEASE_CN".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  defaultValue="" onlyValue="true"/></td>
											  <td>
											    <BZ:input  type="textarea" prefix="N_" field="NDISEASE_CN" defaultValue=""
							                        formTitle="�������" maxlength="1000" style="width:100%;height:50px"/>
											  </td>
											<%}else if("IS_PLAN".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  checkValue="0=��;1=��;" defaultValue=""  onlyValue="true"/></td>
											  <td><BZ:select prefix="N_" field="NIS_PLAN"  formTitle="" defaultValue="" width="45%">
													<BZ:option value="">--��ѡ��--</BZ:option>
													<BZ:option value="1">��</BZ:option>
													<BZ:option value="0">��</BZ:option>
 												 </BZ:select>
											  </td>
											<%}else if("IS_HOPE".equals(updateField)) {%>
											  <td><BZ:data field="ORIGINAL_DATA"  checkValue="0=��;1=��;" defaultValue=""  onlyValue="true"/></td>
											  <td><BZ:select prefix="N_" field="NIS_HOPE"  formTitle="" defaultValue="" width="45%">
													<BZ:option value="">--��ѡ��--</BZ:option>
													<BZ:option value="1">��</BZ:option>
													<BZ:option value="0">��</BZ:option>
 												 </BZ:select>
											  </td>
											<%}%>
										</tr>
									</BZ:for>
								</tbody>
							</table>
							<%}%>
							<%if(!"".equals(smTypeUsed)&&!"null".equals(smTypeUsed)&&smTypeUsed.split(",").length>0){ %>
							<table class="table table-striped table-bordered table-hover " adsorb="both" init="true" id="attTable">
							<thead>
								<tr>
									<th style="width: 30%;">
										<div >������Ŀ</div>
									</th>
									<th style="width: 35%;">
										<div >�ϴ�����</div>
									</th>
									<th style="width: 35%;">
										<div >��������</div>
									</th>
								</tr>
							</thead>
							<tbody>
	                        </tbody>
					        </table>
					        <%} %>
					    </div>
				</div>
		</div>
						
		
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" style="padding: 5px;">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�������</div>
				</div>
		   <!-- ��������  -->
		   <div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px" >�����</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="AUDIT_USERNAME" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px" >�������</td>
							<td class="bz-edit-data-value" width="16%">
							    <BZ:dataValue field="AUDIT_DATE" type="Date" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px" >��˽��</td>
							<td class="bz-edit-data-value" width="20%">
							    <BZ:select prefix="S_" field="AUDIT_OPTION" id="S_AUDIT_OPTION" formTitle="" defaultValue="1"  onchange="addCheckOpinion();" >
										<BZ:option value="1">ͨ��</BZ:option>
										<BZ:option value="0">��ͨ��</BZ:option>
									</BZ:select>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input  type="textarea" prefix="S_" field="AUDIT_CONTENT" id="S_AUDIT_CONTENT" defaultValue="ͨ��"
							       formTitle="������" maxlength="500" style="width:100%;height:50px"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px" >��ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input  type="textarea" prefix="S_" field="AUDIT_REMARKS" id="S_AUDIT_REMARKS" defaultValue=""
							       formTitle="��ע" maxlength="1000" style="width:100%;height:50px"/>
							</td>
						</tr>
					</table>
				</div>
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="ȷ ��" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="ȡ ��" class="btn btn-sm btn-primary" onclick="_goback(<%=audit_type %>);"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>