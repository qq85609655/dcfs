<%
/**   
 * @Title: additionalSHB_list.jsp
 * @Description: ��˲�Ԥ�������ѯ�б�
 * @author yangrt
 * @date 2014-9-11����5:02:21
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

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
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������ѯ�б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			initProvOrg();
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/additional/findAddList.action?type=SHB&page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
			document.getElementById("S_REQ_DATE_START").value = "";
			document.getElementById("S_REQ_DATE_END").value = "";
		}
		
		//�鿴Ԥ��������ϸ
		function _addShow(){
			var num = 0;
			var ra_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ra_id = arrays[i].value;
					num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴�����ݣ�");
				return;
			}else{
				window.open(path+"sce/additional/showNotice.action?showuuid=" + ra_id,"newwindow","height=350,width=1000,top=150,left=180,scrollbars=yes");
			}
		}
		
		//���
		function _addAudit(){
			var num = 0;
			var ri_id = "";
			var aud_state = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var state = arrays[i].getAttribute("AA_STATUS");	//Ԥ������״̬
					if(state == "2"){
						aud_state = arrays[i].getAttribute("AUD_STATE1");
						if(aud_state != "2"){
							page.alert("��Ԥ����¼�Ѿ���˹��ˣ������ظ���ˣ�");
							return
						}else{
							var TRANS_FLAG = arrays[i].getAttribute("TRANS_FLAG");
							if(TRANS_FLAG != "1"){
								ri_id = arrays[i].getAttribute("RI_ID");
								num++;
							}else{
								page.alert("��Ԥ�������¼����֮����ܽ���Ԥ����ˣ�");
								return
							}
						}
					}else{
						page.alert("��ѡ�񲹳�״̬Ϊ�Ѳ���Ľ�����ˣ�");
						return;
					}
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ��˵����ݣ�");
				return;
			}else{
				var data = getData('com.dcfs.sce.additional.AdditionalAjax','OperType=SHB&ri_id=' + ri_id + "&aud_state=" + aud_state);
				var rau_id = data.getString("RAU_ID");
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=0&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
				document.srcForm.submit();
				/* if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
					document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=0&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
					document.srcForm.submit();
				}else if(aud_state == "2"){
					document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=1&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
					document.srcForm.submit();
				}else if(aud_state == "3"){
					document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=SHBadd&Level=2&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
					document.srcForm.submit();
				}else if(aud_state == "4"){
					page.alert("���ļ��Ѿ����δͨ�������ܽ����ٴ���ˣ�");
				}else if(aud_state == "5"){
					page.alert("���ļ��Ѿ����ͨ�������ܽ����ٴ���ˣ�");
				} */
			}
		}
		
		//Ԥ�������ѯ�б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		//ʡ������Ժ��ѯ�����������跽��
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=WELFARE_ID%>';
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
			}else{
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ����Ժ--",""));
			}
		}
		//ʡ������Ժ��ѯ�����������跽��
		function initProvOrg(){
			var str = document.getElementById("S_PROVINCE_ID");
		     selectWelfare(str);
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;">
		<BZ:form name="srcForm" method="post" action="sce/additional/findAddList.action?type=SHB">
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
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" >ʡ��</td>
								<td>
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="" width="148px">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">����Ժ</td>
								<td>
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="60%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">֪ͨ����</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ����֪ͨ����" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ����֪ͨ����" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�Ѳ���</BZ:option>
									</BZ:select>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="REQ_DATE_START" id="S_REQ_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REQ_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REQ_DATE_END" id="S_REQ_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REQ_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
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
					<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_addShow()"/>&nbsp;
					<!-- <input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_addAudit()"/>&nbsp; -->
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									&nbsp;
								</th>
								<th style="width: 2%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="ADOPT_ORG_NAME_CN">������֯</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">�з�</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">Ů��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REQ_DATE">��������</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="NOTICE_DATE">֪ͨ����</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FEEDBACK_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AA_STATUS">����״̬</div>
								</th>
								<!-- <th style="width: 6%;">
									<div class="sorting" id="AUD_STATE1">���״̬</div>
								</th> -->
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" 
										value="<BZ:data field="RA_ID" defaultValue="" onlyValue="true"/>" 
										AA_STATUS="<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>"
										AUD_STATE1="<BZ:data field="AUD_STATE1" defaultValue="" onlyValue="true"/>"
									 	RI_ID="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>"
									 	TRANS_FLAG="<BZ:data field="TRANS_FLAG" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME" defaultValue="" onlyValue="true"/>��ͬ����
									<%}else{%><BZ:data field="NAME" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="date" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REQ_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="NOTICE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="FEEDBACK_DATE" defaultValue="" type="date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=������;1=������;2=�Ѳ���;" onlyValue="true"/></td>
								<%-- <td><BZ:data field="AUD_STATE1" defaultValue="" checkValue="0=�����˴����;1=�����������;2=�������δ����;3=�ֹ����δ�����;4=��˲�ͨ��;5=���ͨ��;9=�˻�����;" onlyValue="true"/></td> --%>
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
							<td>
								<BZ:page form="srcForm" property="List" exportXls="true" exportTitle="Ԥ�������ѯ��Ϣ" 
									exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;REQ_DATE=DATE;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE;AA_STATUS=FLAG,0:������&1:������&2:�Ѳ���;" 
									exportField="PROVINCE_ID=ʡ��,15;WELFARE_NAME_CN=����Ժ,15;NAME=����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;ADOPT_ORG_NAME_CN=������֯,15;MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;REQ_DATE=��������,15;NOTICE_DATE=֪ͨ����,15;FEEDBACK_DATE=��������,15;AA_STATUS=����״̬,15;"/></td>
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