<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: ����
 * @author wangzheng 
 * @date 2014-10-16 16:23:23
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
		<title>���Ϸ����ѯ�б�</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
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
 //��ѯ
  function _search(){
     document.srcForm.action=path+"cms/childTranslation/findList.action";
	 document.srcForm.submit();
  }
  

//���Ϸ���
  function _translation(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var state="";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			state = document.getElementsByName('abc')[i].getAttribute("TRANSLATION_STATE");
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('��ѡ��һ��Ҫ����Ĳ���!');
		return;
	}else if(state != "0" && state!="1"){
		page.alert('��ѡ��һ������������еĲ��Ͻ��з���!');
		return;
	}else{
	 document.srcForm.action=path+"cms/childTranslation/translation.action?UUID="+showuuid;
	 document.srcForm.submit();
	 }
  }
  
  //�鿴
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
		url = path+"cms/childTranslation/show.action?UUID="+showuuid;
		 _open(url, "������Ϣ", 1000, 600);
    }
  }


  //���ò�ѯ����
  function _reset(){
	  document.getElementById("S_PROVINCE_ID").value = "";
	  document.getElementById("S_WELFARE_ID").value = "";
	  document.getElementById("S_CHILD_NO").value = "";
	  document.getElementById("S_NAME").value = "";
	  document.getElementById("S_SEX").value = "";
	  document.getElementById("S_CHILD_TYPE").value = "";
	  document.getElementById("S_SPECIAL_FOCUS").value = "";
	  document.getElementById("S_TRANSLATION_STATE").value = "";
	  document.getElementById("S_NOTICE_DATE_START").value = "";
	  document.getElementById("S_NOTICE_DATE_END").value = "";
	  document.getElementById("S_COMPLETE_DATE_START").value = "";
	  document.getElementById("S_COMPLETE_DATE_END").value = "";
  }
  
  //����
	function _export(){
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
<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;FYZT">
     <BZ:form name="srcForm" method="post" action="cms/childTranslation/findList.action">
     <BZ:frameDiv property="clueTo" className="kuangjia">
     <input type="hidden" name="deleteuuid" id="deleteuuid" value="" />
     <!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 
	<!-- ���ܰ�ť������End -->
	<!-- ��ѯ������Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>				
				<td style="width: 100%;">
					<table>
						<tr>							
							<td class="bz-search-title" style="width: 8%"><span title="ʡ��">ʡ��</span></td>
							<td style="width: 15%">
								<BZ:select prefix="S_"  field="PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="ʡ��" onchange="selectWelfare(this)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 8%"><span title="����Ժ">����Ժ</span></td>
							<td style="width: 21%">
							<BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" width="95%" formTitle="����Ժ" defaultValue="">
						        <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					        </BZ:select>
							</td>
							<td class="bz-search-title"  style="width: 8%"><span title="��ͯ���">��ͯ���</span></td>
							<td style="width: 15%">
							<BZ:input prefix="S_" field="CHILD_NO" id="S_CHILD_NO" defaultValue=""/>	
							</td>
							<td class="bz-search-title"  style="width: 8%"><span title="����">����</span></td>
							<td style="width: 17%">
							<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>	
							</td>
						</tr>
						<tr>
							<td class="bz-search-title"><span title="�Ա�">�Ա�</span></td>
							<td style="width: 15%">
								<BZ:select prefix="S_"  field="SEX" isCode="true" codeName="ETXB" formTitle="�Ա�">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>													
							<td class="bz-search-title"><span title="��ͯ����">��ͯ����</span></td>
							<td>
								<BZ:select prefix="S_" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="��ͯ����" defaultValue="">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-search-title"><span title="�ر��ע">�ر��ע</span></td>
							<td>
								<BZ:select prefix="S_" field="SPECIAL_FOCUS" isCode="false" defaultValue="" formTitle="�ر��ע">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-search-title"><span title="����״̬">����״̬</span></td>
							<td>
								<BZ:select prefix="S_" field="TRANSLATION_STATE" isCode="true" codeName="FYZT" formTitle="����״̬" defaultValue="">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>																	
							</td>
						</tr>
						<tr>
							<td class="bz-search-title"><span title="֪ͨ����">֪ͨ����</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="NOTICE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_NOTICE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true"/>~
								<BZ:input prefix="S_" field="NOTICE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_NOTICE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true"/>
							</td>
							<td class="bz-search-title"><span title="�������">�������</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="COMPLETE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_END\\')}',readonly:true"/>~
								<BZ:input prefix="S_" field="COMPLETE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_START\\')}',readonly:true"/>
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
		<input type="button" value="���Ϸ���" class="btn btn-sm btn-primary" onclick="_translation()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
	</div>	
	<!--��ѯ����б���Start -->
	<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th class="center" style="width:2%;">
						<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
					</th>
					<th style="width:3%;">
						<div class="sorting_disabled">���</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="PROVINCE_ID">ʡ��</div>
					</th>
					<th style="width:15%;">
						<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="CHILD_NO">��ͯ���</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="NAME">����</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="SEX">�Ա�</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="CHILD_TYPE">��ͯ����</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="NOTICE_DATE">֪ͨ����</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="COMPLETE_DATE">�������</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="TRANSLATION_STATE">����״̬</div>
					</th>						
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr class="emptyData">
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CT_ID" onlyValue="true"/>" TRANSLATION_STATE="<BZ:data field="TRANSLATION_STATE" onlyValue="true"/>" class="ace">
							</td>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
							<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��"/></td>
							<td><BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="COMPLETE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="TRANSLATION_STATE" codeName="FYZT" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="��ͯ���Ϸ�������" 
					exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;NOTICE_DATE=DATE;COMPLETE_DATE=DATE;CHILD_TYPE=CODE,CHILD_TYPE;TRANSLATION_STATE=CODE,FYZT;SPECIAL_FOCUS=FLAG,0: &1:��;" 
					exportField="PROVINCE_ID=ʡ��,15,20;WELFARE_NAME_CN=����Ժ,30;CHILD_NO=��ͯ���,15;NAME=����,15;SEX=�Ա�,10;CHILD_TYPE=��ͯ����,15;SPECIAL_FOCUS=�ر��ע,15;NOTICE_DATE=֪ͨ����,15;COMPLETE_DATE=�������,15;TRANSLATION_STATE=����״̬,15"/></td>				
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
