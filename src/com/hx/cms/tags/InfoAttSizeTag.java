package com.hx.cms.tags;

import hx.database.databean.Data;
import hx.database.databean.DataList;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: InfoAttSizeTag.java
 * @Description: 文章附件大小标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:36:27 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoAttSizeTag extends TagSupport {
   
    //类型值
    public static final String TYPE_SINGLE = "single";
    public static final String TYPE_MULTIPLE = "multiple";
    
    /**
     * 类型
     *      single : 为返回第一个附件的大小
     *      multiple ： 为返回所有附件大小的总和大小
     */
    private String type = "";
    
    /**
     * 附件类型值
     */
    private String attTypeCode = "";

    /**
     * 序列号
     */
    private static final long serialVersionUID = 396431368880545381L;

    @SuppressWarnings("deprecation")
	public int doStartTag() {
        Tag tag = getParent();
        String packageId = null;
        long size = 0; //默认大小为零
        try {
            if(tag instanceof InfoListTag){
                InfoListTag inforlistTag = (InfoListTag) tag;
                Data data = inforlistTag.getData();
                if (data != null) {
                    packageId = data.getString(Article.ATT_ICON,"");
                }
                
                if(packageId != null && !"".equals(packageId)){
                    DataList dataList = new DataList();
                    if(attTypeCode != null && !"".equals(attTypeCode)){
                        //dataList = AttHelper.findAttsByPackageId(packageId, attTypeCode);
                    }else{
                        //dataList = AttHelper.findAttsByPackageId(packageId);
                    }
                    
                    if(dataList != null && dataList.size() > 0){
                        //单
                        if(InfoAttSizeTag.TYPE_SINGLE.equalsIgnoreCase(type)){
                            Data cur = dataList.getData(0);
                            try {
                                size = Integer.parseInt(cur.getString(Att.ATT_SIZE));
                            } catch (Exception e) {
                                size = 0;
                            }
                        }
                        
                        //多
                        if(InfoAttSizeTag.TYPE_MULTIPLE.equalsIgnoreCase(type)){
                            for (int i = 0; i < dataList.size(); i++) {
                                Data cur = dataList.getData(i);
                                try {
                                    size += Integer.parseInt(cur.getString(Att.ATT_SIZE));
                                } catch (Exception e) {
                                    //不处理
                                }
                            }
                        }
                    }
                }
            }
            pageContext.getOut().println(size);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
    
    @Override
    public int doEndTag() throws JspException {
        type = "";
        attTypeCode = "";
        return EVAL_PAGE;
    }

    /**
     * @return Returns the type.
     */
    public String getType() {
        return type;
    }

    /**
     * @param type The type to set.
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return Returns the attTypeCode.
     */
    public String getAttTypeCode() {
        return attTypeCode;
    }

    /**
     * @param attTypeCode The attTypeCode to set.
     */
    public void setAttTypeCode(String attTypeCode) {
        this.attTypeCode = attTypeCode;
    }
}
