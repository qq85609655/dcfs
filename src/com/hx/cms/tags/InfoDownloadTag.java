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
 * ��������:ֻ��Ӧ�뵥����
 * @author lij
 *
 */
public class InfoDownloadTag extends TagSupport {

    /**
     * ����ID�����ȼ�����packageId����������ͬʱ����ʱֻ��attId��Ч��
     */
    private String attId;
    
    /**
     * ��������ֵ
     */
    private String attTypeCode;
    
    /**
     * ֻ�����ڵ��������฽���Ļ��������б��еĵ�һ������
     */
    private String packageId;
    
	/**
	 * ���л�
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
                            downloadUrl = "javascript:alert(\"û�п����صĸ���!\");";
                        }
                    }else{
                    	List<Att> dataList = AttHelper.findAttListByPackageId(packageId);
                        if(dataList != null && dataList.size() > 0){
                            downloadUrl = request.getContextPath() + "/att_upload/Upload." + DatasourceManager.getRequestPrefix() + "?param=downloadAtt&PACKAGE_ID="+packageId;                            
                        }else{
                            downloadUrl = "javascript:alert(\"û�п����صĸ���!\");";
                        }
                    }
                }else{
                    downloadUrl = "javascript:alert(\"û�п����صĸ���!\");";
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
