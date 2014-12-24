<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description:���ò���ͯ���ϴ�¼�б�
 * @author wangzheng   
 * @date 2014-10-23
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
  //�������ݶ���
  Data data = (Data)request.getAttribute("data");
  if(data==null){
      data = new Data();
  }
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
  //�б�����
  String listType=(String)request.getAttribute("listType");
  if(listType==null||"".equals(listType)){
%>
<B>ϵͳ���ܲ�������<B>
<%}else{%>
<BZ:html>
	<BZ:head>
		<title>��ͯ���ϴ�¼��ѯ�б����ò���</title>
        <BZ:webScript list="true" isAjax="true"/>
        <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
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
			area: ['900px','210px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}

 	//����
	function _search(){
	    document.srcForm.action=path+"/cms/childManager/findList.action?page=1";	     
		if (document.getElementById("S_IS_HOPE").checked)
			document.getElementById("S_IS_HOPE").value = "1";
		if (document.getElementById("S_IS_PLAN").checked)
			document.getElementById("S_IS_PLAN").value = "1";
		document.srcForm.submit();
	}
	//ִ�����ò�ѯ��������
	function _reset() {
		document.getElementById("S_PROVINCE_ID").value = "";
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		document.getElementById("S_REG_DATE_START").value = "";
		document.getElementById("S_REG_DATE_END").value = "";		
		//document.getElementById("S_REG_USERNAME").value = "";
		document.getElementById("S_CHILD_STATE").value = "-1";
		document.getElementById("S_IS_HOPE").checked = false;
		document.getElementById("S_IS_HOPE").value = "";
		document.getElementById("S_IS_PLAN").checked = false;
		document.getElementById("S_IS_PLAN").value = "";
				
	}
	//¼��
	function _add() {		
		document.srcForm.action = path + "cms/childManager/basicadd.action";
		document.srcForm.submit();
	}
	//�޸�
	function _revise() {
		var arrays = document.getElementsByName("abc");
		var num = 0;
		var showuuid = "";
		var ismod = "true";
		for ( var i = 0; i < arrays.length; i++) {
			if (arrays[i].checked) {
				showuuid = document.getElementsByName('abc')[i].value;
				if ("0" != document.getElementsByName('abc')[i]
						.getAttribute("AUD_STATE")) {
					ismod = "false";
				}
				num += 1;
			}
		}
		if (num != "1") {
			page.alert('��ѡ��һ��Ҫ�޸ĵļ�¼');
			return;
		} else {
			if (ismod == "false") {
				page.alert('���ύ�ļ�¼�޷��޸�');
				return;
			}
			//document.srcForm.action=path+"/cms/childManager/show.action?type=mod&UUID="+showuuid;
			document.srcForm.action=path+"/cms/childManager/toBasicInfoMod.action?UUID="+showuuid;
			document.srcForm.submit();
		}
	}
	//ɾ��
	function _delete() {
		var sfdj = 0;
		var uuid = "";
		var isdelete = "true";
		for ( var i = 0; i < document.getElementsByName('abc').length; i++) {
			if (document.getElementsByName('abc')[i].checked) {
				uuid = uuid + "#" + document.getElementsByName('abc')[i].value;
				if ("0" != document.getElementsByName('abc')[i]
						.getAttribute("AUD_STATE")) {
					isdelete = "false";
				}
				sfdj++;
			}
		}
		if (sfdj == "0") {
			alert('��ѡ��Ҫɾ��������');
			return;
		} else {
			if (isdelete == "false") {
				page.alert('���ύ�ļ�¼�޷�ɾ��');
				return;
			}
			if (confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')) {
				document.getElementById("uuid").value = uuid;
				document.srcForm.action = path
						+ "/cms/childManager/delete.action";
				document.srcForm.submit();
			} else {
				return;
			}
		}
	}
	//�ύ
	function _submit(_state) {
		var sfdj = 0;
		var uuid = "";
		var issubmit = "true";
		for ( var i = 0; i < document.getElementsByName('abc').length; i++) {
			if (document.getElementsByName('abc')[i].checked) {
				if ("0" == document.getElementsByName('abc')[i]
						.getAttribute("AUD_STATE")) {
					issubmit = "false";
				}
				uuid = uuid + "#" + document.getElementsByName('abc')[i].value;
				sfdj++;
			}
		}
		if (sfdj == "0") {
			alert('��ѡ��Ҫ�ύ�ļ�¼');
			return;
		} else {
			if (issubmit == "false") {
				page.alert('δ�ύ�ļ�¼�޷��ͷ�������');
				return;
			}
			if (confirm('ȷ��Ҫ�ύѡ�м�¼��?')) {
				alert("1");
				document.getElementById("state").value = _state;
				document.getElementById("uuid").value = uuid;
				alert("2");
				document.srcForm.action = path+ "/cms/childManager/azbBatchSubmit.action";
				alert("3");
				document.srcForm.submit();
			} else {
				return;
			}
		}
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
	
	//��ѯ��ͯ���ϵ���
	function _export() {
		if (confirm('ȷ��Ҫ����ΪExcel�ļ���?')) {
			_exportFile(document.srcForm, 'xls');
		} else {
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
<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;BCZL" >
<BZ:form name="srcForm" method="post" action="cms/childManager/findList.action">
<input type="hidden" name="listType" value="CMS_AZB_DL_LIST">
<input type="hidden" name="state" id="state" value="">
<!-- ��ѯ������Start -->
<div class="table-row" id="searchDiv" style="display: none">
	<table cellspacing="0" cellpadding="0">
		<tr>
			<td style="width: 100%;">
				<table>
					<tr>
						<td class="bz-search-title" style="width: 10%">ʡ��:</td>
						<td style="width: 15%">
						    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="70%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	        <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					        </BZ:select>
					 	</td>
				    	<td class="bz-search-title" style="width: 10%">����Ժ:</td>
						<td style="width: 15%">
				 		    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" width="95%" formTitle="����Ժ" defaultValue="">
						        <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					        </BZ:select>
				 		</td>				
						<td class="bz-search-title" style="width: 10%">����:</td>
						<td style="width: 15%">
							<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" style="width: 65%"/>
						</td>				
					    <td class="bz-search-title" style="width: 10%">�Ա�:</td>
						<td style="width: 15%">
						    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="�Ա�" defaultValue="" width="70%">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
				
					<tr>
						<td class="bz-search-title" >��ͯ����:</td>
						<td >
						    <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="" width="70%">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
						
						<td class="bz-search-title" >��������:</td>
						<td >
						    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue="" width="95%">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>		
		                <td class="bz-search-title" >��������:</td>
						<td colspan="3">
							<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />��
							<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
						</td>
					</tr>
					<tr>
						<td class="bz-search-title">�������:</td>
						<td colspan="3">
							<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ���ʱ��" />��
							<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ���ʱ��" />
						</td>
						<td class="bz-search-title">��¼����:</td>
						<td colspan="3">
							<BZ:input prefix="S_" field="REG_DATE_START" id="S_REG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REG_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ¼��ʱ��" />��
							<BZ:input prefix="S_" field="REG_DATE_END" id="S_REG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REG_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ¼��ʱ��" />
						</td>
					</tr>
					<tr>
						<td class="bz-search-title">��¼״̬:</td>
						<td>
							<BZ:select prefix="S_" field="CHILD_STATE" id="S_CHILD_STATE" formTitle="����״̬" defaultValue="" width="70%" >
								<BZ:option value="-1">--��ѡ��--</BZ:option>
								<BZ:option value="0">δ�ύ</BZ:option>
								<BZ:option value="1">���ύ</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-search-title"><span title="����">����:</span></td>
						<td class="bz-search-value">
							<input type="checkbox" name="S_IS_PLAN" id="S_IS_PLAN" value="" <BZ:dataValue field="IS_PLAN" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>����ƻ�&nbsp;&nbsp;
							<input type="checkbox" name="S_IS_HOPE" id="S_IS_HOPE" value="" <BZ:dataValue field="IS_HOPE" defaultValue="0" onlyValue="true" checkValue="0= ;1=checked"/>>ϣ��֮��
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
<input type="hidden" name="uuid" id="uuid" value="" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
 <div class="page-content">
 <BZ:frameDiv property="clueTo" className="kuangjia"></BZ:frameDiv>
    <div class="wrapper">
 <!-- ���ܰ�ť������Start -->
 <div class="table-row table-btns" style="text-align: left">
<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
<input type="button" value="��&nbsp;&nbsp;¼" class="btn btn-sm btn-primary" onclick="_add()"/>&nbsp;
<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_revise()"/>&nbsp;
<input type="button" value="ɾ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_delete()"/>&nbsp;
<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
<!-- 
<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit('1')"/>&nbsp;
<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit('2')"/>&nbsp;
 -->
<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>	
</div>
<div class="blue-hr"></div>
<!-- ���ܰ�ť������End -->

<!--��ѯ����б���Start -->
<div class="table-responsive">
	<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
		<thead>
			<tr>
				<th class="center" style="width:2%;">
					<div class="sorting_disabled">
						<input  type="checkbox" class="ace">
					</div>
				</th>
				<th style="width:3%;">
					<div class="sorting_disabled">���</div>
				</th>
				<th style="width:5%;">
					<div class="sorting" id="PROVINCE_ID">ʡ��</div>
				</th>				
				<th style="width:15%;">
					<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
				</th>				
				<th style="width:6%;">
					<div class="sorting" id="NAME">����</div>
				</th>				
				<th style="width:4%;">
					<div class="sorting" id="SEX">�Ա�</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="BIRTHDAY">��������</div>
				</th>
				<th style="width:6%;">
					<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
				</th>
				<th style="width:10%;">
					<div  class="sorting_disabled" id="TCHD">����</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="SN_TYPE">��������</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="CHECKUP_DATE">�������</div>
				</th>
				<th style="width:10%;">
					<div class="sorting" id="REG_DATE">��¼����</div>
				</th>				
				<th style="width:10%;">
					<div class="sorting" id="AUD_STATE">��¼״̬</div>
				</th>
			</tr>
			</thead>
			<tbody>	
				<BZ:for property="List">
					<tr class="emptyData">
						<td class="center">
							<input name="abc" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace"  AUD_STATE="<BZ:data field="AUD_STATE" onlyValue="true"/>">
						</td>
						<td class="center">
							<BZ:i/>
						</td>
						<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
						<td><BZ:data field="WELFARE_NAME_CN"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="NAME"  defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="BIRTHDAY" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE"  defaultValue="" onlyValue="true"/></td>
						<td>
							<BZ:data field="IS_HOPE" onlyValue="true" defaultValue="" checkValue="0= ;1=ϣ��֮��"/>
							<BZ:data field="IS_PLAN" onlyValue="true" defaultValue="" checkValue="0= ;1=����ƻ�"/>
						</td>
						<td align="center"><BZ:data field="SN_TYPE" codeName="BCZL" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="REG_DATE" type="Date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true"/></td>
						<td align="center"><BZ:data field="AUD_STATE"  defaultValue="" onlyValue="true" checkValue="0=δ�ύ;1=���ύ;2=���ύ;3=���ύ;4=���ύ;5=���ύ;6=���ύ;7=���ύ;8=���ύ;9=���ύ"/></td>
					
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
			<td><BZ:page form="srcForm" property="List"  exportXls="true" exportTitle="���ò���¼��ͯ����" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;IS_HOPE=FLAG,0:��&1:��;IS_PLAN=FLAG,0:��&1:��;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;REG_DATE=DATE;AUD_STATE=FLAG,0:δ�ύ&1:���ύ&2:���ύ&3:���ύ&4:���ύ&5:���ύ&6:���ύ&7:���ύ&8:���ύ&9:���ύ" exportField="PROVINCE_ID=ʡ��,10,20;WELFARE_NAME_CN=����Ժ,20;NAME=����,15;SEX=�Ա�,15;BIRTHDAY=��������,15;CHILD_TYPE=��ͯ����,15;IS_PLAN=����ƻ�,15;IS_HOPE=ϣ��֮��,15;SN_TYPE=��������,15;CHECKUP_DATE=�������,15;REG_DATE=��¼����,15;AUD_STATE=��¼״̬,15;"/></td>
		</tr>
	</table>
</div>
<!--��ҳ������End -->
</div>
</div>
</BZ:form>
	</BZ:body>
</BZ:html>
<%}%>