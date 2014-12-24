<%
/**   
 * @Title: SYZZ_notice_list.jsp
 * @Description: ������֯��������֪ͨ��
 * @author xugy
 * @date 2014-11-2����3:26:21
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
	<BZ:head language="EN">
		<title>������֯��������֪ͨ��</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1700,1700);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����(Query condition)",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','240px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"advice/SYZZNoticeList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
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
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
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
				document.getElementById("S_WELFARE_ID").options.add(new Option("--Please select--",""));
			}
		}
		//��������֪ͨ��鿴
		function _detail(){
			var num = 0;
			var id="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					id = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				/* document.getElementById("ids").value = id;
				document.srcForm.action=path+"advice/SYZZNoticeAttDetail.action";
				document.srcForm.submit(); */
				
				window.open(path + "advice/SYZZNoticeAttDetail.action?ids="+id,"","height=600,width=1100,top=50,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
			}
		}
		
		//�������ӡ
		function _appPrint(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data ');
				return;
			}else{
				//window.open(path+"appointment/toApplicationPrint.action?MI_ID="+ids);
				
				window.open(path+"advice/SYZZAdoptionRegistrationApplication.action?MI_ID="+ids,"","height=600,width=1100,top=50,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no");
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;ZCWJLX;">
		<BZ:form name="srcForm" method="post" action="advice/SYZZNoticeList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
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
								<td class="bz-search-title">���ı��<br>Log-in No.</td>
								<td>
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="" />
								</td>
								
								<td class="bz-search-title">��������<br>Log-in date</td>
								<td>
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
								<td class="bz-search-title">�з�<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">Ů��<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů��" maxlength="" />
								</td>
								
								<td class="bz-search-title">�ļ�����<br>Document type</td>
								<td>
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="ZCWJLX" isShowEN="true" width="148px" formTitle="�ļ�����" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="99">Special needs</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">��ͯ����<br>Type of children</td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" width="148px" formTitle="��ͯ����" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="1">Normal</BZ:option>
										<BZ:option value="2">Special needs</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ʡ��<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" isShowEN="true" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����Ժ<br>SWI</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="����Ժ">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">����<br>Name</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="����" maxlength="" />
								</td>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ǩ������<br>Date of approval</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼǩ������" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹǩ������" />
								</td>
								
								<td class="bz-search-title">�ķ�����<br>Date of dispatch</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ�ķ�����" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ�ķ�����" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Type application letter" class="btn btn-sm btn-primary" onclick="_appPrint()"/>&nbsp;
					<input type="button" value="Check" class="btn btn-sm btn-primary" onclick="_detail()"/>
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
								<th style="width: 4%;">
									<div class="sorting_disabled">���<br>(No.)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FILE_NO">���ı��<br>(Log-in No.)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="REGISTER_DATE">��������<br>(Log-in date)</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="MALE_NAME">�з�<br>(Adoptive father)</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="FEMALE_NAME">Ů��<br>(Adoptive mother)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����<br>(Document type)</div>
								</th>
								
								<th style="width: 6%;">
									<div class="sorting" id="CHILD_TYPE">��ͯ����<br>(Type of children)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��<br>(Province)</div>
								</th>
								<th style="width: 19%;">
									<div class="sorting" id="WELFARE_NAME_EN">����Ժ<br>(SWI)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">����<br>(Name)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="SIGN_DATE">ǩ������<br>(Date of approval)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NOTICE_DATE">�ķ�����<br>(Date of dispatch)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue=""/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue=""/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" isShowEN="true"/></td>
								
								<td><BZ:data field="CHILD_TYPE" defaultValue="" checkValue="1=Normal;2=Special needs;"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" isShowEN="true"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue=""/></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue=""/></td>
								
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="NOTICE_DATE" defaultValue="" type="date"/></td>
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
							<td><BZ:page form="srcForm" property="List" type="EN"/></td>
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