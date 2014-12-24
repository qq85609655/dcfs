<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: ����
 * @author wangzheng   
 * @date 2014-7-29 10:27:23
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
%>
<BZ:html>
	<BZ:head>
		<title>�ļ�������ѯ�б�</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame�߶��Զ�����
 $(document).ready(function() {
 			dyniframesize(['mainFrame']);
 			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
 		});
 
 //��ʾ��ѯ����
function _showSearch(){
	$.layer({
		type : 1,
		title : "��ѯ����",
		shade : [0.5 , '#D9D9D9' , true],
		border :[2 , 0.3 , '#000', true],
		page : {dom : '#searchDiv'},
		area: ['950px','210px'],
		offset: ['40px' , '0px'],
		closeBtn: [0, true]
	});
}
 
  function search(){
     document.srcForm.action=path+"/ffs/ffsaftranslation/adTranslationList.action";
	 document.srcForm.submit();
  }
  
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
	 url = path+"/ffs/ffsaftranslation/adTranslationShow.action?UUID="+showuuid;
	 _open(url, "�ļ���Ϣ", 1000, 600);
	 }
  }

  //���
  function _audit(){
	    var arrays = document.getElementsByName("abc");
		var num = 0;
		var aud_state="";	//�ļ����״̬
		var af_id = "";		//�ļ�id
		var au_id = "";		//��˼�¼id
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				aud_state=document.getElementsByName('abc')[i].getAttribute("AUD_STATE");
				var TRANSLATION_STATE = arrays[i].getAttribute("TRANSLATION_STATE");
				if(TRANSLATION_STATE == "2" || aud_state == "1"){
					af_id=document.getElementsByName('abc')[i].getAttribute("AF_ID");
					num += 1;
				}else{
					alert("���ļ��Ѿ���ˣ������ٴν�����ˣ�");
					return;
				}
				
			}
		}
		if(num != "1"){
			page.alert('��ѡ��һ��Ҫ��˵�����');
			return;
		}else{	 
			var str_id_state = af_id + ";" + aud_state;
			var data = getData('com.dcfs.ffs.audit.FileAuditAjax','str_id_state=' + str_id_state+"&method=getAuditID");
			au_id = data.getString("AU_ID");
			if(aud_state == "0" || aud_state == "1" || aud_state == "9"){
				document.srcForm.action=path+"ffs/jbraudit/toAuditForOneLevel.action?FLAG=bf&AF_ID="+af_id+"&AU_ID="+au_id;
				document.srcForm.submit();
			}else if(aud_state == "2"){
				document.srcForm.action=path+"ffs/jbraudit/toAuditForTwoLevel.action?FLAG=bf&AF_ID="+af_id+"&AU_ID="+au_id;
				document.srcForm.submit();
			}else if(aud_state == "3"){
				document.srcForm.action=path+"ffs/jbraudit/toAuditForThreeLevel.action?FLAG=bf&AF_ID="+af_id+"&AU_ID="+au_id;
				document.srcForm.submit();
			}else if(aud_state == "4"){
				page.alert("���ļ��Ѿ����δͨ�������ܽ����ٴ���ˣ�");
			}else if(aud_state == "5"){
				page.alert("���ļ��Ѿ����ͨ�������ܽ����ٴ���ˣ�");
			}
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
  
  //������������
  function _reset(){
	  document.getElementById("S_FILE_NO").value = "";
	  document.getElementById("S_FILE_TYPE").value = "";
	  document.getElementById("S_COUNTRY_CODE").value = "";
	  document.getElementById("S_ADOPT_ORG_ID").value = "";
	  document.getElementById("S_MALE_NAME").value = "";
	  document.getElementById("S_FEMALE_NAME").value = "";
	  document.getElementById("S_TRANSLATION_UNITNAME").value = "";
	  document.getElementById("S_TRANSLATION_STATE").value = "";
	  document.getElementById("S_REGISTER_DATE_START").value = "";
	  document.getElementById("S_REGISTER_DATE_END").value = "";
	  document.getElementById("S_NOTICE_DATE_START").value = "";
	  document.getElementById("S_NOTICE_DATE_END").value = "";
	  document.getElementById("S_COMPLETE_DATE_START").value = "";
	  document.getElementById("S_COMPLETE_DATE_END").value = "";
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
  }

  </script>
  <BZ:body property="data" codeNames="WJLX;GJSY;SYZZ;WJLX_DL;FYDW;SYS_GJSY_CN">
     <BZ:form name="srcForm" method="post" action="/ffs/ffsaftranslation/adTranslationList.action">
     <!-- ��������begin -->
     <input type="hidden" name="dispatchuuid" id="dispatchuuid" value="" />
     
     <!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="S_TRANSLATION_TYPE" id="S_TRANSLATION_TYPE" value="1"/>
	 <!-- ��������end -->
	 <BZ:frameDiv property="clueTo" className="kuangjia">
	 <!-- ��ѯ������Start -->
	 <div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						  <tr>
						  	<td class="bz-search-title" style="width: 10%"><span title="���ı��">���ı��</span></td>
						  	<td style="width: 18%">
								<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" restriction="hasSpecialChar"/>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="�ļ�����">�ļ�����</span></td>
						  	<td style="width: 18%">
								<BZ:select field="FILE_TYPE" notnull="�������ļ�����" formTitle="�ļ�����" prefix="S_" id="S_FILE_TYPE" isCode="true" codeName="WJLX">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="����">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</span></td>
							<td style="width: 18%">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" id="S_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="70%" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">--��ѡ��--</option>
									</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="������֯">������֯</span></td>
							<td style="width: 18%">
								<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="88%" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>							
						</tr>
						<tr>
							<td class="bz-search-title"><span title="��������">��������</span></td>
							<td><BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="��������" restriction="hasSpecialChar" /></td>
							<td class="bz-search-title"><span title="Ů������">Ů������</span></td>
							<td><BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" restriction="hasSpecialChar" /></td>							
							<td class="bz-search-title"><span title="���뵥λ">���뵥λ</span></td>
							<td><BZ:input prefix="S_" field="TRANSLATION_UNITNAME" id="S_TRANSLATION_UNITNAME" defaultValue="" formTitle="���뵥λ" restriction="hasSpecialChar"/></td>
							<td class="bz-search-title"><span title="����״̬">����״̬</span></td>
							<td>
								<BZ:select prefix="S_" field="TRANSLATION_STATE" id="S_TRANSLATION_STATE" defaultValue="" formTitle="����״̬" isCode="false">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="0">������</BZ:option>
									<BZ:option value="1">������</BZ:option>
									<BZ:option value="2">�ѷ���</BZ:option>
								</BZ:select>								
							</td>
						</tr>
						<tr>							
							<td class="bz-search-title"><span title="��������">��������</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="REGISTER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" formTitle="��ʼ��������"/>~
								<BZ:input prefix="S_" field="REGISTER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" formTitle="��ֹ��������"/>
							</td>
							<td class="bz-search-title"><span title="��������">��������</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="NOTICE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_NOTICE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true" formTitle="��ʼ��������"/>~
								<BZ:input prefix="S_" field="NOTICE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_NOTICE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true" formTitle="��ֹ��������"/>
							</td>
						  </tr>
						  <tr>
							<td class="bz-search-title"><span title="�������">�������</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="COMPLETE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_END\\')}',readonly:true" formTitle="��ʼ�������"/>~
								<BZ:input prefix="S_" field="COMPLETE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_START\\')}',readonly:true" formTitle="��ֹ�������"/>
							</td>							
						  </tr>						 
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="��&nbsp;&nbsp;��" onclick="search();" class="btn btn-sm btn-primary">
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
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_audit()"/>&nbsp;
				<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
			</div>
			<div class="blue-hr"></div>
			<!-- ���ܰ�ť������End -->
		
			<!--��ѯ����б���Start -->
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
					<thead>
						<tr>
							<th class="center" style="width:2%;">
								<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
							</th>
							<th style="width:4%;">
								<div class="sorting_disabled">���</div>
							</th>
							<th style="width:8%;">
								<div class="sorting" id="FILE_NO">���ı��</div>
							</th>
							<th style="width:8%;">
								<div class="sorting" id="REGISTER_DATE">��������</div>
							</th>
							<th style="width:8%;">
								<div class="sorting" id="FILE_TYPE">�ļ�����</div>
							</th>
							<th style="width:8%;">
								<div class="sorting" id="COUNTRY_CN">����</div>
							</th>
							<th style="width:10%;">
								<div class="sorting" id="NAME_CN">��������</div>
							</th>
							<th style="width:9%;">
								<div class="sorting" id="MALE_NAME">��������</div>
							</th>
							<th style="width:9%;">
								<div class="sorting" id="FEMALE_NAME">Ů������</div>
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
							<th style="width:8%;">
								<div class="sorting" id="TRANSLATION_STATE">����״̬</div>
							</th>
						</tr>
						</thead>
						<tbody>	
							<BZ:for property="List">
								<tr class="emptyData">
									<td class="center">
										<input name="abc" type="checkbox" 
											value="<BZ:data field="AT_ID" defaultValue="" onlyValue="true"/>" class="ace" 
											AUD_STATE="<BZ:data field="AUD_STATE" defaultValue="" onlyValue="true"/>" 
											AF_ID="<BZ:data field="AF_ID" defaultValue="" onlyValue="true"/>" 
											TRANSLATION_STATE="<BZ:data field="TRANSLATION_STATE" defaultValue="" onlyValue="true"/>" 
											IS_PAUSE="<BZ:data field="IS_PAUSE" defaultValue="" onlyValue="true"/>" 
											RETURN_STATE="<BZ:data field="RETURN_STATE" defaultValue="" onlyValue="true"/>" 
											<BZ:data field="IS_PAUSE"  defaultValue="" onlyValue="true" checkValue="1=disabled "/> <BZ:data field="RETURN_STATE"  defaultValue="" onlyValue="true" checkValue="0=disabled;1=disabled ;2=disabled ;3=disabled "/>>
									</td>
									<td class="center">
										<BZ:i/>
									</td>
									<td><BZ:data field="IS_PAUSE"  defaultValue="" onlyValue="true" checkValue="0= ;1=�� "/>
									<BZ:data field="RETURN_STATE"  defaultValue="" onlyValue="true" checkValue="0=�� ;1=�� ;2=�� ;3=�� "/>
									<BZ:data field="FILE_NO"  defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="REGISTER_DATE"  type="Date" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="FILE_TYPE"  codeName="WJLX"  defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="COUNTRY_CN"  defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="NAME_CN"  defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="MALE_NAME"  defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="FEMALE_NAME"  defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="NOTICE_DATE"  type="Date" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="COMPLETE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
									<td><BZ:data field="TRANSLATION_UNITNAME"  defaultValue="" onlyValue="true"/></td>
									<td align="center"><BZ:data field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=������;1=������;2=�ѷ���"/></td>
									
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
						<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="�ļ����䷭����Ϣ"
							exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;NOTICE_DATE=DATE;COMPLETE_DATE=DATE;TRANSLATION_STATE=FLAG,0:������&1:������&2:�ѷ���;"
							exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;FILE_TYPE=�ļ�����,15;COUNTRY_CN=����,15;NAME_CN=��������,15;MALE_NAME=��������,15;FEMALE_NAME=Ů������,15;NOTICE_DATE=�ط�����,15;COMPLETE_DATE=�������,15;TRANSLATION_UNITNAME=���뵥λ,15;TRANSLATION_STATE=����״̬,15;"/></td>
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
