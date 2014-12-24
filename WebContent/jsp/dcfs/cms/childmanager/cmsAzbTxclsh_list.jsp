<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: �����ͯ��������б����ò���
 * @author wangzheng   
 * @date 2014-9-21
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
  String CHILD_TYPE = da.getString("CHILD_TYPE");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  String path = request.getContextPath();
%>

<BZ:html>
	<BZ:head>
		<title>�����ͯ��������б����ò���</title>
        <BZ:webScript list="true" isAjax="true"/>
        <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	
<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		initProvOrg();
		_scroll(1400,1400);
	});
 
	//��ʾ��ѯ����
	function _showSearch(){
		$.layer({
			type : 1,
			title : "��ѯ����",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			page : {dom : '#searchDiv'},
			area: ['950px','250px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//����
	function _search(){
		document.srcForm.action=path+"/cms/childManager/azbAuditList.action";
		if(document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if(document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}

	//������������
	function _reset(){
		document.getElementById("S_PROVINCE_ID").value = "";
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_RECEIVE_DATE_START").value = "";
		document.getElementById("S_RECEIVE_DATE_END").value = "";
		document.getElementById("S_AUD_STATE").value = "";
		document.getElementById("S_MATCH_STATE").value = "";
		
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_DISEASE_CN").value = "";
		document.getElementById("S_HAVE_VIDEO").value = "";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
		document.getElementById("S_SPECIAL_FOCUS").value = "";	
		document.getElementById("S_PUB_STATE").value = "";	

	}
  
	//�鿴��Ϣ
	function _view(){
		var arrays = document.getElementsByName("abc");
		var num = 0;
		var showuuid="";
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				showuuid=document.getElementsByName('abc')[i].value;
				num += 1;
			}
		}
		if(num != "1"){
			page.alert('��ѡ��һ��Ҫ�鿴������');
			return;
		}else{	 
			url = path+"/cms/childManager/show.action?type=show&UUID="+showuuid;
			_open(url, "��ͯ������Ϣ", 1000, 600);
		}
	}

    //����
	function _export(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}

//���
  function _audit(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var uuid="";
	var isaudit = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			uuid=document.getElementsByName('abc')[i].getAttribute("CA_ID");
			if("<%=ChildStateManager.CHILD_AUD_STATE_YJIES%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_ZXSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE")){
				isaudit = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('��ѡ��һ�����״̬Ϊ����˻�����еļ�¼��');
		return;
	}else{
	 if(isaudit == "false"){
		page.alert('��ѡ��һ�����״̬Ϊ����˻�����еļ�¼��');
		return;
	 }
	 document.srcForm.action=path+"/cms/childManager/childInfoAudit.action?level=<%=ChildInfoConstants.LEVEL_CCCWA%>&UUID="+uuid;
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/azbAuditList.action";
	 }
  }
	
	//�޸�
  function _revise(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var ismod = "true";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			if("<%=ChildStateManager.CHILD_AUD_STATE_YJIES%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") && "<%=ChildStateManager.CHILD_AUD_STATE_ZXSHZ%>"!=document.getElementsByName('abc')[i].getAttribute("AUD_STATE") ){
				ismod = "false";
			}
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('��ѡ��һ��Ҫ�޸ĵļ�¼��');
		return;
	}else{
	 if(ismod == "false"){
		page.alert('����˵ļ�¼�޷��޸ģ�');
		return;
	 }
	 //document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
	 document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid+"&listType=CMS_AZB_TXSH_LIST";
	 document.srcForm.submit();
	 document.srcForm.action=path+"/cms/childManager/azbAuditList.action";
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
	//�鿴�ö�ͯ���η�����Ϣ
	function _showFbHistory(ciid){
		$.layer({
			type : 2,
			title : "��ͯ���η�����ϸ��Ϣ",
			shade : [0.5 , '#D9D9D9' , true],
			border :[2 , 0.3 , '#000', true],
			iframe: {src: '<BZ:url/>/sce/publishManager/showFbHistory.action?ciid='+ciid},
			area: ['1150px','990px'],
			offset: ['0px' , '0px']
		});
	}
  
</script>
	<BZ:body property="data" codeNames="PROVINCE;ETSFLX;BCZL;ETXB;CHILD_TYPE;CHILD_STATE;ZXCLSHZT;FBZT;FYZT">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/azbAuditList.action">
     <BZ:frameDiv property="clueTo" className="kuangjia">
		<input type="hidden" name="CHILD_TYPE" id="CHILD_TYPE" value="<%=CHILD_TYPE%>">
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">ʡ��</td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="����Ժ">����Ժ</span></td>
								<td style="width: 15%">
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					               </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="��������">��������</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="RECEIVE_DATE_START" id="S_RECEIVE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="RECEIVE_DATE_END" id="S_RECEIVE_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%"><span title="����">����</span></td>
								<td style="width:15%">
								<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="�Ա�">�Ա�</span></td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�">
										<option value="">--��ѡ��--</option>
									</BZ:select>
								</td>
								<td class="bz-search-title"  style="width: 10%"><span title="��������">��������</span></td>
								<td style="width: 40%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="BIRTHDAY_END" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_BIRTHDAY_END" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="���״̬">���״̬</span></td>
								<td>
									<BZ:select prefix="S_" field="AUD_STATE" id="S_AUD_STATE" isCode="true" codeName="ZXCLSHZT" defaultValue="" formTitle="���״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="ƥ��״̬">ƥ��״̬</span></td>
								<td>
									<BZ:select prefix="S_" field="MATCH_STATE" id="S_MATCH_STATE" isCode="false" defaultValue="" formTitle="����״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��ƥ��</BZ:option>
										<BZ:option value="1">��ƥ��</BZ:option>
									</BZ:select>
								</td>									
								<td class="bz-search-title"><span title="�������">�������</span></td>
								<td>
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END"  type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true"/>
								</td>															
							</tr>
							<tr>
								<td class="bz-search-title"><span title="��Ƶ">��Ƶ</span></td>
								<td>
									<BZ:select prefix="S_" field="HAVE_VIDEO"  id="S_HAVE_VIDEO"  isCode="false" defaultValue="" formTitle="��Ƶ">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" defaultValue="" formTitle="��������">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="�������">�������</span></td>
								<td>
									<BZ:input prefix="S_" field="DISEASE_CN" id="S_DISEASE_CN" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title"><span title="�ر��ע">�ر��ע</span></td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS"  isCode="false" defaultValue="" formTitle="�ر��ע">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>								
								<td class="bz-search-title"><span title="����״̬">����״̬</span></td>
								<td>
									<BZ:select prefix="S_" field="PUB_STATE" id="S_PUB_STATE" isCode="true" codeName="FBZT" defaultValue="" formTitle="����״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="����">����</span></td>
								<td class="bz-search-value">
									<input type="checkbox" name="S_IS_PLAN" id="S_IS_PLAN" value="" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>����ƻ�&nbsp;&nbsp;
									<input type="checkbox" name="S_IS_HOPE" id="S_IS_HOPE" value="" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>ϣ��֮��
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
    <input type="hidden" name="uuid" id="uuid" value="" />	     
	<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	<div class="page-content">
    <div class="wrapper" >
		
		<!-- ���ܰ�ť������Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- ���ܰ�ť������End -->		
		<!--��ѯ����б���Start -->
		<div class="table-responsive" style="overflow-x:scroll;">
		 <div id="scrollDiv">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr class="emptyData">
						<th class="center" style="width:2%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:3%;">
							<div class="sorting_disabled">���</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="PROVINCE_ID">ʡ��</div>
						</th>
						<th style="width:9%;">
							<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="NAME">����</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="SEX">�Ա�</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="BIRTHDAY">��������</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="CHECKUP_DATE">�������</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="SN_TYPE">��������</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="DISEASE_CN">�������</div>
						</th>
						<th style="width:3%;">
							<div class="sorting" id="HAVE_VIDEO">��Ƶ</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
						</th>
						<th style="width:7%;">
							<div class="sorting_disabled" id="TCHD">����</div>
						</th>
						<th style="width:7%;">
							<div class="sorting" id="RECEIVE_DATE">��������</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="PUB_STATE">����״̬</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="AUD_STATE">���״̬</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="PUB_NUM">��������</div>
						</th>
						<th style="width:4%;">
							<div class="sorting" id="TRANSLATION_STATE">����״̬</div>
						</th>
						<th style="width:5%;">
							<div class="sorting" id="MATCH_STATE">ƥ��״̬</div>
						</th>
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List">
							<tr>
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace" AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>" RETURN_STATE="<BZ:data field="RETURN_STATE" onlyValue="true"/>" CA_ID="<BZ:data field="CA_ID" onlyValue="true"/>">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="DISEASE_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="HAVE_VIDEO" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
								<td>
								<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=ϣ��֮��"/>
								<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=����ƻ�"/>
								</td>
								<td align="center"><BZ:data field="RECEIVE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="PUB_STATE"  codeName="FBZT" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="AUD_STATE"  codeName="ZXCLSHZT" defaultValue="" onlyValue="true"/></td>
								<td align="center"><a href="javascript:_showFbHistory('<BZ:data field="CI_ID" onlyValue="true" />')" title="����鿴�ö�ͯ���η�����Ϣ" ><BZ:data field="PUB_NUM"  defaultValue="" onlyValue="true"/></a></td>
								<td align="center"><BZ:data field="TRANSLATION_STATE"  codeName="FYZT" defaultValue="" onlyValue="true"/></td>
								<td align="center"><BZ:data field="MATCH_STATE"  defaultValue="" onlyValue="true" checkValue="0=δƥ��;1=��ƥ��"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�����ͯ�����������" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHECKUP_DATE=DATE;SN_TYPE=CODE,BCZL;HAVE_VIDEO=FLAG,0:��&1:��;SPECIAL_FOCUS=FLAG,0:��&1:��;IS_HOPE=FLAG,0:��&1:��;IS_PLAN=FLAG,0:��&1:��;RECEIVE_DATE=DATE;PUB_STATE=CODE,FBZT;AUD_STATE=CODE,ZXCLSHZT;TRANSLATION_STATE=CODE,FYZT;MATCH_STATE=FLAG,0:δƥ��&1:��ƥ��;" exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,25;NAME=����,15;SEX=�Ա�,10;BIRTHDAY=��������,15;CHECKUP_DATE=�������,15;SN_TYPE=��������,25;DISEASE_CN=�������,30;HAVE_VIDEO=��Ƶ,8;SPECIAL_FOCUS=�ر��ע,10;IS_PLAN=����ƻ�,10;IS_HOPE=ϣ��֮��,10;RECEIVE_DATE=��������,15;PUB_STATE=����״̬,15;AUD_STATE=���״̬,15;PUB_NUM=��������,15;TRANSLATION_STATE=����״̬,15;MATCH_STATE=ƥ��״̬,15;"/></td>				
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
	</div>
</div>
<form name="frmprint" method="post" action="<%=path%>/cms/childManager/postPrint.action" target="<%=path%>/cms/childManager/postPrint.action">
	<input type="hidden" id="printid" name="printid">
</form>
<br><br><br><br><br>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>
