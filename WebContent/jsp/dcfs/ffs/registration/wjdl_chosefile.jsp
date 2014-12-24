<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
	 * @Description: 原组织收文编号列表
	 * @author mayun   
	 * @date 2014-8-6
	 * @version V1.0   
	 */
	String compositor = (String) request.getAttribute("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
%>
<BZ:html>
	<BZ:head>
		<title>原组织收文编号列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"ffs/registration/toChoseFile.action";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_NAME").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_REGISTER_DATE_START").value = "";
			document.getElementById("S_REGISTER_DATE_END").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
		}
		//生成条形码
		function _barcode(){
			var num = 0;
			var codeuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					codeuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				alert('请选择一条数据');
				return;
			}else{
				window.open(path+"ffs/registration/barCode.action?codeuuid="+codeuuid,'newwindow','height=500,width=480,top=100,left=400,scrollbars=yes');
			}
		}
		//查看
		function _show() {
			var num = 0;
			var showuuid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					showuuid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != "1"){
				alert('请选择一条要查看的数据');
				return;
			}else{
				window.open(path+"ffs/registration/show.action?showuuid="+showuuid,'newwindow','height=550,width=1000,top=70,left=180,scrollbars=yes');
				document.srcForm.submit();
			}
		}
		
		//业务自定义功能操作JS
		
 		 /**
	*
	*根据国家列出所属收养组织
	*@ author :mayun
	*@ date:2014-7-24
	*/
	function _findSyzzNameList(){
		$("#S_ADOPT_ORG_NAME").val("");//清空收养组织名称
		$("#S_ADOPT_ORG_ID").val("");//清空收养组织ID
		var countryCode = $("#S_COUNTRY_CODE").find("option:selected").val();//国家Code
		var language = $("#S_ADOPT_ORG_ID").attr("isShowEN");//是否显示英文
		if(null != countryCode&&""!=countryCode){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=findSyzzNameList&countryCode='+countryCode,
				type: 'POST',
				dataType: 'json',
				timeout: 1000,
				success: function(data){
			       var option ={
				      dataType: 'json',
					  width: 320,        //指定下拉框的宽度. Default: input元素的宽度
					  max: 100,            //下拉显示项目的个数.Default: 10
					  delay :1000,
					  highlight: false,
					  scroll: true,
					  minChars: 0,        //在触发autoComplete前用户至少需要输入的字符数.Default: 1，如果设为0，在输入框内双击或者删除输入框内内容时显示列表
					  autoFill: true,    //要不要在用户选择时自动将用户当前鼠标所在的值填入到input框. Default: false
					  mustMatch:false,    //如果设置为true,autoComplete只会允许匹配的结果出现在输入框,所有当用户输入的是非法字符时将会得不到下拉框.Default: false
				      matchContains: true,//决定比较时是否要在字符串内部查看匹配,如ba是否与foo bar中的ba匹配.使用缓存时比较重要.不要和autofill混用.Default: false
				      cacheLength:1,      //缓存的长度.即对从数据库中取到的结果集要缓存多少条记录.设成1为不缓存.Default: 10
				      matchSubset:false,   //autoComplete可不可以使用对服务器查询的缓存,如果缓存对foo的查询结果,那么如果用户输入foo就不需要再进行检索了,直接使用缓存.通常是打开这个选项以减轻服务器的负担以提高性能.只会在缓存长度大于1时有效.Default: true
				      matchCase:false,    // 比较是否开启大小写敏感开关.使用缓存时比较重要.如果你理解上一个选项,这个也就不难理解,就好比foot要不要到FOO的缓存中去找.Default: false   	  
			          multiple:false,     //是否允许输入多个值即多次使用autoComplete以输入多个值. Default: false
			          multipleSeparator:",",//如果是多选时,用来分开各个选择的字符. Default: ","
			          maxitemstoshow:-1,  //（默认值： -1 ） 限制的结果数量将显示在下拉。这是非常有用的如果您有大量的数据和不想为用户提供一份清单，列出可能包含数以百计的项目。要禁用此功能，将该值设置为-1 。
						
			          formatItem: function(row, i, max){//数据加载处理
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME;
			          	}
			               
			          },
			          formatMatch: function(row, i, max){//数据匹配处理
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME ;
			          	}
			          },
			          formatResult: function(row){//数据结果处理
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME ;
			          	}
			          }            
					}
					$("#S_ADOPT_ORG_NAME").autocomplete(data,option);   
					$("#S_ADOPT_ORG_NAME").setOptions(data).flushCache();//清除缓存
			        $("#S_ADOPT_ORG_NAME").result(function(event, value, formatted){//选择后进行Code赋值操作
			        	$("#S_ADOPT_ORG_ID").val(value.CODEVALUE);
					}); 
				}
			  });
		}else{
			//alert("请选择国家!");
			return false;
		}
	}
	
	//
	function _add(){
		var temp=document.getElementsByName("xuanze");
		for (i=0;i<temp.length;i++){
			if(temp[i].checked){
				var fileNo = temp[i].value;
				window.opener._dySetFileInfo(fileNo);
				window.close();
			}
		}
	}


	</script>
	<BZ:body property="data" codeNames="GJSY;SYZZ">
		<BZ:form name="srcForm" method="post" action="ffs/registration/findList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display:none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">
									<span title="国家">国家</span>
								</td>
								<td style="width: 18%">
									<BZ:select field="COUNTRY_CODE" notnull="请输入国家" formTitle=""
										prefix="S_" isCode="true" codeName="GJSY" width="70%"
										onchange="_findSyzzNameList()">
										<option value="">
											--请选择--
										</option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="收养组织">收养组织</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="ADOPT_ORG_NAME"
										id="S_ADOPT_ORG_NAME" defaultValue="" formTitle="收养组织"/>
									<BZ:input type="hidden" field="ADOPT_ORG_ID" prefix="S_"
										id="S_ADOPT_ORG_ID" defaultValue="" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="收文日期">收文日期</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="REGISTER_DATE_START" id="S_REGISTER_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REGISTER_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始收文日期" />至
									<BZ:input prefix="S_" field="REGISTER_DATE_END" id="S_REGISTER_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REGISTER_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止收文日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title" style="width: 10%">
									<span title="收文编号">收文编号</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO"
										defaultValue="" formTitle="收文编号"/>
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="男收养人">男收养人</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME"
										defaultValue="" formTitle="男收养人"
										restriction="hasSpecialChar" />
								</td>
								<td class="bz-search-title" style="width: 10%">
									<span title="女收养人">女收养人</span>
								</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME"
										defaultValue="" formTitle="女收养人"
										restriction="hasSpecialChar" />
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
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="确&nbsp;&nbsp;定" class="btn btn-sm btn-primary" onclick="_add()"/>&nbsp;
					<input type="button" value="取&nbsp;&nbsp;消" class="btn btn-sm btn-primary" onclick="javascript:window.close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 2%;">
									<div class="sorting_disabled">
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">
										序号
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FILE_NO">
										收文编号
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="REGISTER_DATE">
										收文日期
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="COUNTRY_CN">
										国家
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="NAME_CN">
										收养组织
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="MALE_NAME">
										男收养人
									</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="FEMALE_NAME">
										女收养人
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="dataList">
								<td class="center">
									<input name="xuanze" type="radio" value="<BZ:data field="FILE_NO" onlyValue="true"/>" 
									class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td>
									<BZ:data field="FILE_NO" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="REGISTER_DATE" type="date" dateFormat="yyyy-MM-dd" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY"  />
								</td>
								<td>
									<BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/>
								</td>
								<td>
									<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true" />
								</td>
								<td>
									<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true" />
								</td>
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
							<td><BZ:page form="srcForm" property="List"/></td>
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