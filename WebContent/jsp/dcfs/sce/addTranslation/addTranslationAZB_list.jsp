<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	* @Title: addTranslationAZB_list.jsp
	* @Description: ���ò�Ԥ��������ѯ�б�
	* @author panfeng   
	* @date 2014-9-19 9:12:01 
	* @version V1.0   
	*/
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
		<title>Ԥ��������ѯ�б�</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	  <script type="text/javascript">
	  
		//iFrame�߶��Զ�����
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
				area: ['1050px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/addTranslation/addTranslationList.action?type=AZB&page=1";
			document.srcForm.submit();
		}
		 
		function _show(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				var state = arrays[i].getAttribute("TRANSLATION_STATE");
				if(arrays[i].checked){
					if(state == "1" || state == "2"){
						showuuid = arrays[i].value.split("#")[0];
						num += 1;
					}else{
						page.alert("ֻ��ѡ��鿴�����к��ѷ������Ϣ��");
						return;
					}
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴�����ݣ�");
				return;
			}else{
				url = path+"/sce/addTranslation/addTranslationShow.action?showuuid="+showuuid;
				_open(url, "Ԥ��������Ϣ", 1000, 460);
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
					aud_state = arrays[i].getAttribute("AUD_STATE2");
					if(aud_state != "1"){
						page.alert("��Ԥ����¼�Ѿ���˹��ˣ������ظ���ˣ�");
						return
					}else{
						ri_id = arrays[i].getAttribute("RI_ID");
						num++;
					}
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ��˵����ݣ�");
				return;
			}else{
				var data = getData('com.dcfs.sce.additional.AdditionalAjax','OperType=AZB&ri_id=' + ri_id);
				var rau_id = data.getString("RAU_ID");
				document.srcForm.action=path+"sce/preapproveaudit/PreApproveAuditShow.action?type=AZBadd&FLAG=bc&RI_ID="+ri_id+"&RAU_ID="+rau_id;
				document.srcForm.submit();
			}
		}
	
		//Ԥ��������ѯ�б���
		function _exportExcel(){
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
	  
		//������������
		function _reset(){
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_COMPLETE_DATE_START").value = "";
			document.getElementById("S_COMPLETE_DATE_END").value = "";
			document.getElementById("S_TRANSLATION_UNITNAME").value = "";
			document.getElementById("S_TRANSLATION_STATE").value = "";
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
		<BZ:form name="srcForm" method="post" action="/sce/addTranslation/addTranslationList.action?type=AZB">
		<BZ:frameDiv property="clueTo" className="kuangjia">
     
	    <!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
		<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="dispatchuuid" id="dispatchuuid" value="" />
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>	
								
								<td class="bz-search-title" >ʡ��</td>
								<td>
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">����Ժ</td>
								<td>
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="60%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					                </BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								<td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="TRANSLATION_STATE" id="S_TRANSLATION_STATE" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�ѷ���</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ����֪ͨ����" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ����֪ͨ����" />
								</td>
							</tr>
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
								
								<td class="bz-search-title">�������</td>
								<td>
									<BZ:input prefix="S_" field="COMPLETE_DATE_START" id="S_COMPLETE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="COMPLETE_DATE_END" id="S_COMPLETE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">���뵥λ</td>
								<td>
									<BZ:input prefix="S_" field="TRANSLATION_UNITNAME" id="S_TRANSLATION_UNITNAME" defaultValue="" formTitle="���뵥λ" maxlength=""/>
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
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
			<!-- <input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_addAudit()"/>&nbsp; -->
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- ���ܰ�ť������End -->
		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th class="center" style="width:2%;">
							<div>&nbsp;</div>
						</th>
						<th style="width:4%;">
							<div class="sorting_disabled">���</div>
						</th>
						<th style="width:12%;">
							<div class="sorting" id="MALE_NAME">��������</div>
						</th>
						<th style="width:12%;">
							<div class="sorting" id="FEMALE_NAME">Ů������</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="PROVINCE_ID">ʡ��</div>
						</th>
						<th style="width:13%;">
							<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NAME">��ͯ����</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="SEX">�Ա�</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NOTICE_DATE">��������</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="COMPLETE_DATE">�������</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSLATION_UNITNAME">���뵥λ</div>
						</th>
						<th style="width:6%;">
							<div class="sorting" id="TRANSLATION_STATE">����״̬</div>
						</th>
						<!-- <th style="width:6%;">
							<div class="sorting" id="AUD_STATE2">���״̬</div>
						</th> -->
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" 
										value="<BZ:data field="AT_ID" defaultValue="" onlyValue="true"/>"
										TRANSLATION_STATE="<BZ:data field="TRANSLATION_STATE" onlyValue="true"/>"
										AUD_STATE2="<BZ:data field="AUD_STATE2" defaultValue="" onlyValue="true"/>"
										RI_ID="<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>"
									class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID"  codeName="PROVINCE"  defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("fordata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<BZ:data field="NAME" defaultValue="" onlyValue="true"/>��ͬ����
									<%}else{%><BZ:data field="NAME" defaultValue="" onlyValue="true"/><%} %>
								</td>
								<td><BZ:data field="SEX"  codeName="ETXB" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="COMPLETE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSLATION_UNITNAME"  defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
								<%-- <td><BZ:data field="AUD_STATE2" defaultValue="" checkValue="0=�����;1=�����;3=���ͨ��;2=��˲�ͨ��;" onlyValue="true"/></td> --%>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="Ԥ��������ѯ��Ϣ" 
						exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;NOTICE_DATE=DATE;COMPLETE_DATE=DATE;TRANSLATION_STATE=FLAG,0:������&1:������&2:�ѷ���;" 
						exportField="MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;PROVINCE_ID=ʡ��,15;WELFARE_NAME_CN=����Ժ,15;NAME=����,15;SEX=�Ա�,15;NOTICE_DATE=��������,15;COMPLETE_DATE=�������,15;TRANSLATION_UNITNAME=���뵥λ,15;TRANSLATION_STATE=����״̬,15;"/></td>
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
