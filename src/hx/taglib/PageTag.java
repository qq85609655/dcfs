/**
 * 
 */
package hx.taglib;

import hx.database.databean.DataList;
import hx.util.UtilFormat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.lilystudio.smarty4j.TemplateException;


/**
 * @author lizb
 * 
 */
@SuppressWarnings("unchecked")
public class PageTag extends BzTagSupport {
	private static final long serialVersionUID = -2582111451727618155L;
	private String property;
	private String form;
	private String type;
	private boolean exportCsv;
	private boolean exportXls;
	private boolean exportXlsx;
	private boolean exportPdf;
	private boolean exportDoc;
	private boolean exportWps;
	private String exportTitle;
	private String exportField;
	private String exportCode;
	private boolean isShowEN = false;;
	
	
	public boolean getIsShowEN() {
		return isShowEN;
	}
	public void setIsShowEN(boolean isShowEN) {
		this.isShowEN = isShowEN;
	}
	
	public boolean isExportCsv() {
		return exportCsv;
	}

	public void setExportCsv(boolean exportCsv) {
		this.exportCsv = exportCsv;
	}

	public boolean isExportXls() {
		return exportXls;
	}

	public void setExportXls(boolean exportXls) {
		this.exportXls = exportXls;
	}

	public boolean isExportXlsx() {
		return exportXlsx;
	}

	public void setExportXlsx(boolean exportXlsx) {
		this.exportXlsx = exportXlsx;
	}

	public boolean isExportPdf() {
		return exportPdf;
	}

	public void setExportPdf(boolean exportPdf) {
		this.exportPdf = exportPdf;
	}

	public boolean isExportDoc() {
		return exportDoc;
	}

	public void setExportDoc(boolean exportDoc) {
		this.exportDoc = exportDoc;
	}

	public boolean isExportWps() {
		return exportWps;
	}

	public void setExportWps(boolean exportWps) {
		this.exportWps = exportWps;
	}

	public String getExportTitle() {
		return exportTitle;
	}

	public void setExportTitle(String exportTitle) {
		this.exportTitle = exportTitle;
	}

	public String getExportField() {
		return exportField;
	}

	public void setExportField(String exportField) {
		this.exportField = exportField;
	}

	public String getExportCode() {
		return exportCode;
	}

	public void setExportCode(String exportCode) {
		this.exportCode = exportCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the form
	 */
	public String getForm() {
		return form;
	}

	/**
	 * @param form the form to set
	 */
	public void setForm(String form) {
		this.form = form;
	}

	/**
	 * @return the property
	 */
	public String getProperty() {
		return property;
	}

	/**
	 * @param property the property to set
	 */
	public void setProperty(String property) {
		this.property = property;
	}


	@Override
	protected void doEnd(Map context) throws JspException {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#doStart(java.util.Map)
	 */
	@Override
	protected void doStart(Map context) throws JspException {
	    HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
	    
        try {
            context.put("resourcePath",TagTools.getResourcePath(request, null));
        } catch (TemplateException e) {
            throw new javax.servlet.jsp.JspTagException(UtilFormat.format(p.getString("tagErr"), e.getMessage()));
        }
		DataList list = (DataList) pageContext.findAttribute(getProperty());
		if (list==null){
			list = new DataList(0);
		}
		if (type!=null){
			context.put("type",type);
		}
		if (getExportTitle()!=null && getExportField()!=null){
			context.put("exportCsv", isExportCsv());
			context.put("exportXls", isExportXls());
			context.put("exportXlsx", isExportXlsx());
			context.put("exportPdf", isExportPdf());
			context.put("exportDoc", isExportDoc());
			context.put("exportWps", isExportWps());
			context.put("exportTitle", getExportTitle());
			context.put("exportField", getExportField());
			context.put("exportCode", getExportCode());
			context.put("isShowEN", getIsShowEN());
		}
		context.put("form", getForm());
		int nowPage = list.getNowPage();
		context.put("nowPage", nowPage);
		int pageSize = list.getPageSize();
		context.put("pageSize", pageSize);
		int total = list.getDataTotal();
		context.put("dataTotal", total);
		int pageNum = list.getPageTotal();
		context.put("pageNum", pageNum);
		int previousPage=nowPage-1;
		if (previousPage<1){
			previousPage = 1;
		}
		context.put("previousPage", previousPage);
		int nextPage = nowPage+1;
		if (nextPage>pageNum){
			nextPage = pageNum;
		}
		context.put("nextPage", nextPage);
		int start = ((nowPage-1)*pageSize)+1;
		context.put("start", start);
		int end =nowPage*pageSize;
		context.put("end", end);
		boolean iscount = list.isCount();
		context.put("count", iscount);
		String countSql = list.getCountSql();
		context.put("countSql", countSql);
		String sql = list.getSql();
		context.put("sql", sql);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#getEndTagName()
	 */
	@Override
	protected String[] getEndTagName() throws JspException {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see hx.taglib.BzTagSupport#getStartTagName()
	 */
	@Override
	protected String[] getStartTagName() throws JspException {
		return new String[] { "page", "head" };
	}

}
