<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: filesearch_list.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-12-18 ����2:03:18 
 * @version V1.0   
 */
 //1 ��ȡ�����ֶΡ���������(ASC DESC)
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
		<title>�ļ��ۺϲ�ѯ�б�</title>
		<BZ:webScript list="true" edit="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
			initProvOrg();
			_scroll(1500,1500);
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
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"igq/BGSFileSearch/BGSFileList.action?page=1";
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
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_AF_POSITION").value = "";
			document.getElementById("S_AF_GLOBAL_STATE").value = "";
			document.getElementById("S_FAMILY_TYPE").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
		}
		
		//�鿴�ļ���ϸ��Ϣ
		function _show(){
			var num = 0;
			var showuuid = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split("#")[0];
					num++;
				}
			}
			if(num != "1"){
				page.alert("��ѡ��һ��Ҫ�鿴���ļ���");
				return;
			}else{
				document.srcForm.action = path + "igq/BGSFileSearch/showFileData.action?showuuid=" + showuuid;
				document.srcForm.submit();
			}
		}
		
		//�ļ��б���
		function _exportExcel(){
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
	<BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;SYZZ;SYLX;PROVINCE;WJWZ;WJQJZT_ZX">
		<BZ:form name="srcForm" method="post" action="igq/BGSFileSearch/BGSFileList.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">���ı��</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="���ı��" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">�ļ�����</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="�ļ�����" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">��������</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								
							</tr>
							<tr>	
								
								<td class="bz-search-title">����</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--��ѡ��--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">������֯</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="148px"
										onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
										<option value="">--��ѡ��--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								</td>
								
								<td class="bz-search-title"><span title="��������">��������</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="�з�" maxlength="150" style="width:270px;"/>
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">����</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="200"/>
								</td>
								
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="FAMILY_TYPE" id="S_FAMILY_TYPE" isCode="true" codeName="SYLX" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">Ů������</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="Ů������" maxlength="150" style="width:270px;"/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" >ʡ��</td>
								<td>
								    <BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"    isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="" width="148px">
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title">����Ժ</td>
								<td>
								    <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="93%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					                </BZ:select>
								</td>
								
								<td class="bz-search-title">�ļ�״̬</td>
								<td>
									<BZ:select prefix="S_" field="AF_GLOBAL_STATE" id="S_AF_GLOBAL_STATE" isCode="true" codeName="WJQJZT_ZX" formTitle="" defaultValue="" width="84%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�ļ�λ��</td>
								<td>
									<BZ:select prefix="S_" field="AF_POSITION" id="S_AF_POSITION" isCode="true" codeName="WJWZ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								
								<td>&nbsp;</td>
								<td>&nbsp;</td>
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
					<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_exportExcel()"/>&nbsp;
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
									&nbsp;
								</th>
								<th style="width: 3%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FILE_NO">���ı��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="REGISTER_DATE">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="COUNTRY_CODE">����</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">������֯</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">��������</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">Ů������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FILE_TYPE">�ļ�����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="FAMILY_TYPE">��������</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">��ͯ����</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="WELFARE_NAME_CN">����Ժ</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AF_POSITION">�ļ�λ��</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="AF_GLOBAL_STATE">�ļ�״̬</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="FAMILY_TYPE" defaultValue="" codeName="SYLX" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" defaultValue="" codeName="WJWZ" onlyValue="true"/></td>
								<td><BZ:data field="AF_GLOBAL_STATE" defaultValue="" codeName="WJQJZT_ZX" onlyValue="true"/></td>
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
							<td><BZ:page isShowEN="false" form="srcForm" property="List" exportXls="true" exportTitle="�ļ���Ϣ" exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;FILE_TYPE=CODE,WJLX;FAMILY_TYPE=CODE,SYLX;PROVINCE_ID=CODE,PROVINCE;AF_POSITION=CODE,WJWZ;AF_GLOBAL_STATE=CODE,WJQJZT_ZX;" 
								exportField="FILE_NO=���ı��,15,20;REGISTER_DATE=��������,15;COUNTRY_CODE=����,15;NAME_CN=������֯,25;MALE_NAME=��������,30;FEMALE_NAME=Ů������,30;FILE_TYPE=�ļ�����,15;FAMILY_TYPE=��������,15;NAME=��ͯ����,15;PROVINCE_ID=ʡ��,15;WELFARE_NAME_CN=����Ժ,15;AF_POSITION=�ļ�λ��,15;AF_GLOBAL_STATE=�ļ�״̬,15;"/></td>
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