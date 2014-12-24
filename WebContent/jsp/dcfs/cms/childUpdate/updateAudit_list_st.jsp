<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	/**   
	 * @Title: childAddition_list_fly.jsp
	 * @Description:  ��ͯ���ϲ����б�(����Ժ)
	 * @author furx   
	 * @date 2014-9-4 ����12:12:34 
	 * @version V1.0   
	 */
	 //1 ��ȡ�����ֶΡ���������(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	Data da = (Data)request.getAttribute("data");
    String WELFARE_ID=da.getString("WELFARE_ID","");
	String provinceId=(String)request.getAttribute("provinceId");
%>
<BZ:html>
	<BZ:head>
		<title>��ͯ���ϸ����б�(ʡ��)</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			selectWelfare(<%=provinceId %>);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"cms/childupdate/updateAuditListSt.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_UPDATE_STATE").value = "";
			document.getElementById("S_CHECKUP_DATE_START").value = "";
			document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_UPDATE_DATE_START").value = "";
			document.getElementById("S_UPDATE_DATE_END").value = "";
			document.getElementById("S_AUDIT_USERNAME").value = "";
			document.getElementById("S_AUDIT_DATE_START").value = "";
			document.getElementById("S_AUDIT_DATE_END").value = "";
			
		}	
		//������������
		function _audit(){
			var num = 0;
			var CUA_ID = "";
			var OPERATION_STATE="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CUA_ID =arrays[i].value.split("#")[0];
					OPERATION_STATE=arrays[i].value.split("#")[1];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ��˵ĸ��¼�¼��");
				return;
			}else{
				if(OPERATION_STATE!="0"){
				   page.alert("�ø��������������ϣ�������ѡ��");
				   return;
					}
				document.srcForm.action=path+"cms/childupdate/toUpdateAudit.action?"+"CUA_ID="+CUA_ID;
				document.srcForm.submit();
			}
		}
		//�鿴����������ϸ��Ϣ
		function _showDetail(){
			var num = 0;
			var CUI_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CUI_ID =arrays[i].value.split("#")[2];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴���¼�¼��");
				return;
			}else{
			 var url = path + "cms/childupdate/getShowData.action?UUID="+CUI_ID;
				//window.open(url,"window",'height=450,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
				_open(url, "window", 1000, 500);
			}
		}
		//����ʡ��province_id��ʼ������Ժ������ѡ���б���Ҫ��ʾ������
		function selectWelfare(provinceId){
			//���ڻ��Եĸ�������code
			var selectedId = '<%=WELFARE_ID%>';
			if(provinceId!=null&&provinceId!=""){
				var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
				if(dataList != null && dataList.size() > 0){
					//���
					document.getElementById("S_WELFARE_ID").options.length=0;
					document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
					for(var i=0;i<dataList.size();i++){
						var data = dataList.getData(i);
						if(selectedId==data.getString("ORG_CODE")){
							document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
							var option = document.getElementById("S_WELFARE_ID");
							document.getElementById("S_WELFARE_ID").value = selectedId;
						}else{					
							document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						}
					}
				}
			}
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;CHILD_TYPE;UPDATE_STATE;">
		<BZ:form name="srcForm" method="post" action="cms/childupdate/updateAuditListSt.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
							    <td class="bz-search-title" style="width: 10%">����Ժ</td>
								<td style="width: 16%">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="100%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 12%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 65%"/>
								</td>
								
	                            <td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >��ͯ����</td>
								<td >
								    <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="" width="95%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>	
								
								<td class="bz-search-title" >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td >
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="70%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">�������</td>
								<td>
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�������" />~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�������" />
								</td>
							</tr>
							<tr>	
							    <td class="bz-search-title">��������</td>
								<td>
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="95%">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="UPDATE_STATE" id="S_UPDATE_STATE" isCode="true" codeName="UPDATE_STATE" formTitle="����״̬" defaultValue="" width="70%" >
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td >
									<BZ:input prefix="S_" field="UPDATE_DATE_START" id="S_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_UPDATE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="UPDATE_DATE_END" id="S_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_UPDATE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>	
							    <td class="bz-search-title">�����</td>
								<td>
								    <BZ:input prefix="S_" field="AUDIT_USERNAME" id="S_AUDIT_USERNAME" defaultValue="" formTitle="�����" maxlength="150" style="width: 90%"/>
								</td>
								<td class="bz-search-title">�������</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="AUDIT_DATE_START" id="S_AUDIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_AUDIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ���ʱ��" />~
									<BZ:input prefix="S_" field="AUDIT_DATE_END" id="S_AUDIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_AUDIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ���ʱ��" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- ��ѯ������End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- ���ܰ�ť������Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_showDetail();"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_audit();"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="CHECKUP_DATE">�������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="UPDATE_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AUDIT_USERNAME">�����</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="AUDIT_DATE">�������</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="UPDATE_STATE">����״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CUA_ID" onlyValue="true"/>#<BZ:data field="OPERATION_STATE" onlyValue="true"/>#<BZ:data field="CUI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHECKUP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AUDIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_STATE" defaultValue=""  codeName="UPDATE_STATE" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List"/></td>
						</tr>
					</table>
				</div>
				<!--��ҳ������End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>