<%
/**   
 * @Title: preApproveapply_resive.jsp
 * @Description:  Ԥ�������޸�ҳ��
 * @author yangrt   
 * @date 2014-9-14 ����10:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="hx.database.databean.DataList"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ page import="com.dcfs.cms.ChildInfoConstants" %>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data"); 
	String ci_id = (String)data.getString("CI_ID");
	String child_type=(String)data.getString("CHILD_TYPE");
	String aud_state=(String)data.getString("AUD_STATE");
	String  update_type = (String)request.getAttribute("UPDATE_TYPE"); 
	//��ȡС��
	String pakgId=(String)request.getAttribute("pakgId"); 
	String smTypeValues=(String)request.getAttribute("smTypeValues"); 
	String smTypeStrs=(String)request.getAttribute("smTypeStrs"); 
	System.out.println("smallType"+smTypeValues);
	System.out.println("smallTypeStr"+smTypeStrs);
	String packageId="N"+(String)data.getString("FILE_CODE",ci_id);
	System.out.println("packageId:"+packageId);
	String org_af_id = "org_id=" + (String)request.getAttribute("ORG_CODE") + ";ci_id=" + ci_id;
	System.out.println("org_af_id:"+org_af_id);
	
%>
<BZ:html>
	<BZ:head>
	    <up:uploadResource isImage="true"/>
		<title>��ͯ���ϸ�������ҳ��</title>
		<BZ:webScript edit="true" list="true"/>
		
		<link href="<%=path %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/resource/js/easytabs/jquery.easytabs.js"></script>
		<script type="text/javascript" src="<%=path %>/resource/js/page.js"></script>
		<script>
			//�����б�ҳ��
			function _goback(update_type){
				if(update_type=='1'){
					window.location.href=path+'/cms/childupdate/updateListFLY.action';
				}else if(update_type=='2'){
					window.location.href=path+'/cms/childupdate/updateListST.action';
				}else if(update_type=='3'){
					window.location.href=path+'/cms/childupdate/updateSelectZX.action';
				}
			}
			//���������������Ҫѡ��λ
			function _checkSelect(){
				var checkVal=document.getElementById("N_RESULT").value;
				if(checkVal==""){
					alert("��ѡ���ύ��λ��");
					return;
				}else{
					_submit(checkVal);
				}

			}
			//�ύ������
			function _submit(update_state){
				if(document.getElementById("smallTypeCode").value!=""&&document.getElementById("smallTypeCode").value!="null"){
					//���¸����Ƿ�Ϊ��У��
					 for(var i=0;i<smTypeValues.length;i++){
	                   	if(smTypeSigle[i]=='1'){
	                   		var iframe=window.frames["a"+smTypeValues[i]];
	                   		var table = iframe.document.getElementById("infoTable"+"a"+smTypeValues[i]);
	                        var trs=table.rows;
	                   		var trsLen = trs.length;
	                        if(trsLen == 0){
	                            alert("���ϴ�'"+smTypeStrs[i]+"'�ĸ��¸���");
	                            return;
	                        }
	                        if(trsLen > 0){
			                    var tds = trs[0].cells;
			                    var succ = tds[2].innerHTML;
			                    if(succ == "" || succ.indexOf("OK") < 0){
			                    	alert("���ϴ�'"+smTypeStrs[i]+"'�ĸ��¸���");
		                            return;
			                    }
	                        }
	                    }
					 }
				}
				document.getElementById("UPDATE_STATE").value = update_state;
				document.srcForm.action=path+"cms/childupdate/saveUpdateData.action";
				document.srcForm.submit();
			}
			//��Ӹ�����Ŀ��ť
			function _addAtt(){
				 if(document.getElementById("smallTypeCode").value==""||document.getElementById("smallTypeCode").value=="null"){
                   alert("�ö�ͯ����û����ظ���");
                   return;
				  }
				 //���ж����еĸ�����Ŀ�ǲ����Ѿ������ڣ����������������������µĸ�����Ŀ
				  var first=0;
				  var firstCode="";
				  var firstStr="";
				  var i=0;
				  for(;i<smTypeSigle.length;i++){
					  if(smTypeSigle[i]=='0'){
						   first=i;
						   firstCode=smTypeValues[i];
						   firstStr=smTypeStrs[i];
						   smTypeSigle[i]='1';
						   break;
						  }
					  }
				  if(i==smTypeSigle.length){
	                  alert("������Ŀ�������");
	                  return;
					  }
					var newTr=$("<tr>");
					var newHtml="<td ><select name='smalltype' id='s"+firstCode+"' onchange='_changeSmType(this);'>";
					newHtml+=("<option value='"+firstCode+"'>"+firstStr+"</option>");
					for(var i=(first+1);i<smTypeValues.length;i++){
						if(smTypeSigle[i]=='0'){
							newHtml+=("<option value='"+smTypeValues[i]+"'>"+smTypeStrs[i]+"</option>");
							}
						}
					newHtml+=("</select></td><td>"+"<iframe src='"+attPath+"?packageId="+packageId+"&uploadId="+"a"+firstCode+"&smallType="+firstCode+"&org_af_id="+org_af_id+"' id='"+"a"+firstCode+"' style='height:90px;width:100%;' frameborder='0' marginwidth='0' marginheight='0'></iframe>"+"</td>");
					newHtml+=("<td><select name='updatetype'><option value='1'>׷��</option><option value='0'>����</option></select></td>");
					newHtml+=("<td><input type='button' name='"+firstCode+"' value='ɾ��' class='btn btn-sm btn-primary' onclick='_deleteRow(this);'/></td>");
	                //alert(newHtml);
					newTr.html(newHtml);
					$("#attTable").append(newTr);
				}
		   //�鿴ԭ������Ϣ
		   function _showOldAtt(){
			   if(document.getElementById("smallTypeCode").value==""||document.getElementById("smallTypeCode").value=="null"){
                   alert("�ö�ͯ����û����ظ���");
                   return;
				  }
                var url='<%=path%>/common/batchattmaintain.action?bigType=CI&packID=<%=pakgId%>&packageID=<%=(String)data.getString("FILE_CODE")%>';
                _open(url, "window", 1000, 500);
			   }
		  //������Ŀ����ѡ�����ݸı��¼�
		   function _changeSmType(obj){
			   //�ж���ѡ�ĸ�����Ŀ�Ƿ��Ѿ����ڣ������������ʾ�ø�����Ŀ�Ѿ����ڣ�����ǰѡ�����ݸ�Ϊδ��ӹ��ĸ�����Ŀ�еĵ�һ��
			   var smType=obj.value;
			   var location=0;//�����������¼��ѡ������Ӧ���±�
			   for(var i=0;i<smTypeValues.length;i++){
                    if(smType==smTypeValues[i]){
                    	location=i;
                    	if(smTypeSigle[i]=='1'){
                             alert("�ø�����Ŀ�Ѿ����ڣ�������ѡ�������Ŀ");
                             obj.value=obj.parentNode.parentNode.lastChild.firstChild.name;
                             return;
                       	}
                   	   break;
                   }
			   }
			   //��ԭ��ѡ�����Ŀ��Ӧ����ӱ�־��Ϊ'1'
			    var smTypeCode=obj.parentNode.parentNode.lastChild.firstChild.name;
			    for(var i=0;i<smTypeValues.length;i++){
				    if(smTypeCode==smTypeValues[i]){
				    	smTypeSigle[i]='0';
				    	break;
					    }
				    }
				var firstCode=smType;
			    var firstStr=smTypeStrs[location];
			    smTypeSigle[location]='1';
				 obj.id='s'+firstCode;
				 obj.value=firstCode;
			     var ifram=obj.parentNode.nextSibling.firstChild;
			     ifram.id="a"+firstCode;
			     ifram.src=attPath+"?packageId="+packageId+"&uploadId="+"a"+firstCode+"&smallType="+firstCode+"&org_af_id="+org_af_id;
			     var buttn=obj.parentNode.parentNode.lastChild.firstChild;
			     buttn.name=firstCode;
			   }
		   //��ʼ�����
		   function _initData(){
			    smTypeValues=document.getElementById("smallTypeCode").value.split(',');
				smTypeStrs=document.getElementById("smallTypeStr").value.split(',');
				smTypeSigle=new Array();
				packageId=document.getElementById("packageId").value;
				org_af_id=document.getElementById("org_af_id").value;
				attPath=path+"cms/childupdate/updateAtt.action";
				for(var i=0;i<smTypeValues.length;i++){
					smTypeSigle[i]='0';
					}
				/*smTypeSigle[0]='1';��������ѡ���Ĭ��û�и�����Ŀ�����������������Ӹ�����Ŀ����ť������ӣ�
				if(document.getElementById("smallTypeCode").value!=""&&document.getElementById("smallTypeCode").value!="null"){
					var newTr=$("<tr>");
					var newHtml="<td ><select name='smalltype' id='s"+smTypeValues[0]+"' onchange='_changeSmType(this);'>";
					for(var i=0;i<smTypeValues.length;i++){
						newHtml+=("<option value='"+smTypeValues[i]+"'>"+smTypeStrs[i]+"</option>");
						}
					newHtml+=("</select></td><td>"+"<iframe src='"+attPath+"?packageId="+packageId+"&uploadId="+"a"+smTypeValues[0]+"&smallType="+smTypeValues[0]+"&org_af_id="+org_af_id+"' id='"+"a"+smTypeValues[0]+"' style='height:40px;' frameborder='0' marginwidth='0' marginheight='0'></iframe>"+"</td>");
					newHtml+=("<td><select name='updatetype'><option value='1'>׷��</option><option value='0'>����</option></select></td>");
					newHtml+=("<td><input type='button' name='"+smTypeValues[0]+"' value='ɾ��' class='btn btn-sm btn-primary' onclick='_deleteRow(this);'/></td>");
	               // alert(newHtml);
					newTr.html(newHtml);
					$("#attTable").append(newTr);
				}*/
				
			   }
		   //ɾ��������Ŀ�¼�����������
		   function _deleteRow(obj){
			    var smTypeCode=obj.name;
			    for(var i=0;i<smTypeValues.length;i++){
				    if(smTypeCode==smTypeValues[i]){
				    	smTypeSigle[i]='0';
				    	break;
					    }
				    }
				$(obj).parent("td").parent("tr").remove(); 
			}
		   //ɾ��������Ŀ�¼���������Ϣ����
		   function _deleteRowf(obj){
				$(obj).parent("td").parent("tr").remove(); 
			}
		   function _checkRepeat(obj){
               var selectValue=obj.value;
               var trId="T"+selectValue;
               if(selectValue!=""){
              	 if(document.getElementById(trId)){
                       alert("�ø�����Ŀ�Ѵ���,������ѡ��");
                       return;
                   }
               }
			}
			//��Ӹ�����Ŀ�¼���������Ϣ����
		   function _addBasicInfo(){
			   var selectValue=document.getElementById("P_GXXM").value;
             var trId="T"+selectValue;
             if(selectValue==""){
                alert("��ѡ�������Ŀ");
                return;  
              }else{
              	 if(document.getElementById(trId)){
                       alert("�ø�����Ŀ�Ѵ���,������ѡ��");
                       return;
                   }else{
                  	 var newTr=$("<tr id='"+trId+"'>");
                  	 var td1=$("#"+selectValue+"1").html();
                  	 var td2=$("#"+selectValue+"2").html();
                  	 var td3=$("#"+selectValue+"3").html();
                  	 var td4=$("#"+selectValue+"4").html();
                  	 var trContent=("<td class='center'>"+td1+"</td><td>"+td2+"</td><td>"+td3+"</td><td>"+td4+"</td>");
                  	 newTr.html(trContent);
                  	 $("#basicInfo").append(newTr);
                   }
              }
			}
		</script>
	</BZ:head>
	<BZ:body  property="data" codeNames="BCZL;ZCGXXM;TXGXXM;">
		<script type="text/javascript">
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				$('#tab-container').easytabs();
				_initData();
			});
		</script>
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<input name="CI_ID" id="CI_ID" type="hidden" value="<%=ci_id%>"/>
		<input name="UPDATE_STATE" id="UPDATE_STATE" type="hidden" value="0"/>
		<input name="UPDATE_TYPE" id="UPDATE_TYPE" type="hidden" value="<%=update_type%>"/>
		<!-- ��������end -->
		<div id="tab-container" class='tab-container'>
			<ul class='etabs'>
				<li class='tab'><a href="#tab1">�������ϸ���</a></li>
				<li class='tab'><a href="#tab2">�������ϸ���</a></li>
			</ul>
			<div class='panel-container'>
				<div id="tab1">
				   <table>
				   <td style="width: 10%;" >
				        <%if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(child_type)){%>
					            	 <BZ:select  id="P_GXXM" isCode="true" field="GXXM" codeName="TXGXXM" formTitle="������Ŀ" defaultValue="" width="100px" onchange="_checkRepeat(this);">
										<BZ:option value="">--��ѡ��--</BZ:option>
									 </BZ:select>
				             <%}else if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(child_type)){%>
					            	<BZ:select id="P_GXXM" isCode="true" field="GXXM" codeName="ZCGXXM" formTitle="������Ŀ" defaultValue="" width="100px" onchange="_checkRepeat(this);">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
				             <% } %>
				   </td>
				   <td colspan="3" align="left">
				         <input type="button" value="��Ӹ�����Ŀ" class="btn btn-sm btn-primary" onclick="_addBasicInfo();"/>
				   </td>
				   </table>
			       <br/>
					    <table id="basicInfo" class="table table-striped table-bordered table-hover "  >
						<thead>
							<tr>
								<th style="width: 15%;">
									<div >������Ŀ</div>
								</th>
								<th style="width: 35%;">
									<div >ԭ����</div>
								</th>
								<th style="width: 40%;">
									<div >��������</div>
								</th>
								<th style="width: 10%;">
									<div >����</div>
								</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>	
				<div id="tab2" >
				   <div align="left">
				     <input type="button" value="��Ӹ�����Ŀ" class="btn btn-sm btn-primary" onclick="_addAtt();"/>
				     <input type="button"  value="�鿴ԭ����" class="btn btn-sm btn-primary" onclick="_showOldAtt();"/>
			       </div>
			       <br/>
			       <input id="smallTypeCode" type="hidden" value="<%=smTypeValues%>"/>
			       <input id="smallTypeStr" type="hidden" value="<%=smTypeStrs%>"/>
			       <input id="packageId" type="hidden" value="<%=packageId%>"/>
			       <input id="org_af_id" type="hidden" value="<%=org_af_id%>"/>
			       <table class="table table-striped table-bordered table-hover " adsorb="both" init="true" id="attTable">
							<thead>
								<tr>
									<th style="width: 35%;">
										<div >������Ŀ</div>
									</th>
									<th style="width: 40%;">
										<div >�ϴ�����</div>
									</th>
									<th style="width: 15%;">
										<div >��������</div>
									</th>
									<th style="width: 10%;">
										<div >����</div>
									</th>
								</tr>
							</thead>
							<tbody>
	                        </tbody>
					  </table>
					
				</div>
				<%if("1".equals(update_type)&&("5".equals(aud_state)||"6".equals(aud_state)||"7".equals(aud_state)||"9".equals(aud_state))){ %>
					<table class="specialtable" style='width:100%;text-align:center;line-height:250%;border:0'>
						    <tr>
						    <td class="edit-data-value" style="border:0;">��Ҫ�ύ<BZ:select id="N_RESULT" field="RESULT" formTitle="ѡ���ύ��λ" defaultValue="" width="160px" >
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">ʡ����������������˵�λ</BZ:option>
										<BZ:option value="2">�й���ͯ��������������</BZ:option>
									</BZ:select>
								������� </td>
						    </tr>
						    <tr>
							<td class="edit-data-value" style="border:0;"><b>ע:</b> ���ϸ��������ύʡ����������������˵�λ����ֱ�ӱ����й���ͯ�������������ģ�����ѯ��ʡ��������������˵�λ��</td>
						    </tr>
		        	</table>
		       <%} %>
			</div>
		</div>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit('0');"/>
				<%if("1".equals(update_type)){//����Ժ����ҳ�水ť��ʾ���� %>
				      <%if("1".equals(aud_state)||"2".equals(aud_state)||"4".equals(aud_state)){ %>
				      <input type="button" value="�ύʡ��" class="btn btn-sm btn-primary" onclick="_submit('1');"/>
				     <%}else if("5".equals(aud_state)||"6".equals(aud_state)||"7".equals(aud_state)||"9".equals(aud_state)){ %>
				      <input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_checkSelect();"/>
				     <%}%>
				<%}else if("2".equals(update_type)) {//ʡ������ҳ�水ť��ʾ����%>
				      <input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit('2');"/>
				<% }else if("3".equals(update_type)){//���ĸ����ύ�����״̬��Ϊͨ��%>
				      <input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit('3');"/>
				<% }%>
				<input type="button" value="ȡ ��" class="btn btn-sm btn-primary" onclick="_goback(<%=update_type %>);"/>
			</div>
		</div>
		
		<!-- ��ť����end -->
		</BZ:form>
		 <!-- ��Ӹ�����Ŀʱÿ��������Ŀ����Ӧ��ԭ���ݸ������ݵ���Ϣ-->
						   <div id="CHECKUP_DATE1" style="display: none;">�������</div>
						   <div id="CHECKUP_DATE2" style="display: none;"><BZ:dataValue field="CHECKUP_DATE" type="Date" onlyValue="true" defaultValue=""/></div>
						   <div id="CHECKUP_DATE3" style="display: none;"><BZ:input prefix="N_" field="NCHECKUP_DATE" id="N_CHECKUP_DATE" type="Date" defaultValue="" formTitle="�������" /></div>
						   <div id="CHECKUP_DATE4" style="display: none;"><input type="button"  name="CHECKUP_DATE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="ID_CARD1" style="display: none;">���֤��</div>
						   <div id="ID_CARD2" style="display: none;"><BZ:dataValue field="ID_CARD"  onlyValue="true" defaultValue=""/></div>
						   <div id="ID_CARD3" style="display: none;"><BZ:input prefix="N_" field="NID_CARD" id="N_ID_CARD" defaultValue="" formTitle="���֤��" maxlength="18"/></div>
						   <div id="ID_CARD4" style="display: none;"><input type="button"  name="ID_CARD" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="SENDER1" style="display: none;">������</div>
						   <div id="SENDER2" style="display: none;"><BZ:dataValue field="SENDER"  onlyValue="true" defaultValue=""/></div>
						   <div id="SENDER3" style="display: none;"><BZ:input prefix="N_" field="NSENDER" id="N_SENDER" defaultValue="" formTitle="������" /></div>
						   <div id="SENDER4" style="display: none;"><input type="button"  name="SENDER" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="SENDER_ADDR1" style="display: none;">�����˵�ַ</div>
						   <div id="SENDER_ADDR2" style="display: none;"><BZ:dataValue field="SENDER_ADDR"  onlyValue="true" defaultValue=""/></div>
						   <div id="SENDER_ADDR3" style="display: none;"><BZ:input prefix="N_" field="NSENDER_ADDR" id="N_SENDER_ADDR" defaultValue="" formTitle="�����˵�ַ" style="width: 80%" /></div>
						   <div id="SENDER_ADDR4" style="display: none;"><input type="button"  name="SENDER_ADDR" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="PICKUP_DATE1" style="display: none;">��ʰ����</div>
						   <div id="PICKUP_DATE2" style="display: none;"><BZ:dataValue field="PICKUP_DATE" type="Date" onlyValue="true" defaultValue=""/></div>
						   <div id="PICKUP_DATE3" style="display: none;"><BZ:input prefix="N_" field="NPICKUP_DATE" id="N_PICKUP_DATE" type="Date" defaultValue="" formTitle="��ʰ����" /></div>
						   <div id="PICKUP_DATE4" style="display: none;"><input type="button"  name="PICKUP_DATE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="ENTER_DATE1" style="display: none;">��Ժ����</div>
						   <div id="ENTER_DATE2" style="display: none;"><BZ:dataValue field="ENTER_DATE" type="Date" onlyValue="true" defaultValue=""/></div>
						   <div id="ENTER_DATE3" style="display: none;"><BZ:input prefix="N_" field="NENTER_DATE" id="N_ENTER_DATE" type="Date" defaultValue="" formTitle="��Ժ����" /></div>
						   <div id="ENTER_DATE4" style="display: none;"><input type="button"  name="ENTER_DATE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="SEND_DATE1" style="display: none;">��������</div>
						   <div id="SEND_DATE2" style="display: none;"><BZ:dataValue field="SEND_DATE" type="Date" onlyValue="true" defaultValue=""/></div>
						   <div id="SEND_DATE3" style="display: none;"><BZ:input prefix="N_" field="NSEND_DATE" id="N_SEND_DATE" type="Date" defaultValue="" formTitle="��������" /></div>
						   <div id="SEND_DATE4" style="display: none;"><input type="button"  name="SEND_DATE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="IS_ANNOUNCEMENT1" style="display: none;">��������</div>
						   <div id="IS_ANNOUNCEMENT2" style="display: none;"><BZ:dataValue field="IS_ANNOUNCEMENT"  checkValue="0=��;1=��;"  onlyValue="true" defaultValue=""/></div>
						   <div id="IS_ANNOUNCEMENT3" style="display: none;">
						   			<BZ:select prefix="N_" field="NIS_ANNOUNCEMENT" id="N_IS_ANNOUNCEMENT" formTitle="" defaultValue="" width="45%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select></div>
						   <div id="IS_ANNOUNCEMENT4" style="display: none;"><input type="button"  name="IS_ANNOUNCEMENT" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="ANNOUNCEMENT_DATE1" style="display: none;">��������</div>
						   <div id="ANNOUNCEMENT_DATE2" style="display: none;"><BZ:dataValue field="ANNOUNCEMENT_DATE" type="Date" onlyValue="true" defaultValue=""/></div>
						   <div id="ANNOUNCEMENT_DATE3" style="display: none;"><BZ:input prefix="N_" field="NANNOUNCEMENT_DATE" id="N_ANNOUNCEMENT_DATE" type="Date"  formTitle="��������" /></div>
						   <div id="ANNOUNCEMENT_DATE4" style="display: none;"><input type="button"  name="ANNOUNCEMENT_DATE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="NEWS_NAME1" style="display: none;">��������</div>
						   <div id="NEWS_NAME2" style="display: none;"><BZ:dataValue field="NEWS_NAME" onlyValue="true" defaultValue=""/></div>
						   <div id="NEWS_NAME3" style="display: none;"><BZ:input prefix="N_" field="NNEWS_NAME" id="N_NEWS_NAME" defaultValue="" formTitle="��������" style="width: 80%" /></div>
						   <div id="NEWS_NAME4" style="display: none;"><input type="button"  name="NNEWS_NAME" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="SN_TYPE1" style="display: none;">��������</div>
						   <div id="SN_TYPE2" style="display: none;"><BZ:dataValue field="SN_TYPE"  codeName="BCZL" onlyValue="true" defaultValue=""/></div>
						   <div id="SN_TYPE3" style="display: none;">
						   			<BZ:select prefix="N_" field="NSN_TYPE" id="N_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="45%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select></div>
						   <div id="SN_TYPE4" style="display: none;"><input type="button"  name="SN_TYPE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="DISEASE_CN1" style="display: none;">�������</div>
						   <div id="DISEASE_CN2" style="display: none;"><BZ:dataValue field="DISEASE_CN"  onlyValue="true" defaultValue=""/></div>
						   <div id="DISEASE_CN3" style="display: none;"><BZ:input  type="textarea" prefix="N_" field="NDISEASE_CN" id="N_DISEASE_CN" defaultValue="" formTitle="�������" maxlength="1000" style="width:97%;height:50px"/></div>
						   <div id="DISEASE_CN4" style="display: none;"><input type="button"  name="DISEASE_CN" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="IS_PLAN1" style="display: none;">����ƻ�</div>
						   <div id="IS_PLAN2" style="display: none;"><BZ:dataValue field="IS_PLAN"  checkValue="0=��;1=��;"  onlyValue="true" defaultValue=""/></div>
						   <div id="IS_PLAN3" style="display: none;">
						   			<BZ:select prefix="N_" field="NIS_PLAN" id="N_IS_PLAN" formTitle="" defaultValue="" width="45%" >
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select></div>
						   <div id="IS_PLAN4" style="display: none;"><input type="button"  name="IS_PLAN" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
						   <div id="IS_HOPE1" style="display: none;">ϣ��֮��</div>
						   <div id="IS_HOPE2" style="display: none;"><BZ:dataValue field="IS_HOPE"  checkValue="0=��;1=��;"  onlyValue="true" defaultValue=""/></div>
						   <div id="IS_HOPE3" style="display: none;">
						   			<BZ:select prefix="N_" field="NIS_HOPE" id="N_IS_HOPE" formTitle="" defaultValue="" width="45%">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select></div>
						   <div id="IS_HOPE4" style="display: none;"><input type="button"  name="IS_HOPE" value="ɾ��" class="btn btn-sm btn-primary" onclick="_deleteRowf(this);"/></div>
		
	</BZ:body>
</BZ:html>