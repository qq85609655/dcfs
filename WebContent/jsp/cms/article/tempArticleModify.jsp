<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.cms.article.vo.AuditOpinion"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
	//审核情况列表
	DataList dataList = (DataList)request.getAttribute("dataList");
	
	//审核人权限
	String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
	//当前栏目不审核的话有此标志
	String isAuth = (String)request.getAttribute("IS_AUTH");
	//获取文章ID
	String id=(String)request.getParameter("ID");
%>
<BZ:html>
<BZ:head>
<title>修改页面</title>
<up:uploadResource/>
<BZ:script isEdit="true" isDate="true"/>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/ueditor.all.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="gbk" src="<BZ:url/>/ueditor/lang/zh-cn/zh-cn.js"></script>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/ueditor/themes/default/css/ueditor.css"/>
<script>
	//保存
	function tijiao()
	{
		//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		/* var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true); */
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
	
 		document.srcForm.action=path+"article/Article!modify.action";
 		document.srcForm.target = "_self";
 		document.srcForm.submit();
 		
 		//关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	//提交审核
    function tijiaoshenhe(){
    	//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
		//提交审核时，验证审核人是否已经选择
		var shr = document.getElementById("AUDITPERSON_ARTICLE_RELA").value.trim();
		if(shr==""){
			alert("请选择审核人！");
			return;
		}
	    document.srcForm.action=path+"article/Article!submitAuditSingle.action";
	    document.srcForm.target = "_self";
	    document.srcForm.submit();
	    
	    //关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
    }
	
	//直接发布
	function fabu()
	{
		//验证标题、内容是否填写
		var title = document.getElementById("Article_TITLE").value.trim();
		/* var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var content = oEditor.GetXHTML(true); */
		if(title==""){
			alert("标题不能为空,请填写标题！");
			return;
		}
	
		document.srcForm.action=path+"article/Article!tempModifyDirect.action";
		document.srcForm.target = "_self";
	 	document.srcForm.submit();
 	
 		//关闭，并刷新上级页面
 		window.close();
 		window.opener.document.srcForm.action =path+"article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=<%=(String)request.getAttribute(Article.CHANNEL_ID) %>";
 		window.opener.document.srcForm.submit();
	}
	
	function _back(){
	var ID = document.getElementById("CHANNEL_ID").value;
 	document.srcForm.action=path+"article/Article!queryChildren.action?CHANNEL_ID="+ID;
 	document.srcForm.submit();
	}
	
	//运行时加载，初始化fckeditor，然后显示要修改的内容
	<%-- window.onload = function(){
		//设定编辑区域高度
		_editAreaScroll();
	
		var oFCKeditor = new FCKeditor('Article_CONTENT');
		oFCKeditor.BasePath = "<%=path %>/fckeditor/";
		oFCKeditor.Height = "600";
		oFCKeditor.ReplaceTextarea() ;
	}
	 --%>
	//清楚fckedit内容的格式
	function clearStyle(){
		var con_true = getEditorContents(true);
		con_true = trimAll(con_true);
		con_true = replaceBrToDiv(con_true);
		var filterContent = delHtmlTag(con_true);
		filterContent = "<font face='宋体;楷体' style='text-indent:2em;line-height:100%'>" + filterContent + "</font>";
		SetContents(filterContent);
	}
	
	//删除所有HTML标签除了P和br标签和div标签
	function delHtmlTag(str){
        //return str.replace(/<[^>]+>/g,"");//去掉所有的html标记
		return str.replace(/<(?!\/?p|br|div\b)[^>]+>/ig,"");
	}
	
	//去除换行
	function clearBr(key){
	    //key = key.replace(/<\/?.+?>/g,"<p>");
	    key = key.replace(/[\r\n]/g, "");
	    return key;
	}
	
	//替换多个br成一个br
	function replaceBrToDiv(str){
		return str.replace(/(<br *> *)+/g, "<br>").replace(/(<br *\/> *)+/g, "<br>");
	}
	
	//去掉所有&nbsp;和空白
	function trimAll(str){
		return str.replace(/&nbsp;/g, "").replace(/ /g, "");
	}
	
	/*---------FCK处理部分开始-----------*/
	//获取编辑器中内容
	function getEditorContents(bol){
   		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
   		return oEditor.GetXHTML(bol);
	}
	//向编辑器插入指定代码
	function insertHTMLToEditor(codeStr){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		oEditor.InsertHtml(codeStr);
	}
	//统计编辑器中内容的字数
	function getLength(){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT");
		var oDOM = oEditor.EditorDocument;
		var iLength ;
		if(document.all){
			iLength = oDOM.body.innerText.length;
		}else{
			var r = oDOM.createRange();
			r.selectNodeContents(oDOM.body);
			iLength = r.toString().length;
		}
		alert(iLength);
	}
	//执行指定动作
	function ExecuteCommand(commandName){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT") ;
		oEditor.Commands.GetCommand(commandName).Execute() ;
	}
	//设置编辑器中内容
	function SetContents(codeStr){
		var oEditor = FCKeditorAPI.GetInstance("Article_CONTENT") ;
		oEditor.SetHTML(codeStr) ;
	}
	/*---------FCK处理部分结束-----------*/
	//选择栏目
	/* function changeChannel(){
		var reValue = window.showModalDialog(path+"channel/Channel!generateTreeForPerson.action?treeDispatcher=changeChannelTree", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		document.getElementById("CHANNEL_ID").value = reValue["value"];
		document.getElementById("CHANNEL_NAME").value = reValue["name"];
	} */
	
	//预览
	function _chakan(){
		window.open("about:blank","_chakan");
		//document.srcForm.action=path+"article/Article!detailArt.action?<%=Article.ID %>=<%=id %>,PERSIST";
		document.srcForm.action=path+"article/Article!detailArtScan.action";
		document.srcForm.target = "_chakan";
		document.srcForm.submit();
		document.srcForm.target = "_self";
  	}
  	
  	//设置编辑区告诉
  	function _editAreaScroll(){
  		/*
  		var height_ = document.body.clientHeight;
  		var n_height = (height_ * 90) / 100;
  		document.getElementById("_kuangjia").style.height = n_height;
  		*/
  		document.getElementById("_kuangjia").style.overflow = "scroll";
  	}
  	
  	function num_span_sh(id,in_){
  		var span_ = document.getElementById(id);
  		if(in_.checked == true){
  			span_.style.display = "inline";
  		}else{
  			span_.style.display = "none";
  			var inputs = span_.getElementsByTagName("input");
  			if(inputs.length > 0){
  				for(var i = 0; i < inputs.length; i++){
  					inputs[i].value = "";
  				}
  			}
  		}
  	}
  	
  	function hiddenInput_(id,in_,name,value){
  		var span1 = document.getElementById(id);
  		var html_ = span1.innerHTML;
  		if(in_.checked == false){
  			span1.innerHTML = html_ + '<input type="hidden" name="'+name+'" value="'+value+'" />';
  		}
  	}
  	
  	//数据授权
  	function  _dataAccess(id){
  		var node = document.getElementById(id);
  		var value = node.value;
  		if(value == "1" && node.checked){
  			/* document.getElementById("Article_DATA_ACCESS_PERSON").checked=false; */
  			document.getElementById("Article_DATA_ACCESS_ORGAN").checked=false;
  			document.getElementById("PERSON_ARTICLE_RELA").value = "";
  			document.getElementById("IDS_PERSON_ARTICLE_RELA").value = "";
  			document.getElementById("ORGAN_ARTICLE_RELA").value = "";
  			document.getElementById("IDS_ORGAN_ARTICLE_RELA").value = "";
  		}
  		if((value == "2" && node.checked) || (value == "3" && node.checked)){
  			document.getElementById("Article_DATA_ACCESS_PUBLIC").checked=false;
  		}
  		
  		if((value == "2" && node.checked)){
  			//弹出人员树
  			_showHelper('PERSON_ARTICLE_RELA','IDS_PERSON_ARTICLE_RELA','选择人员','SYS_ORGAN_PERSON','','','3','true');
  			
  			/* var selectedids = document.getElementById("IDS_PERSON_ARTICLE_RELA").value;
			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
			document.getElementById("IDS_PERSON_ARTICLE_RELA").value = ids; */
  		}
  		
  		if((value == "3" && node.checked)){
  			//组织树
  			_showHelper('ORGAN_ARTICLE_RELA','IDS_ORGAN_ARTICLE_RELA','选择组织','SYS_ORGAN','','','3','true');
  			
  			/* var selectedids = document.getElementById("IDS_ORGAN_ARTICLE_RELA").value;
  			var ids = window.showModalDialog(path+"article/Article!toDataAccess.action?DATA_ACCESS="+value+"&SELECTEDNODE="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
  			document.getElementById("IDS_ORGAN_ARTICLE_RELA").value = ids; */
  		}
  	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="SECURITY_LEVEL;SECURITY_XX;SKIP_CHANNEL_TPL;SYS_CHANNELS;SYS_ORGAN;SYS_ORGAN_PERSON">
<BZ:form name="srcForm" method="post">

<table style="width: 870px;height: 100%" cellpadding="0" cellspacing="0" border="0" align="center">
	<tr>
		<td height="100%">
			<div id="_kuangjia" class="kuangjia" style="margin: 0px;margin-top: 10px;height: 100%">
			<div class="heading">修改内容</div>
			<!-- 当前修改的组织机构ID -->
			<BZ:input field="ID" type="hidden" prefix="Article_" defaultValue=""/>
			<!-- 栏目ID -->
			<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
			<table class="contenttable">
			
			<tr height="30px">
			<td class="title">所属栏目：</td>
			<td colspan="3">
				<BZ:input id="CHANNEL_ID" field="CHANNEL_ID" prefix="Article_" type="hidden" defaultValue=""/>
				<BZ:dataValue field="CHANNEL_ID" defaultValue="" codeName="SYS_CHANNELS"/>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title"><font style="vertical-align: middle;" color="red">*</font>标　 题：</td>
			<td colspan="3">
				<textarea name="Article_TITLE" style="width:600px;height:60px;text-align: center;"><%=data.getString(Article.TITLE,"") %></textarea>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">关&nbsp;&nbsp;键&nbsp;&nbsp;字：</td>
			<td colspan="3"><BZ:input field="SHORT_TITLE" prefix="Article_" type="String" style="width:66%" defaultValue=""/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">来　　源：</td>
			<td colspan="3"><BZ:input field="SOURCE" prefix="Article_" style="width:66%" defaultValue=""/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">排&nbsp;&nbsp;序&nbsp;&nbsp;号：</td>
			<td colspan="3"><BZ:input field="SEQ_NUM" prefix="Article_" defaultValue=""/></td>
			</tr>
			
			<tr>
			<td class="title" >密　　级：</td>
			<td><BZ:dataValue field="SECURITY_LEVEL" onlyValue="true" codeName="SECURITY_LEVEL" defaultValue="无"/></td>
			<td class="title" >保密期限：</td>
			<td><BZ:dataValue field="PROTECT_PERIOD" onlyValue="true" codeName="SECURITY_XX" defaultValue="无"/></td>
			</tr>
			
			<tr height="30px">
			<td class="title">特　　性：</td>
			<td colspan="3" style="font-weight: bold;">
				<span id="is_top_span">
					<input type="checkbox" name="Article_IS_TOP" value="1" <%="1".equals(data.getString("IS_TOP"))?"checked='checked'":"" %> onclick="hiddenInput_('is_top_span',this,'Article_IS_TOP','0');">置顶
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_new_span">
					<input type="checkbox" name="Article_IS_NEW" value="1" onclick="num_span_sh('time_span',this);hiddenInput_('is_new_span',this,'Article_IS_NEW','0');" <%="1".equals(data.getString("IS_NEW"))?"checked='checked'":"" %>>显示new标记
				</span>
				<span id="time_span" style='<%="1".equals(data.getString("IS_NEW"))?"display: inline;":"display: none;" %>'>
					时间<BZ:input field="NEW_TIME" prefix="Article_" defaultValue="" style="width:50px;"/>天
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_receipt_span">
					<input type="checkbox" name="Article_IS_RECEIPT" value="1" <%="1".equals(data.getString("IS_RECEIPT"))?"checked='checked'":"" %> onclick="hiddenInput_('is_receipt_span',this,'Article_IS_RECEIPT','0');">允许回执
				</span>
				
				<%-- <span id="is_skip_span">
					<input type="checkbox" name="Article_IS_SKIP" value="1" <%="1".equals(data.getString("IS_SKIP"))?"checked='checked'":"" %> onclick="num_span_sh('template_span',this);hiddenInput_('is_skip_span',this,'Article_IS_SKIP','0');">弹出
				</span>
				<span id="template_span" style='<%="1".equals(data.getString("IS_SKIP"))?"display: inline;":"display: none;" %>'>
					模板<BZ:select field="TEMPLATE_ID" formTitle="" prefix="Article_" isCode="true" codeName="SKIP_CHANNEL_TPL" width="70px"/>
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<span id="is_common_soft_span">
					<input type="checkbox" name="Article_IS_COMMON_SOFT" value="1" onclick="num_span_sh('num_span',this);hiddenInput_('is_common_soft_span',this,'Article_IS_COMMON_SOFT','2');" <%="1".equals(data.getString("IS_COMMON_SOFT"))?"checked='checked'":"" %>>常用软件
				</span>
				<span id="num_span" style='<%="1".equals(data.getString("IS_COMMON_SOFT"))?"display: inline;":"display: none;" %>'>
					排序<BZ:input field="COMMON_SOFT_SEQ_NUM" prefix="Article_" defaultValue="" style="width:50px;"/>
				</span> --%>
			</td>
			</tr>
			
			<tr height="30px">
			<td class="title">权　　限：</td>
			<td colspan="3" style="font-weight: bold;">
				<input type="checkbox" id="Article_DATA_ACCESS_PUBLIC" name="DATA_ACCESS" value="1" onclick="_dataAccess(this.id)" <%="1".equals(data.getString(Article.DATA_ACCESS))?"checked='checked'":"" %>>公开
				<%-- <input type="checkbox" id="Article_DATA_ACCESS_PERSON" name="DATA_ACCESS" value="2" onclick="_dataAccess(this.id)" <%=data.getString(Article.DATA_ACCESS)!=null&&data.getString(Article.DATA_ACCESS).contains("2")?"checked='checked'":"" %>>
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_PERSON')" style="text-decoration: none;">人员授权</a> --%>
				<input type="checkbox" id="Article_DATA_ACCESS_ORGAN" name="DATA_ACCESS" value="3" onclick="_dataAccess(this.id)" <%=data.getString(Article.DATA_ACCESS)!=null&&data.getString(Article.DATA_ACCESS).contains("3")?"checked='checked'":"" %>>
				<a href="javascript:_dataAccess('Article_DATA_ACCESS_ORGAN')">组织授权</a>
				
				<input type="hidden" id="PERSON_ARTICLE_RELA" name="PERSON_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_PERSON_ARTICLE_RELA" name="IDS_PERSON_ARTICLE_RELA" value='<%=data.getString("IDS_PERSON_ARTICLE_RELA","") %>'/>
				<input type="hidden" id="ORGAN_ARTICLE_RELA" name="ORGAN_ARTICLE_RELA"/>
				<input type="hidden" id="IDS_ORGAN_ARTICLE_RELA" name="IDS_ORGAN_ARTICLE_RELA" value='<%=data.getString("IDS_ORGAN_ARTICLE_RELA","") %>'/>
			</td>
			</tr>
			<%
				//判断栏目是否为审核
				if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
			%>
			<tr>
				<td class="title">审&nbsp;&nbsp;核&nbsp;&nbsp;人：</td>
				<td colspan="3">
					<BZ:input prefix="IDS_" field="AUDITPERSON_ARTICLE_RELA" type="helper" helperCode="SYS_ORGAN_PERSON" helperTitle="选择人员" treeType="3" helperSync="true" showParent="false" defaultShowValue="" showFieldId="AUDITPERSON_ARTICLE_RELA" property="data" style="width:600px;" />
				</td>
			</tr>
			<%
				}
			%>
			<tr height="30px">
			<td colspan="4">
				<script id="editor" type="text/plain" name="myContent" style="width:800px;height:600px;">
					<%=data.getString("CONTENT","") %>
				</script>
				<div class="con-split"></div>
			</td>
			</tr>
			
			<tr height="35px">
			<td class="title">附　　件：</td>
			<td colspan="3">
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT" 
					id="PACKAGE_ID" 
					name="Article_PACKAGE_ID" 
					packageId="<%=data.getString(Article.PACKAGE_ID) %>"
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			</tr>
			
			<%-- <tr height="35px">
			<td class="title" style="width: 120px;">附件图标：</td>
			<td style="width: 300px;">
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT_ICON" 
					id="ATT_ICON" 
					name="Article_ATT_ICON" 
					packageId="<%=data.getString(Article.ATT_ICON) %>"
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			<td class="title" style="white-space: nowrap;">附件说明：</td>
			<td>
				<up:uploadBody 
					attTypeCode="CMS_ARTICLE_ATT_DESC" 
					id="ATT_DESC" 
					name="Article_ATT_DESC" 
					packageId="<%=data.getString(Article.ATT_DESC) %>"
					queueStyle="border: solid 1px #CCCCCC;width:280px"
					selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
					/>
			</td>
			</tr> --%>
			
			</table>
			</div>
		</td>
	</tr>
	
	<tr>
		<td height="30px;">
			<!-- 尾部 -->
			<div class="kuangjia" style="margin: 0px;margin-top: 5px;">
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
			<td align="center" style="padding-right:30px" colspan="2">
				<input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
				<%
					//如果栏目为审核才可能进入判断是否为审核人
					if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
				%>
				<input type="button" style="width: 80px" value="提交审核" class="button_add" onclick="tijiaoshenhe();"/>&nbsp;&nbsp;
				<%
					}
				%>
				<input type="button" style="width: 80px" value="直接发布" class="button_add" onclick="fabu()"/>&nbsp;&nbsp;
				<input type="button" value="预览" class="button_select" onclick="_chakan()"/>&nbsp;&nbsp;
				<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;
				<!-- <input type="button" value="返回" class="button_back" onclick="_back()"/> -->
				<input type="button" value="关闭" class="button_delete" onclick="window.close();"/>
			</td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<%
				if(dataList != null && dataList.size() > 0){
			%>
			<div style="width: 805px;" class="kuangjia">
			<div class="heading" style="width: 805px;">历史审核意见</div>
			<table class="contenttable" style="width: 805px;" cellspacing="0" cellpadding="0">
			<%
					for(int i = 0; i < dataList.size(); i++){
						Data audit = dataList.getData(i);
			%>
				<tr>
					<td style="border-top-width: 2px;border-top-color: #AED0F6;border-top-style: solid;border-bottom-width: 2px;border-bottom-color: #AED0F6;border-bottom-style: solid;border-left-width: 1px;border-left-color: #5FA1ED;border-left-style: solid;border-right-width: 1px;border-right-color: #5FA1ED;border-right-style: solid;">
						<table>
							<tr>
								<td style="font-size: 18px">
								<%=audit.getString(AuditOpinion.AUDIT_OPINION,"") %></td>
								<td></td>
							</tr>
							<tr>
								<td width="10%"></td>
								<td width="93%"style="color: #898989">&nbsp;&nbsp;&nbsp;&nbsp;<%=audit.getString(AuditOpinion.USER_NAME,"") %>&nbsp;&nbsp;审核于：&nbsp;&nbsp;<%=audit.getString(AuditOpinion.AUDIT_TIME,"") %></td>
							</tr>
							
						</table>
					</td>
				</tr>
			<%
					}
			%>
			</table>
			</div>
			<%
				}
			%>
		</td>
	</tr>
</table>

</BZ:form>

<script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e);
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e);
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value);
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml());
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'));
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt);
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱");
    }
</script>
</BZ:body>
</BZ:html>