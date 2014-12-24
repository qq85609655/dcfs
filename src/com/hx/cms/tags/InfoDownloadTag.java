package com.hx.cms.tags;

import hx.database.databean.DataList;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.upload.datasource.DatasourceManager;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 附件下载:只适应与单附件
 * @author lij
 *
 */
public class InfoDownloadTag extends TagSupport {

    /**
     * 附件ID：优先级高于packageId（即两属性同时存在时只有attId生效）
     */
    private String attId;
    
    /**
     * 附件类型值
     */
    private String attTypeCode;
    
    /**
     * 只适用于单附件：多附件的话则下载列表中的第一个附件
     */
    private String packageId;
    
	/**
	 * 序列化
	 */
	private static final long serialVersionUID = 1130401452084448455L;
	
	@SuppressWarnings("deprecation")
	@Override
	public int doStartTag() throws JspException {
	    HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
	    String downloadUrl = "";
        try {
            
            if(attId != null && !"".equals(attId)){
                if(attTypeCode != null && !"".equals(attTypeCode)){
                    downloadUrl = request.getContextPath() + "/att_upload/Upload." + DatasourceManager.getRequestPrefix() + "?param=downloadAtt&ATT_ID="+attId+"&CODE="+attTypeCode;                    
                }else{
                    downloadUrl = request.getContextPath() + "/att_upload/Upload." + DatasourceManager.getRequestPrefix() + "?param=downloadAtt&ATT_ID="+attId;
                }
            }else{
                if(packageId != null && !"".equals(packageId)){
                    if(attTypeCode != null && !"".equals(attTypeCode)){
                        List<Att> dataList = AttHelper.findAttListByPackageId(packageId,attTypeCode);
                        if(dataList != null && dataList.size() > 0){
                            downloadUrl = request.getContextPath() + "/att_upload/Upload." + DatasourceManager.getRequestPrefix() + "?param=downloadAtt&CODE="+attTypeCode+"&PACKAGE_ID="+packageId;                            
                        }else{
                            downloadUrl = "javascript:alert(\"没有可下载的附件!\");";
                        }
                    }else{
                    	List<Att> dataList = AttHelper.findAttListByPackageId(packageId);
                        if(dataList != null && dataList.size() > 0){
                            downloadUrl = request.getContextPath() + "/att_upload/Upload." + DatasourceManager.getRequestPrefix() + "?param=downloadAtt&PACKAGE_ID="+packageId;                            
                        }else{
                            downloadUrl = "javascript:alert(\"没有可下载的附件!\");";
                        }
                    }
                }else{
                    downloadUrl = "javascript:alert(\"没有可下载的附件!\");";
                }
            }
            pageContext.getOut().println(downloadUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
	}

	@Override
	public int doEndTag() throws JspException {
	    attId = "";
	    attTypeCode = "";
	    packageId = "";
		return EVAL_PAGE;
	}

    /**
     * @return Returns the attId.
     */
    public String getAttId() {
        return attId;
    }

    /**
     * @param attId The attId to set.
     */
    public void setAttId(String attId) {
        this.attId = attId;
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

    /**
     * @return Returns the packageId.
     */
    public String getPackageId() {
        return packageId;
    }

    /**
     * @param packageId The packageId to set.
     */
    public void setPackageId(String packageId) {
        this.packageId = packageId;
    }
}
