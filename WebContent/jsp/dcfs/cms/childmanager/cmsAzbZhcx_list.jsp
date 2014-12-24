<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.cms.ChildInfoConstants"%>
<%@page import="com.dcfs.cms.childManager.ChildStateManager"%>
<%
  /**   
 * @Description: ��ͯ�����ۺϲ�ѯ�б����ò���
 * @author wangzheng   
 * @date 2014-11-12
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
  String path = request.getContextPath();
  String WELFARE_ID=da.getString("WELFARE_ID","");
%>

<BZ:html>
	<BZ:head>
		<title>�����ۺϲ�ѯ�б����ò���</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/page.js"></script>
		
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
			area: ['950px','260px'],
			offset: ['40px' , '0px'],
			closeBtn: [0, true]
		});
	}
	
	//����
	function _search(){
		document.srcForm.action=path+"/cms/childManager/azbChildInfoSynQuery.action";
		document.srcForm.submit();
	}

	//������������
	function _reset(){
		document.getElementById("S_PROVINCE_ID").value = "";
		document.getElementById("S_WELFARE_ID").value = "";
		document.getElementById("S_NAME").value = "";
		document.getElementById("S_SEX").value = "";
		document.getElementById("S_CHILD_TYPE").value = "";
		document.getElementById("S_SN_TYPE").value = "";
		
		document.getElementById("S_BIRTHDAY_START").value = "";
		document.getElementById("S_BIRTHDAY_END").value = "";
		document.getElementById("S_CHECKUP_DATE_START").value = "";
		document.getElementById("S_CHECKUP_DATE_END").value = "";
		
		document.getElementById("S_CI_GLOBAL_STATE").value = "";
		document.getElementById("S_CHILD_IDENTITY").value = "";
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
			_exportFile(document.srcForm,'xls')
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
	<BZ:body property="data"  codeNames="PROVINCE;ETSFLX;BCZL;ETXB;CHILD_TYPE;CLJSZT">
    <BZ:form name="srcForm" method="post" action="/cms/childManager/azbChildInfoSynQuery.action">
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">ʡ��</td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="100%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="����Ժ">����Ժ</span></td>
								<td style="width: 15%">
								   <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					               </BZ:select>
								
								</td>
								<td class="bz-search-title"><span title="��ͯ״̬">��ͯ״̬</span></td>
								<td>
									<BZ:select prefix="S_" field="CI_GLOBAL_STATE" id="S_CI_GLOBAL_STATE" isCode="true" codeName="CLJSZT" defaultValue="" formTitle="��ͯ״̬">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
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
								<td class="bz-search-title"><span title="��ͯ����">��ͯ����</span></td>
								<td>
									<BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL"  defaultValue="" formTitle="��������">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title"><span title="�������">�������</span></td>
								<td >
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true"/>~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_CHECKUP_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true"/>
								</td>		
							</tr>
							<tr>
								<td class="bz-search-title"><span title="��ͯ���">��ͯ���</span></td>
								<td colspan="5">
									<BZ:input prefix="S_" field="CHILD_IDENTITY" id="S_CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="��ͯ���" treeType="-1" 
								helperSync="true" showParent="false" defaultShowValue=""  style="width:250px;"/>
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
	 
    <div class="wrapper">		
		<!-- ���ܰ�ť������Start -->
		<div class="table-row table-btns" style="text-align: left">
			<input type="button" value="��&nbsp;&nbsp;ѯ" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;		
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
		</div>
		<div class="blue-hr"></div>
		<!-- ���ܰ�ť������End -->		
		<!--��ѯ����б���Start -->
		<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th style="width:3%;">
						<div class="sorting_disabled">���</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="PROVINCE_ID">ʡ��</div>
					</th>
					<th style="width:12%;">
						<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="NAME">����</div>
					</th>
					<th style="width:3%;">
						<div class="sorting" id="SEX">�Ա�</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="BIRTHDAY">��������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHILD_IDENTITY">��ͯ���</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="SN_TYPE">��������</div>
					</th>
					<th style="width:8%;">
						<div class="sorting" id="CHECKUP_DATE">�������</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="CI_POSITION">����λ��</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="CI_GLOBAL_STATE">��ͯ״̬</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="IS_OVERAGE">����״̬</div>
					</th>
					<th style="width:6%;">
						<div class="sorting" id="MATCH_STATE">����״̬</div>
					</th>
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
							<td><BZ:data field="SN_TYPE"  codeName="BCZL" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHECKUP_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							
							<td align="center"><BZ:data field="CI_POSITION" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CI_GLOBAL_STATE" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="IS_OVERAGE"  defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="MATCH_STATE"  defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="��ͯ�����ۺϲ�ѯ" exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;CHILD_TYPE=CODE,CHILD_TYPE;SN_TYPE=CODE,BCZL;CHECKUP_DATE=DATE;IS_HOPE=FLAG,0:��&1:��;IS_PLAN=FLAG,0:��&1:��;POST_DATE=DATE;RECEIVE_DATE=DATE;RECEIVE_STATE=CODE,CLJSZT;" exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,25;NAME=����,15;SEX=�Ա�,10;BIRTHDAY=��������,15;CHILD_TYPE=��ͯ����,10;SN_TYPE=��������,25;CHECKUP_DATE=�������,15;IS_PLAN=����ƻ�,10;IS_HOPE=ϣ��֮��,10;POST_DATE=��������,15;RECEIVE_DATE=��������,15;RECEIVE_STATE=����״̬,15;"/></td>				
				</tr>
			</table>
		</div>
		<!--��ҳ������End -->
	</div>
</div>
<br><br><br><br><br>

</BZ:form>
</BZ:body>
</BZ:html>
