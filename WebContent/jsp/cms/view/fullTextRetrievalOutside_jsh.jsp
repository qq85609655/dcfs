<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.jsh.law.vo.LawCode"%>
<%@page import="org.jsh.publication.vo.Publication"%>
<%@ taglib prefix="cms" uri="/WEB-INF/taglib/cms"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
	DataList channelList = (DataList)request.getAttribute("channelList");
	
	//����ָ��ָ��������
	String content = (String)request.getAttribute(Article.CONTENT);
	//ѡ�е���Ŀ
	String selectChannelId = (String)request.getAttribute(Article.CHANNEL_ID);
	//ȫ�ļ�������
	String searchType = (String)request.getAttribute(Article.SEARCH_TYPE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<cms:html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
<title></title> 
<meta name="description" content="" /> 
<meta name="keywords" content="" /> 
<cms:script />
<link href="<BZ:resourcePath />/main/css/wpage.css" rel="stylesheet" type="text/css" /> 
<!--Բ��JS start--> 
<script type="text/JavaScript" src="<BZ:resourcePath />/main/js/curvycorners.src.js"></script> 
<!--Բ��JS end-->

<!-- ����ҳ��Ŀ���νṹ��ʼ -->
<script language="javascript" type="text/javascript">
function w(vd)
{
  var ob=document.getElementById(vd);
  if(ob.style.display=="block" || ob.style.display=="")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
}
function k(vd)
{
  var ob=document.getElementById(vd);  
  if(ob.style.display=="block")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
}
</script>
<!-- ����ҳ��Ŀ���νṹ���� -->

<!-- ȫ�ļ�����ʼ -->
<script type="text/javascript">
function submitSearchForm(){

	var cont = document.getElementById("CONTENT").value;
	if(cont == null || cont.length == 0 || cont.trim().length == 0){
		alert("�������ݲ���Ϊ��!");
		return false;
	}
	//��շ�ҳpage��ֵ
	document.getElementById("channelList_page").value = 1;
	document.getElementById("channelList").target = "frmright";
	document.getElementById("channelList").action = "<BZ:url/>/article/FullText.action";
	document.getElementById("channelList").submit();
	document.getElementById("channelList").target = "_self";
}
</script>
<!-- ȫ�ļ������� -->
</head> 
<body style="margin: 0"> 
<div class="main"> 
    <!--search start-->
    <cms:form id="channelList" action="article/FullText.action">
    <div class="search2"> 
    	<div class="search2T"> 
            <div class="search_L search2L"> 
            <input id="CONTENT" name="CONTENT" type="text" value='<%=content!=null?content:"" %>' class="text_search"/>
            <select name="SEARCH_TYPE">
	        	<option value="1" <%="1".equals(searchType)?"selected='selected'":"" %>>ȫ�ļ���</option>
	        	<option value="2" <%="2".equals(searchType)?"selected='selected'":"" %>>����</option>
	        </select>
            <select name="CHANNEL_ID"> 
                <option value="0" <%="0".equals(selectChannelId)?"selected='selected'":"" %> title="������Ŀ">������Ŀ</option>
	        	<%
	        		if(channelList != null){
	        			for(int i = 0; i < channelList.size(); i++){
	        			    Data data = channelList.getData(i);
	        			    if("0".equals(data.getString(Channel.PARENT_ID))){
	        			        for(int k = 0; k < channelList.size(); k++){
	        			            Data first = channelList.getData(k);
									if(data.getString(Channel.ID).equals(first.getString(Channel.PARENT_ID))){
										//�ڶ���
										%>
										<option <%=selectChannelId.equals(first.getString(Channel.ID))?"selected='selected'":"" %> value="<%=first.getString(Channel.ID) %>" title="<%=first.getString(Channel.NAME) %>">&nbsp;�� <%=first.getString(Channel.NAME) %></option>
										<%
										for(int j = 0; j < channelList.size(); j++){
										    Data second = channelList.getData(j);
										    if(first.getString(Channel.ID).equals(second.getString(Channel.PARENT_ID))){
										    	//������
										        %>
										        <option <%=selectChannelId.equals(second.getString(Channel.ID))?"selected='selected'":"" %> value="<%=second.getString(Channel.ID) %>" title="<%=second.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� <%=second.getString(Channel.NAME) %></option>
										        <%
										        for(int m = 0; m < channelList.size(); m++){
										            Data third = channelList.getData(m);
										            //ȥ��������ʾ����Ŀ���������
										            if(second.getString(Channel.ID).equals(third.getString(Channel.PARENT_ID)) && !"263ad245-643d-4b19-85e4-bb92a6278553,e42a11c0-ca76-4175-bfbe-b55062151dee,e9288955-486a-4e10-8116-79f9bc23f910".contains(third.getString(Channel.PARENT_ID))){
										                //���ļ�
														%>
														<option <%=selectChannelId.equals(third.getString(Channel.ID))?"selected='selected'":"" %> value="<%=third.getString(Channel.ID) %>" title="<%=third.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� <%=third.getString(Channel.NAME) %></option>
														<%
										            }
										        }
										    }
										}
									}	        			            
	        			        }
	        			    }
	        			}
	        		}
				%>
            </select> 
            <input type="button" value="�� ��" class="btn_search" onclick="submitSearchForm();"/> 
            </div> 
            <div class="search2R">��ǰλ�ã�<a href="#">��ҳ</a>&nbsp;&gt;&nbsp;ȫ�ļ���</div> 
        </div> 
        <div class="search2F">&nbsp;</div> 
    </div> 
    <!--search end--> 
    <!--part1 start--> 
    <div class="mainB"> 
    	<div class="mainB_L"> 
        	<div class="mainB_Lt"> 
                <div><img src="<BZ:resourcePath />/main/images/part_bg4.gif" /></div>
            	<div class="fblod">
            		ȫ�ļ���
            	</div>
                <div><img src="<BZ:resourcePath />/main/images/part_bg6.gif" /></div>
                <!-- 
                <div class="mainB_Lt_f radius1">
                	<span class="spanL_part">menu</span>
                    <span class="spanR_part"><img src="<BZ:resourcePath />/main/images/dot_7.gif" /></span>
                </div>
                -->
            </div> 
            <!-- 
            <div class="mainB_Lm"> 
            	<div class="mainB_Lm_t"><a href="http://202.106.90.12:81/" target="_blank">��ҵ���ݿ�</a></div> 
                <div class="tab_part"> 
                	<a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=mt" target="_blank">ú̿</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=sy" target="_blank">ʯ��</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=gt" target="_blank">����</a>
                    <a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=jx" target="_blank">��е</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=fdc" target="_blank">���ز�</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=dl" target="_blank">����</a>
                    <a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=qc" target="_blank">����</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=sh" target="_blank">ʯ��</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=jt" target="_blank">��ͨ</a>
                </div> 
            </div> 
            <div class="mainB_Lm"> 
            	<div class="mainB_Lm_t"><a href="<BZ:url/>/law/list.action?PART_ID=1" target="_self">���ɷ���</a></div> 
                <div class="tab_part2"> 
                	<ul> 
                    	<li><a href="<BZ:url/>/law/list.action?PART_ID=94cc08a0-19db-4a39-b38b-94ab7c1cbe83" target="_self">����ί���¹淶���ļ�</a></li> 
                        <li><a href="<BZ:url/>/law/list.action?PART_ID=b478cd2b-52dc-4627-b368-944c0cd8e682" target="_self">���ع��ʼ���ƶ�</a></li> 
                        <li><a href="<BZ:url/>/law/list.action?PART_ID=6ca9aa3a-e6be-48ff-9389-59727bc96594" target="_self">��˰�����</a></li> 
                        <li><a href="<BZ:url/>/law/list.action?PART_ID=1" target="_self">���ҷ������ݿ�</a></li> 
                    </ul> 
                </div> 
            </div> 
             -->
        </div> 
        <div class="mainB_R"> 
        	<div class="tab4_t radius3"> 
                <span class="spanL_navb bg2">ȫ�ļ���</span> 
            </div> 
            <div class="mainB_Rf"> 
            	<div class="list_bjtj">
                    <ul>
                    <!-- 
                    <cms:infoList dataList="<%=dataList %>" type="page" forData="art">
					<%
						//Data art = (Data)pageContext.findAttribute("art");
					%>
					<li>
						<cms:infoTitle titleLength="40" link="true" href="article/Article!detailArt.action"/>
						<cms:infoPublishTime dateFormat="yyyy-MM-dd"/>
					</li>
					</cms:infoList>
					 -->
					<%
						if(dataList != null && dataList.size() > 0){
							for(int i = 0; i < dataList.size(); i++){
								Data data = dataList.getData(i);
								if("CMS".equals(data.getString("TYPE"))){
					%>
					<li>
						<a target="_blank" title="<%=data.getString(Article.TITLE) %>" href="<BZ:url/>/article/Article!detailArt.action?ID=<%=data.getString(Article.ID) %>"><%=data.getString(Article.TITLE) %></a>
						<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getString(Article.CREATE_TIME))) %>
					</li>
					<%
								}
								
								if("LAW".equals(data.getString("TYPE"))){
					%>
					<li>
						<a target="_blank" title="<%=data.getString(LawCode.TITLE) %>" href="<BZ:url/>/law/detail.action?ID=<%=data.getString(LawCode.ID) %>"><%=data.getString(LawCode.TITLE) %></a>
						<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getString(LawCode.CREATE_TIME))) %>
					</li>
					<%
								}
								
								if("PUBLICATION".equals(data.getString("TYPE"))){
					%>
					<li>
						<a target="_blank" title="<%=data.getString(Publication.TITLE) %>" href="<BZ:url/>/publication/Publication!detailLeft.action?ID=<%=data.getString(Publication.ID) %>"><%=data.getString(Publication.TITLE) %></a>
						<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getString(Publication.CREATE_TIME))) %>
					</li>
					<%
								}
							}
						}
					%>
                    </ul> 
                    <div class="clr"></div> 
                </div> 
                <!-- page start--> 
                <cms:infoPage formId="channelList" dataList="<%=dataList %>">
                <div class="page">
                	��&nbsp;<cms:totalSize/>��&nbsp;
                    <a style="cursor: pointer;" onclick="<cms:pageHead/>">��ҳ</a> 
                    <a style="cursor: pointer;" onclick="<cms:pagePrevious/>">��һҳ</a>
                    <a style="cursor: pointer;" onclick="<cms:pageNext/>">��һҳ</a>
                    <a style="cursor: pointer;" onclick="<cms:pageTail/>">βҳ</a>
                    &nbsp;ת����<input type="text" id="gotoPage" value="<cms:page/>" size="3" />/<cms:pageTotal/>ҳ
                    &nbsp;<input type="button" value="�ύ" onclick="_pageGoto('channelList','',document.getElementById('gotoPage').value,<cms:pageTotal/>)"/>
                </div> 
                </cms:infoPage>
               <!-- page end--> 
            </div> 
        </div> 
    	<div class="clr"></div> 
    </div> 
    </cms:form>
    <!--part1 end--> 
    <!--footer start--> 
    <div class="footer">
    	����ά�������»Ṥ���֣����ģ�  &nbsp;&nbsp;&nbsp;&nbsp; �绰��010-64471803/64471805<br />
          ����ί���»��ַ�������ж���������������56��(100011)<br/>
    </div>
    <!--footer end--> 
</div> 
</body> 
</cms:html> 