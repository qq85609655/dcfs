<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
  /**   
 * @Description: 文件重翻查询列表
 * @author wangzheng   
 * @date 2014-8-27
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
		<title>文件重翻查询列表</title>
        <BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
 $(document).ready(function() {
 			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
 		});
 
 //显示查询条件
function _showSearch(){
	$.layer({
		type : 1,
		title : "查询条件",
		shade : [0.5 , '#D9D9D9' , true],
		border :[2 , 0.3 , '#000', true],
		page : {dom : '#searchDiv'},
		area: ['950px','210px'],
		offset: ['40px' , '0px'],
		closeBtn: [0, true]
	});
}
 
  function search(){
     document.srcForm.action=path+"/ffs/ffsaftranslation/reTranslationList.action";
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
		page.alert('请选择一条要查看的数据');
		return;
	}else{
	 url = path+"/ffs/ffsaftranslation/show.action?type=mod&UUID="+showuuid;
	 _open(url, "文件信息", 1000, 600);
	 }
  }


//文件翻译
  function _translation(){
		var arrays = document.getElementsByName("abc");
		var num = 0;
		var showuuid="";
		var state="";
		//var isPause = "";
		//var returnState = ""
			
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				showuuid=document.getElementsByName('abc')[i].value;
				//浏览器版本可能影响getAttribute方法，todo....
				state = document.getElementsByName('abc')[i].getAttribute("TRANSLATION_STATE");				
				num += 1;
			}
		}
		if(num != "1"){
			page.alert('请选择一条要翻译的文件!');
			return;
		}else if(state != "0" && state!="1"){
			page.alert('请选择一条待翻译或翻译中的文件进行翻译!');
			return;
		//}else if(isPause !="0"){
		//	page.alert('暂停的文件不能进行翻译!');
		//	return;
		//}else if(returnState != ""){
		//	page.alert('退文的文件不能进行翻译!');
		//	return;
		}else{
			 document.srcForm.action=path+"/ffs/ffsaftranslation/translation.action?UUID="+showuuid;
			 document.srcForm.submit();
		 }
	  }

  //导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls')
		}else{
			return;
		}
	}
  
  //检索条件重置
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
	  document.getElementById("S_RECEIVE_DATE_START").value = "";
	  document.getElementById("S_RECEIVE_DATE_END").value = "";
	  document.getElementById("S_COMPLETE_DATE_START").value = "";
	  document.getElementById("S_COMPLETE_DATE_END").value = "";
	  _findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID');
  }

  </script>
  <BZ:body property="data" codeNames="WJLX;GJSY;SYS_GJSY_CN;SYZZ;WJLX_DL;FYDW">
     <BZ:form name="srcForm" method="post" action="/ffs/ffsaftranslation/reTranslationList.action">
	 <!-- 查询条件区Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td style="width: 100%;">
					<table>
						  <tr>
						  	<td class="bz-search-title" style="width: 10%"><span title="收文编号">收文编号</span></td>
						  	<td style="width: 18%">
								<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" restriction="hasSpecialChar"/>
							</td>
							<td class="bz-search-title" style="width: 10%"><span title="文件类型">文件类型</span></td>
						  	<td style="width: 18%">
								<BZ:select field="FILE_TYPE" notnull="请输入文件类型" formTitle="文件类型" prefix="S_" isCode="true" codeName="WJLX">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 10%">
								<span title="国家">国家</span>
							</td>
							<td style="width: 18%">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="S_" isCode="true" codeName="SYS_GJSY_CN" width="148px" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 10%">
								<span title="收养组织">收养组织</span>
							</td>
							<td style="width: 18%">
								<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px" onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>						
						</tr>
						<tr>
							<td class="bz-search-title"><span title="男收养人">男收养人</span></td>
							<td><BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" restriction="hasSpecialChar" /></td>
							<td class="bz-search-title"><span title="女收养人">女收养人</span></td>
							<td><BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" restriction="hasSpecialChar" /></td>							
							<td class="bz-search-title"><span title="翻译单位">翻译单位</span></td>
							<td><BZ:input prefix="S_" field="TRANSLATION_UNITNAME" id="S_TRANSLATION_UNITNAME" defaultValue="" formTitle="翻译单位" restriction="hasSpecialChar"/></td>
							<td class="bz-search-title"><span title="翻译状态">翻译状态</span></td>
							<td>
								<BZ:select prefix="S_" field="TRANSLATION_STATE" id="S_TRANSLATION_STATE" defaultValue="" formTitle="翻译状态" isCode="false">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="0">待翻译</BZ:option>
									<BZ:option value="1">翻译中</BZ:option>
									<BZ:option value="2">已翻译</BZ:option>
								</BZ:select>								
							</td>
						</tr>
						<tr>							
							<td class="bz-search-title"><span title="收文日期">收文日期</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="REGISTER_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" formTitle="起始收文日期"/>~
								<BZ:input prefix="S_" field="REGISTER_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_REGISTER_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" formTitle="截止收文日期"/>
							</td>
							<td class="bz-search-title"><span title="接收日期">重翻日期</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="RECEIVE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_END\\')}',readonly:true" formTitle="起始接收日期"/>~
								<BZ:input prefix="S_" field="RECEIVE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_RECEIVE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_RECEIVE_DATE_START\\')}',readonly:true" formTitle="截止接收日期"/>
							</td>
						  </tr>
						  <tr>
							<td class="bz-search-title"><span title="完成日期">完成日期</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="COMPLETE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_END\\')}',readonly:true" formTitle="起始完成日期"/>~
								<BZ:input prefix="S_" field="COMPLETE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_START\\')}',readonly:true" formTitle="截止完成日期"/>
							</td>							
						  </tr>						 
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->	
     <input type="hidden" name="dispatchuuid" id="dispatchuuid" value="" />
     
     <!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 <input type="hidden" name="S_TRANSLATION_TYPE" id="S_TRANSLATION_TYPE" value="2"/>
	 <div class="page-content">
	 <BZ:frameDiv property="clueTo" className="kuangjia">	 
     <div class="wrapper">     
     
	 <!-- 功能按钮操作区Start -->
	 <div class="table-row table-btns" style="text-align: left">
		<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
		<input type="button" value="文件翻译" class="btn btn-sm btn-primary" onclick="_translation()"/>
		<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
		<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
	</div>
	<div class="blue-hr"></div>
	<!-- 功能按钮操作区End -->
		
		
		<!--查询结果列表区Start -->
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
				<thead>
					<tr>
						<th class="center" style="width:2%;">
							<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
						</th>
						<th style="width:4%;">
							<div class="sorting_disabled">序号</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="FILE_NO">收文编号</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="REGISTER_DATE">收文日期</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="FILE_TYPE">文件类型</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="COUNTRY_CN">国家</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="NAME_CN">收养机构</div>
						</th>
						<th style="width:9%;">
							<div class="sorting" id="MALE_NAME">男收养人</div>
						</th>
						<th style="width:9%;">
							<div class="sorting" id="FEMALE_NAME">女收养人</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="NOTICE_DATE">重翻日期</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="COMPLETE_DATE">完成日期</div>
						</th>
						<th style="width:10%;">
							<div class="sorting" id="TRANSLATION_UNITNAME">翻译单位</div>
						</th>
						<th style="width:8%;">
							<div class="sorting" id="TRANSLATION_STATE">翻译状态</div>
						</th>
					</tr>
					</thead>
					<tbody>	
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="abc" type="checkbox" value="<BZ:data field="AT_ID" onlyValue="true"/>" class="ace" TRANSLATION_STATE="<BZ:data field="TRANSLATION_STATE" onlyValue="true"/>" IS_PAUSE="<BZ:data field="IS_PAUSE" onlyValue="true"/>" RETURN_STATE="<BZ:data field="RETURN_STATE" onlyValue="true"/>" <BZ:data field="IS_PAUSE"  defaultValue="" onlyValue="true" checkValue="1=disabled "/> <BZ:data field="RETURN_STATE"  defaultValue="" onlyValue="true" checkValue="0=disabled;1=disabled ;2=disabled ;3=disabled "/>>
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="IS_PAUSE"  defaultValue="" onlyValue="true" checkValue="0= ;1=暂 "/>
								<BZ:data field="RETURN_STATE"  defaultValue="" onlyValue="true" checkValue="0=退 ;1=退 ;2=退 ;3=退 "/>
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
								<td align="center"><BZ:data field="TRANSLATION_STATE"  defaultValue="" onlyValue="true" checkValue="0=待翻译;1=翻译中;2=已翻译"/></td>
								
							</tr>
						</BZ:for>
					</tbody>
				</table>
			</div>
		<!--查询结果列表区End -->
		<!--分页功能区Start -->
		<div class="footer-frame">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="文件重翻列表" 
					exportCode="REGISTER_DATE=DATE;FILE_TYPE=CODE,WJLX;NOTICE_DATE=DATE;COMPLETE_DATE=DATE;TRANSLATION_STATE=FLAG,0:待翻译&1:翻译中&2:已翻译;" 
					exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=收文日期,10;FILE_TYPE=文件类型,10;COUNTRY_CN=国家,10;NAME_CN=收养机构,25;MALE_NAME=男收养人,15;FEMALE_NAME=女收养人,15;NOTICE_DATE=重翻日期,10;COMPLETE_DATE=完成日期,10;TRANSLATION_UNITNAME=翻译单位,15;TRANSLATION_STATE=翻译状态,10;"/></td>				
				</tr>
			</table>
		</div>
		<!--分页功能区End -->
		</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>
