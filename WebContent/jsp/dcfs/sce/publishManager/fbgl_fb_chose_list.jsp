<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_fb_chose_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
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
%>
<BZ:html>
	<BZ:head>
		<title>��������ͯ�б�</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//��ʾ��ѯ����
		function _showSearch(){
			$.layer({
				type : 1,
				title : "��ѯ����",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['700px','270px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//ִ�а�������ѯ����
		function _search(){
			document.srcForm.action=path+"sce/publishManager/toChoseETForFB.action";
			document.srcForm.submit();
		}
		//ִ�����ò�ѯ��������
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_PUB_NUM").value = "";
			document.getElementById("S_PUB_FIRSTDATE_START").value = "";
			document.getElementById("S_PUB_FIRSTDATE_END").value = "";
			document.getElementById("S_PUB_LASTDATE_START").value = "";
			document.getElementById("S_PUB_LASTDATE_END").value = "";
		}
	
		//ҵ���Զ��幦�ܲ���JS
		
		//ѡ���ͯ
		function _chose(){
			var num = 0;
			var ci_id ="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					if(num==0){
						ci_id=arrays[i].value;
					}else{
						ci_id += ";"+arrays[i].value;
					}
					
					num++;
				}
				
			}
			if(num < 1){
				page.alert('��ѡ������һ����¼��');
				return;
			}else{
				document.getElementById("ciids").value = ci_id;
				document.srcForm.action=path+"sce/publishManager/toAddFBTJInfo.action";
				document.srcForm.submit();
			}
		
		}
		
		//����
		function _goback(){
			//window.history.back();
			window.location.href=path+"sce/publishManager/findListForFBGL.action";
		}
		
		//ʡ������Ժ��ѯ�����������跽��
	function selectWelfare(node){
		var provinceId = node.value;
		//���ڻ��Եø�������ID
		var selectedId;
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
	<BZ:body property="data" codeNames="BCZL;DFLX;FBZT;PROVINCE">
		<BZ:form name="srcForm" method="post" action="sce/publishManager/toChoseETForFB.action">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--����������ݿ������ʾ(���������ݿ�������Բ���) End-->
		<input type="hidden" name="ciids" value="" id="ciids"/>
		<!-- ��ѯ������Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">ʡ��</td>
								<td style="width: 15%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="77%"  isCode="true"  codeName="PROVINCE" formTitle="ʡ��" defaultValue="" >
					 	                <BZ:option value="">--��ѡ��ʡ��--</BZ:option>
					                </BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%"><span title="����Ժ">����Ժ</span></td>
								<td style="width: 15%">
								   <BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="����Ժ" defaultValue="" width="77%">
						              <BZ:option value="">--��ѡ����Ժ--</BZ:option>
					               </BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�Ա�</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="�Ա�" defaultValue="" width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="1">��</BZ:option>
										<BZ:option value="2">Ů</BZ:option>
										<BZ:option value="3">����</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="��������" defaultValue=""  width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">�ر��ע</td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="�ر��ע" defaultValue=""  width="77%;">
										<BZ:option value="">--��ѡ��--</BZ:option>
										<BZ:option value="0">��</BZ:option>
										<BZ:option value="1">��</BZ:option>
									</BZ:select>
								</td>
								<td>
								</td>
								<td>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">����</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="����" maxlength="150" />
								</td>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="PUB_NUM" id="S_PUB_NUM" formTitle="��������" defaultValue=""/>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">��������</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="��ʼ��������" />~
								</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="��ֹ��������" />
								</td>
								<td>
								</td>
								
							</tr>
							<tr>
								
								<td class="bz-search-title">�״η�������</td>
								<td>
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_START" id="S_PUB_FIRSTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_END\\')}',readonly:true" defaultValue="" formTitle="�״η�������" />~
								</td>
								<td>
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_END" id="S_PUB_FIRSTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_START\\')}',readonly:true" defaultValue="" formTitle="�״η�������" />
								</td>
								<td>
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">ĩ�η�������</td>
								<td>
									<BZ:input prefix="S_" field="PUB_LASTDATE_START" id="S_PUB_LASTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_END\\')}',readonly:true" defaultValue="" formTitle="ĩ�η�������" />~
								</td>
								<td>
									<BZ:input prefix="S_" field="PUB_LASTDATE_END" id="S_PUB_LASTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_START\\')}',readonly:true" defaultValue="" formTitle="ĩ�η�������" />
								</td>
								<td>
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
					<input type="button" value="ѡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_chose()"/>&nbsp;
					<input type="button" value="ȡ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
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
								<th style="width: 2%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">ʡ��</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="WELFARE_ID">����Ժ</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">����</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">�Ա�</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">��������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SPECIAL_FOCUS">�ر��ע</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SN_TYPE">��������</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PUB_NUM">��������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_FIRSTDATE">�״η�������</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_LASTDATE">ĩ�η�������</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>,<BZ:data field="SPECIAL_FOCUS" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue=""  onlyValue="true" checkValue="1=��;2=Ů;3=����"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue=""  onlyValue="true" type="Date"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td><a href="javascript:_showFbHistory('<BZ:data field="CI_ID" defaultValue="" onlyValue="true" />')" title="����鿴�ö�ͯ���η�����Ϣ"><BZ:data field="PUB_NUM" defaultValue="0"  onlyValue="true"/></a></td>
								<td><BZ:data field="PUB_FIRSTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_LASTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"/></td>
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