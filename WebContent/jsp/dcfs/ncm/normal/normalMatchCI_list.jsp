<%
/**   
 * @Title: normalMatchCI_list.jsp
 * @Description: ѡ���ͯƥ���б�
 * @author xugy
 * @date 2014-9-4����2:40:35
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String AFid=(String)request.getAttribute("AFid");//�������ļ���ID
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
		<title>ѡ���ͯƥ���б�</title>
		<BZ:webScript list="true" isAjax="true" edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//dyniframesize(['mainFrame']);
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
				area: ['1050px','150px'],
				offset: ['110px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"mormalMatch/normalMatchCIList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_CHECKUP_DATE_START").value = "";
			document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
		}
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
		//�رյ���ҳ
		function _close(){
			//var index = parent.layer.getFrameIndex(window.name);
			//parent.layer.close(index);
			
			window.close();
		}
		//�鿴��ͯ��Ϣ
		function _viewEtcl(CHILD_NOs){
			$.layer({
				type : 2,
				title : "��ͯ���ϲ鿴",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				//page : {dom : '#planList'},
				iframe: {src: '<BZ:url/>/mormalMatch/showCIs.action?CHILD_NOs='+CHILD_NOs},
				area: ['1050px','540px'],
				offset: ['0px' , '10px']
			});
		}
		//ƥ��
		function _match(){
			var num = 0;
			var CIid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CIid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('��ѡ��һ������ƥ�� ');
				return;
			}else{
				//if (confirm('ȷ��ƥ��ö�ͯ?')) {
				var AFid = document.getElementById("AFid").value;
				document.srcForm.action=path+"mormalMatch/matchPreview.action?CIid="+CIid+"&AFid="+AFid;
				document.srcForm.submit();
				//}
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;">
		<BZ:form name="srcForm" method="post" action="mormalMatch/normalMatchCIList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<input type="hidden" id="AFid" name="AFid" value="<%=AFid%>"/>
		<!-- ��������ϢStart -->
		<table class="bz-edit-data-table" border="0">
			<tr>
				<td class="bz-edit-data-title">����</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title">������֯</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title" width="15%">��������</td>
				<td class="bz-edit-data-value" width="35%">
					<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title" width="15%">����</td>
				<td class="bz-edit-data-value" width="35%">
					<BZ:dataValue field="MALE_AGE" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">Ů������</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title">����</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="FEMALE_AGE" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">��׼������</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
				</td>
				<td class="bz-edit-data-title">��������</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">����Ҫ��</td>
				<td class="bz-edit-data-value" colspan="3">
					<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">��Ů����</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title">ƥ�����</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="MATCH_NUM" defaultValue="0" onlyValue="true"/>
				</td>
			</tr>
		</table>
		<!-- ��������ϢEnd -->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">ʡ��</td>
								<td style="width: 24%;">
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 8%;">����Ժ</td>
								<td style="width: 24%">
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px;" formTitle="����Ժ">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 8%;">�������</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ�������" />~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ�������" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="" />
								</td>
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
					<input type="button" value="ƥ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_match()"/>&nbsp;
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- ���ܰ�ť������End -->
				
				<!--��ѯ����б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace">
									</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 25%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 19%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="CHECKUP_DATE">�������</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="CIdl" fordata="CIdata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("CIdata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<a href="javascript:void(0);" onclick="_viewEtcl('<BZ:data field="CHILD_NO" defaultValue="" onlyValue="true"/>,<BZ:data field="TWINS_IDS" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="NAME" defaultValue=""/>
										��ͬ����
									</a>
									<%
									}else{
									%>
									<a href="javascript:void(0);" onclick="_viewEtcl('<BZ:data field="CHILD_NO" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="NAME" defaultValue=""/>
									</a>
									<%} %>
								</td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="CHECKUP_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="CHILD_TYPE" defaultValue="" checkValue="1=������ͯ;2=�����ͯ;"/></td>
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
							<td><BZ:page form="srcForm" property="CIdl"/></td>
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