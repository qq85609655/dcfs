<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: SHBfilesearch.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-9-29 下午16:19:01 
 * @version V1.0   
 */
 //1 获取排序字段、排序类型(ASC DESC)
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
		<title>文件查询列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<link rel="stylesheet" type="text/css" href="/dcfs/resource/css/flexigrid.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/dcfs/countryOrg.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/iframe.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/jquery.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/jquery-scrolltofixed.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/flexigrid.js"></script>
		<style>
		#listtitle{
			url("/dcfs/resource/css/images/fhbg.gif") repeat-x scroll center bottom rgb(250, 250, 250);
		    background-color: rgb(250, 250, 250);
		    background-image: url("/dcfs/resource/css/images/fhbg.gif");
		    background-repeat: repeat-x;
		    background-attachment: scroll;
		    background-position: center bottom;
		    background-clip: border-box;
		    background-origin: padding-box;
		    background-size: auto auto;
			font-weight: normal;
		}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			$('#anniuqu').scrollToFixed();
			$('#listtitle').scrollToFixed({marginTop:40});
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
				area: ['900px','230px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"igq/BGSFileSearch/SHBFileList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_FILE_TYPE").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_MALE_NATION").value = "";
			document.getElementById("S_MALE_BIRTHDAY_START").value = "";
			document.getElementById("S_MALE_BIRTHDAY_END").value = "";
			document.getElementById("S_FEMALE_NATION").value = "";
			document.getElementById("S_FEMALE_BIRTHDAY_START").value = "";
			document.getElementById("S_FEMALE_BIRTHDAY_END").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_FAMILY_TYPE").value = "";
			document.getElementById("S_IS_CONVENTION_ADOPT").value = "";
		}
		
		//查看文件详细信息
		function _show(){
			var num = 0;
			var showuuid = "";
			var ri_id = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid = arrays[i].value.split("#")[0];
					ri_id = arrays[i].value.split("#")[2];
					num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要查看的文件！");
				return;
			}else{
				document.srcForm.action = path + "igq/BGSFileSearch/showSHBData.action?showuuid=" + showuuid + "&ri_id=" + ri_id;
				document.srcForm.submit();
			}
		}
		
		//文件查询列表导出
		function _exportExcel(){
			if(confirm('确认要导出为Excel文件吗?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
		
	</script>
	<BZ:body property="data" codeNames="WJLX_DL;WJLX;GJSY;GJ;SYZZ;SYLX;FYDW;WJFYZL;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_CHILDREN_SEX;ETXB;PROVINCE;WJWZ;WJQJZT_ZX">
		<BZ:form name="srcForm" method="post" action="igq/SHBFileSearch/SHBFileList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="reguuid" name="reguuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">收文编号</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">文件类型</td>
								<td style="width: 18%">
									<BZ:select prefix="S_" field="FILE_TYPE" id="S_FILE_TYPE" isCode="true" codeName="WJLX" formTitle="文件类型" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 10%">收文日期</td>
								<td style="width: 34%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />~
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
								
							</tr>
							<tr>	
								<td class="bz-search-title"><span title="男收养人">男收养人</span></td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男方" maxlength="150" />
								</td>
								<td class="bz-search-title">男方国家</td>
								<td>
									<BZ:select prefix="S_" field="MALE_NATION" id="S_MALE_NATION" isCode="true" codeName="GJ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">男出生日期</td>
								<td>
									<BZ:input prefix="S_" field="MALE_BIRTHDAY_START" id="S_MALE_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_MALE_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始男出生日期" />~
									<BZ:input prefix="S_" field="MALE_BIRTHDAY_END" id="S_MALE_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_MALE_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止男出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="150" />
								</td>
								
								<td class="bz-search-title">女方国家</td>
								<td>
									<BZ:select prefix="S_" field="FEMALE_NATION" id="S_FEMALE_NATION" isCode="true" codeName="GJ" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">女出生日期</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_BIRTHDAY_START" id="S_FEMALE_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_FEMALE_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始女出生日期" />~
									<BZ:input prefix="S_" field="FEMALE_BIRTHDAY_END" id="S_FEMALE_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_FEMALE_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止女出生日期" />
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select field="COUNTRY_CODE" formTitle=""
										prefix="S_" isCode="true" codeName="GJSY" width="148px"
										onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_HIDDEN_ADOPT_ORG_ID')">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="148px"
											onchange="_setOrgID('S_HIDDEN_ADOPT_ORG_ID',this.value)">
											<option value="">--请选择--</option>
									</BZ:select>
									<input type="hidden" id="S_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">收养类型</td>
								<td>
									<BZ:select prefix="S_" field="FAMILY_TYPE" id="S_FAMILY_TYPE" isCode="true" codeName="SYLX" formTitle="收养类型" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">是否公约收养</td>
								<td>
									<BZ:select prefix="S_" field="IS_CONVENTION_ADOPT" id="S_IS_CONVENTION_ADOPT" formTitle="" defaultValue="" width="93%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
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
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left" id="anniuqu">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_show()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/>
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="flexme1" >
						<thead id="listtitle">
							<tr>
								<th class="center" width="20">
								</th>
								<th width="40"  >序号</th>
								<th width="80">收文编号</th>
								<th width="80">收文日期</th>
								<th width="80">国家</th>
								<th width="150">收养组织</th>
								<th width="80">文件类型</th>
	                            <th width="80">收养类型</th>
	                            <th width="80">是否公约收养</th>
								<th width="150">男收养人</th>
								<th width="80">男出生日期</th>
	                            <th width="80">男国籍</th>
	                            <th width="80">男文化程度</th>
	                            <th width="80">男健康状况</th>
								<th width="150">女收养人</th>
								<th width="80">女出生日期</th>
	                            <th width="80">女国籍</th>
	                            <th width="80">女文化程度</th>
	                            <th width="80">女健康状况</th>
	                            <th width="80">收养要求</th>
	                            <th width="80">未成年子女数量</th>
	                            <th width="200">家庭需要说明的其他项</th>
	                            <th width="80">政府批准日期</th>
	                            <th width="80">有效期限</th>
	                            <th width="80">批准儿童数量</th>
	                            <th width="80">批准儿童性别</th>
	                            <th width="120">批准收养儿童健康状况</th>
	                            <th width="80">翻译单位	</th>
	                            <th width="80">翻译质量</th>
	                            <th width="80">不合格原因</th>
	                            <th width="80">儿童姓名</th>
								<th width="80">儿童性别</th>
								<th width="80">儿童出生日期</th>
								<th width="80">省份</th>
								<th width="120">福利院</th>
								<th width="80">暂停状态</th>
	                            <th width="80">退文状态</th>
	                            <th width="100">补充文件状态</th>
	                            <th width="80">文件状态</th>
	                            <th width="120">文件位置</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="AF_ID" onlyValue="true"/>#<BZ:data field="CI_ID" onlyValue="true"/>#<BZ:data field="RI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td><BZ:i/></td>
								<td><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
								<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="FAMILY_TYPE" defaultValue="" codeName="SYLX" onlyValue="true"/></td>
								<td><BZ:data field="IS_CONVENTION_ADOPT" defaultValue="" checkValue="0=否;1=是" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NATION" defaultValue="" codeName="GJ" onlyValue="true"/></td>
								<td><BZ:data field="MALE_EDUCATION" defaultValue="" codeName="ADOPTER_EDU" onlyValue="true"/></td>
								<td><BZ:data field="MALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NATION" defaultValue="" codeName="GJ" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_EDUCATION" defaultValue="" codeName="ADOPTER_EDU" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_HEALTH" defaultValue="" codeName="ADOPTER_HEALTH" onlyValue="true"/></td>
								<td><BZ:data field="ADOPT_REQUEST_CN" defaultValue="" /></td>
								<td><BZ:data field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="REMARK_CN" defaultValue="" /></td>
								<td><BZ:data field="GOVERN_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="EXPIRE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="APPROVE_CHILD_NUM" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="CHILDREN_SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX" onlyValue="true"/></td>
								<td><BZ:data field="CHILDREN_HEALTH_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="TRANSLATION_COMPANY" defaultValue="" codeName="FYDW" onlyValue="true"/></td>
								<td><BZ:data field="TRANSLATION_QUALITY" defaultValue="" codeName="WJFYZL" onlyValue="true"/></td>
								<td><BZ:data field="UNQUALITIED_REASON" defaultValue="" /></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="RECOVERY_STATE" defaultValue="" checkValue="1=已暂停;9=取消暂停" onlyValue="true"/></td>
								<td><BZ:data field="RETURN_STATE" defaultValue="" checkValue="0=待确认;1=已确认;2=待处置;3=已处置;9=取消退文" onlyValue="true"/></td>
								<td><BZ:data field="SUPPLY_STATE" defaultValue="" checkValue="0=待补充;1=补充中;2=已补充" onlyValue="true"/></td>
								<td><BZ:data field="AF_GLOBAL_STATE" defaultValue="" codeName="WJQJZT_ZX" onlyValue="true"/></td>
								<td><BZ:data field="AF_POSITION" defaultValue="" codeName="WJWZ" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
					
					<script type="text/javascript">
						$('.flexme1').flexigrid({
							usepager: false,//是否分页
							title: '',
							showTableToggleBtn: true,
							width: 'auto',
						   // onSubmit: addFormData,
							height: '440',
							horizontalScrollPolicy:true,
							nomsg:'没有符合条件的记录存在',
							novstripe: false,//没用过这个属性
							striped: true,  //是否显示斑纹效果，默认是奇偶交互的形式
							resizable: false  //table是否可伸缩
						});
			   		</script>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="文件信息" 
								exportCode="REGISTER_DATE=DATE;COUNTRY_CODE=CODE,GJSY;FILE_TYPE=CODE,WJLX;FAMILY_TYPE=CODE,SYLX;IS_CONVENTION_ADOPT=FLAG,0:否&1:是;MALE_BIRTHDAY=DATE;MALE_NATION=CODE,GJ;MALE_EDUCATION=CODE,ADOPTER_EDU;MALE_HEALTH=CODE,ADOPTER_HEALTH;FEMALE_BIRTHDAY=DATE;FEMALE_NATION=CODE,GJ;FEMALE_EDUCATION=CODE,ADOPTER_EDU;FEMALE_HEALTH=CODE,ADOPTER_HEALTH;GOVERN_DATE=DATE;EXPIRE_DATE=DATE;CHILDREN_SEX=CODE,ADOPTER_CHILDREN_SEX;TRANSLATION_COMPANY=CODE,FYDW;TRANSLATION_QUALITY=CODE,WJFYZL;SEX=CODE,ETXB;BIRTHDAY=DATE;PROVINCE_ID=CODE,PROVINCE;RECOVERY_STATE=FLAG,1:已暂停&9:取消暂停;RETURN_STATE=FLAG,0:待确认&1:已确认&2:待处置&3:已处置&9:取消退文;SUPPLY_STATE=FLAG,0:待补充&1:补充中&2:已补充;AF_POSITION=CODE,WJWZ;AF_GLOBAL_STATE=CODE,WJQJZT_ZX" 
								exportField="FILE_NO=收文编号,15,20;REGISTER_DATE=收文日期,15;COUNTRY_CODE=国家,15;NAME_CN=收养组织,15;FILE_TYPE=文件类型,15;FAMILY_TYPE=收养类型,15;IS_CONVENTION_ADOPT=是否公约收养,15;MALE_NAME=男收养人,15;MALE_BIRTHDAY=男出生日期,15;MALE_NATION=男国籍,15;MALE_EDUCATION=男文化程度,15;MALE_HEALTH=男健康状况,15;FEMALE_NAME=女收养人,15;FEMALE_BIRTHDAY=女出生日期,15;FEMALE_NATION=女国籍,15;FEMALE_EDUCATION=女文化程度,15;FEMALE_HEALTH=女健康状况,15;ADOPT_REQUEST_CN=收养要求,15;UNDERAGE_NUM=未成年子女数量,15;REMARK_CN=家庭需要说明的其他项,15;GOVERN_DATE=政府批准日期,15;EXPIRE_DATE=有效期限,15;APPROVE_CHILD_NUM=批准儿童数量,15;CHILDREN_SEX=批准儿童性别,15;CHILDREN_HEALTH_CN=批准收养儿童健康状况,15;TRANSLATION_COMPANY=翻译单位,15;TRANSLATION_QUALITY=翻译质量,15;UNQUALITIED_REASON=不合格原因,15;NAME=儿童姓名,15;SEX=儿童性别,15;BIRTHDAY=儿童出生日期,15;PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,15;RECOVERY_STATE=暂停状态,15;RETURN_STATE=退文状态,15;SUPPLY_STATE=补充文件状态,15;AF_GLOBAL_STATE=文件状态,15;AF_POSITION=文件位置;"/></td>
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