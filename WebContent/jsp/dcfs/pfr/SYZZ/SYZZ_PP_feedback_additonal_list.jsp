<%
/**   
 * @Title: SYZZ_PP_feedback_additonal_list.jsp
 * @Description: ������֯���ú󱨸�b�����б�
 * @author xugy
 * @date 2014-10-21����8:41:34
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
		<title>���ú󱨸淴���б�</title>
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
				area: ['1050px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"feedback/SYZZPPFeedbackAdditonalList.action?page=1";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_NUM").value = "";
			document.getElementById("S_NOTICE_DATE_START").value = "";
			document.getElementById("S_NOTICE_DATE_END").value = "";
			document.getElementById("S_FEEDBACK_DATE_START").value = "";
			document.getElementById("S_FEEDBACK_DATE_END").value = "";
			document.getElementById("S_AA_STATUS").value = "";
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
		//
		function _additonal(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var id = document.getElementsByName('xuanze')[i].value;
					var AA_STATUS = id.split(",")[1];
					if(AA_STATUS != "0" && AA_STATUS != "1"){
						alert("You may only select information 'to be supplemented' or 'in process of supplementation'");
						return;
					}
					ids=id.split(",")[0];
					num += 1;
				}
			}
			
			if(num != 1){
				alert('Please select one data');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"feedback/toSYZZPPFeedbackAdditonal.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;">
		<BZ:form name="srcForm" method="post" action="feedback/SYZZPPFeedbackAdditonalList.action">
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
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength=""/>
								</td>
								
								<td class="bz-search-title">ǩ����<br>Application number</td>
								<td>
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="ǩ����" maxlength="" />
								</td>
								
								<td class="bz-search-title">�з�<br>Adoptive father</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">Ů��<br>Adoptive mother</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="" />
								</td>
								
								<td class="bz-search-title">ʡ��<br>Province</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isShowEN="true" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="ʡ��" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">����Ժ<br>SWI</td>
								<td>
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px" formTitle="����Ժ">
										<BZ:option value="">--Please select--</BZ:option>
									</BZ:select>
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">����ƴ��<br>Name(EN)</td>
								<td>
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="����" maxlength="" />
								</td>
								
								<td class="bz-search-title">�ε���<br>Number</td><!--  of post-placement reports -->
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="�ε���" maxlength="" />
								</td>
								
								<td class="bz-search-title">֪ͨ����<br>Date of notification</td>
								<td>
									<BZ:input prefix="S_" field="NOTICE_DATE_START" id="S_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ֪ͨ����" />~
									<BZ:input prefix="S_" field="NOTICE_DATE_END" id="S_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ֪ͨ����" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">�ύ����<br>Submission date </td>
								<td colspan="3">
									<BZ:input prefix="S_" field="FEEDBACK_DATE_START" id="S_FEEDBACK_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="FEEDBACK_DATE_END" id="S_FEEDBACK_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEEDBACK_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td class="bz-search-title">����״̬<br>Supplement status</td>
								<td> 
									<BZ:select prefix="S_" field="AA_STATUS" id="S_AA_STATUS" width="148px" formTitle="����״̬" defaultValue="">
										<BZ:option value="">--Please select--</BZ:option>
										<BZ:option value="0">to be added</BZ:option>
										<BZ:option value="1">in process of adding</BZ:option>
										<BZ:option value="2">added</BZ:option>
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
					<input type="button" value="Modify or supplement report" class="btn btn-sm btn-primary" onclick="_additonal()"/>&nbsp;
					<input type="button" value="Export" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
									<div class="sorting_disabled">���<br>(No.)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="FILE_NO">���ı��<br>(Log-in No.)</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="SIGN_NO">ǩ����<br>(Application number)</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NUM">�ε���<br>(Number)</div><!--  of post-placement reports -->
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">�з�<br>(Adoptive father)</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">Ů��<br>(Adoptive mother)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��<br>(Province)</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting" id="WELFARE_NAME_EN">����Ժ<br>(SWI)</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_PINYIN">����ƴ��<br>(Name(EN))</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="NOTICE_DATE">֪ͨ����<br>(Date of notification)</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="FEEDBACK_DATE">�ύ����<br>(Submission date)</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="AA_STATUS">����״̬<br>(Supplement status)</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="FB_ADD_ID" defaultValue="" onlyValue="true"/>,<BZ:data field="AA_STATUS" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="FILE_NO" defaultValue="" /></td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="NUM" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" isShowEN="true" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_EN" defaultValue="" /></td>
								<td><BZ:data field="NAME_PINYIN" defaultValue="" /></td>
								<td><BZ:data field="NOTICE_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="FEEDBACK_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="AA_STATUS" defaultValue="" checkValue="0=to be added;1=in process of adding;2=added;"/></td>
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
							<td><BZ:page isShowEN="true" form="srcForm" property="List" type="EN" exportXls="true" exportTitle="���ú������油������" exportCode="PROVINCE_ID=CODE,PROVINCE;AA_STATUS=FLAG,0:to be added&1:in process of adding&2:added;NOTICE_DATE=DATE;FEEDBACK_DATE=DATE,yyyy/MM/dd" exportField="FILE_NO=���ı��(Log-in No.),15,20;SIGN_NO=ǩ����(Application number),15;MALE_NAME=�з�(Adoptive father),15;FEMALE_NAME=Ů��(Adoptive mother),15;PROVINCE_ID=ʡ��(Province),15;WELFARE_NAME_EN=����Ժ(SWI),15;NAME_PINYIN=����ƴ��(Name(EN)),15;NUM=�ε���(Number of post-placement reports),15;NOTICE_DATE=֪ͨ����(Date of notification),15;FEEDBACK_DATE=�ύ����(Submission date),15;AA_STATUS=����״̬(Supplement status),15;"/></td>
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