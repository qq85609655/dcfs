<%
/**   
 * @Title: matchAudit_list.jsp
 * @Description: ƥ������б�
 * @author xugy
 * @date 2014-9-6����3:42:31
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
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
	
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head>
		<title>ƥ������б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>	
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1900,1900);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','270px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"matchAudit/matchAuditList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_MATCH_NUM").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			//document.getElementById("S_OPERATION_STATE").value = "";
			document.getElementById("S_MATCH_STATE").value = "0";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		//
		function selectWelfare(node){
			var provinceId = node.value;
			//���ڻ��Եø�������ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ��--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//���
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--��ѡ��--",""));
			}
		}
		//�����Ϣ���
		function _auditAdd(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					var MATCH_STATE = ids.split(",")[5];
					if(MATCH_STATE != "0"){
						page.alert("��ѡ�񾭰��˴���˵�����");
						return;
					}
					num += 1;//OPERATION_STATE
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ�������˴���˵�����');
				return;
			}else{
				document.srcForm.action=path+"matchAudit/toMatchAuditAdd.action?ids="+ids;
				document.srcForm.submit();
			}
		}
		//���ƥ��
		function _relieveMatch(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					var MATCH_STATE = ids.split(",")[5];
					if(MATCH_STATE != "3"){
						page.alert("�����ݲ���ִ�н��ƥ��");
						return;
					}
					var CI_ID = ids.split(",")[3];
					var rv = getStr("com.dcfs.ncm.audit.AjaxJudgeCIPosition","CI_ID="+CI_ID);
					//alert(rv);
					if(rv == "0"){
						page.alert("��ƥ����Ϣ�Ķ�ͯ���ϣ���ͬ�������ڰ��ò�������ִ�н��ƥ��");
						return;
					}
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ�����ͨ��������');
				return;
			}else{
				document.srcForm.action=path+"matchAudit/toRelieveMatch.action?ids="+ids;
				document.srcForm.submit();
			}
		}
		//
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				page.alert('��ѡ��һ������');
				return;
			}else{
				document.srcForm.action=path+"matchAudit/matchAuditDetail.action?ids="+ids;
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;CHILD_TYPE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="matchAudit/matchAuditList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">���ı��</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">��������</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">����</td>
								<td style="width: 28%;">
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="����" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="������֯" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--��ѡ��������֯--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								
								<td class="bz-search-title">�з�</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
							
								<td class="bz-search-title">Ů��</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�ļ�����</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" width="148px" formTitle="�ļ�����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">ƥ�����</td>
								<td>
									<BZ:input prefix="S_" field="MATCH_NUM" id="S_MATCH_NUM" defaultValue="" formTitle="ƥ�����" maxlength="" />
								</td>
								<td class="bz-search-title">��ͯ����</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" width="148px" formTitle="��ͯ����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">����</BZ:option>
										<BZ:option value="2">����</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ʡ��</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����Ժ</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px;" formTitle="����Ժ">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="�Ա�" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<%-- <td class="bz-search-title">����״̬</td>
								<td>
									<BZ:select prefix="S_" field="OPERATION_STATE" id="S_OPERATION_STATE" width="148px" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">������</BZ:option>
										<BZ:option value="1">������</BZ:option>
										<BZ:option value="2">�Ѵ���</BZ:option>
									</BZ:select>
								</td> --%>
								<td class="bz-search-title">ƥ��״̬</td>
								<td>
									<BZ:select prefix="S_" field="MATCH_STATE" id="S_MATCH_STATE" width="148px" formTitle="ƥ��״̬" defaultValue="0">
										<BZ:option value="0">�����˴����</BZ:option>
										<BZ:option value="1">�������δ����</BZ:option>
										<BZ:option value="3">���ͨ��</BZ:option>
										<BZ:option value="4">��˲�ͨ��</BZ:option>
										<BZ:option value="9">��Ч</BZ:option>
										<BZ:option value="99">ȫ������</BZ:option>
									</BZ:select>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_auditAdd()"/>&nbsp;
					<input type="button" value="���ƥ��" class="btn btn-sm btn-primary" onclick="_relieveMatch()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="MALE_NAME">�з�</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="FEMALE_NAME">Ů��</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="MATCH_NUM">ƥ�����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="MATCH_STATE">ƥ��״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="dl" fordata="mydata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MAU_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="OPERATION_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="MATCH_STATE" defaultValue="" onlyValue="true"/>,<BZ:data field="FILE_TYPE" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
								<td><BZ:data field="MATCH_NUM" defaultValue=""/></td>
								
								<td><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td><BZ:data field="NAME" defaultValue=""/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="MATCH_STATE" defaultValue="" checkValue="0=�����˴����;1=�������δ����;3=���ͨ��;4=��˲�ͨ��;9=��Ч;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--��ѯ����б���End -->
				<!--��ҳ������Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�������������" exportCode="FILE_TYPE=CODE,WJLX;PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;CHILD_TYPE=CODE,CHILD_TYPE;OPERATION_STATE=FLAG,0:������&1:������&2:�Ѵ���;MATCH_STATE=FLAG,0:�����˴����&1:�������δ����&3:���ͨ��&4:��˲�ͨ��&9:��Ч;REGISTER_DATE=DATE;BIRTHDAY=DATE,yyyy/MM/dd" exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CN=����,15;NAME_CN=������֯,20;MALE_NAME=�з�,15;FEMALE_NAME=Ů��,15;FILE_TYPE=�ļ�����,10;MATCH_NUM=ƥ�����,10;CHILD_TYPE=��ͯ����,10;PROVINCE_ID=ʡ��,10;WELFARE_NAME_CN=����Ժ,20;NAME=����,15;SEX=�Ա�,10;BIRTHDAY=��������,15;MATCH_STATE=ƥ��״̬,20;"/></td>
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