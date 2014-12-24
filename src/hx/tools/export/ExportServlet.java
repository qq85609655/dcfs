package hx.tools.export;

import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.BaseServlet;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.manager.ConnectionManager;
import hx.util.DateUtility;
import hx.util.UtilExcel;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 导出执行的Servlet
 */
public class ExportServlet extends BaseServlet {

	private static final long serialVersionUID = -5289872720819905650L;

	@Override
	protected void execute(HttpServletRequest request, HttpServletResponse response) {
		String key = ServletTools.getParameter("page_sql", request);
		String exportType = ServletTools.getParameter("exportType", request);
		String title = ServletTools.getParameter("page_exportTitle", request);
		String fieldName = ServletTools.getParameter("page_exportField", request);
		String fieldCode = ServletTools.getParameter("page_exportCode", request);
		String isShowEN = ServletTools.getParameter("isShowEN", request);//码表是否显示英文
		OutputStream out = null;
		Connection conn = null;
		try {
			conn = ConnectionManager.getConnection();
			if ("xls".equalsIgnoreCase(exportType)) {
				response.reset();
				//response.setHeader("Content-Disposition", "attachment;filename=" + title + "." + exportType);
				response.setContentType("application/x-msdownload");
				String filenameExt = DateUtility.getCurrentDateTime();
				String filename=new String(title.getBytes("gbk"),"iso-8859-1");
				filename+=filenameExt;
				response.setHeader("Content-Disposition", "attachment;filename="+filename +"." + exportType );
				// response.setContentType("application/msexcel");
				out = response.getOutputStream();
				UtilExcel.createXls(conn, out, key, title, fieldName, fieldCode,isShowEN);
				out.flush();
			} else if ("xlsx".equalsIgnoreCase(exportType)) {
				response.reset();
				//response.setHeader("Content-Disposition", "attachment;filename=" + title + "." + exportType);
				response.setContentType("application/x-msdownload");
				String filenameExt = DateUtility.getCurrentDateTime();
				String filename=new String(title.getBytes("gbk"),"iso-8859-1");
				filename+=filenameExt;
				response.setHeader("Content-Disposition", "attachment;filename="+filename +"." + exportType );
				// response.setContentType("application/msexcel");
				out = response.getOutputStream();
				UtilExcel.createXlsx(conn, out, key, title, fieldName, fieldCode);
				out.flush();
			} else if ("pdf".equalsIgnoreCase(exportType)) {
				response.setHeader("Content-Disposition", "attachment;filename=" + title + "." + exportType);
				response.setContentType("application/msexcel");
				out = response.getOutputStream();
				UtilExcel.createXls(conn, out, key, title, fieldName, fieldCode,isShowEN);
				out.flush();
			} else if ("doc".equalsIgnoreCase(exportType)) {
				response.setHeader("Content-Disposition", "attachment;filename=" + title + "." + exportType);
				response.setContentType("application/msexcel");
				out = response.getOutputStream();
				UtilExcel.createXls(conn, out, key, title, fieldName, fieldCode,isShowEN);
				out.flush();
			} else if ("wps".equalsIgnoreCase(exportType)) {
				response.setHeader("Content-Disposition", "attachment;filename=" + title + "." + exportType);
				response.setContentType("application/msexcel");
				out = response.getOutputStream();
				UtilExcel.createXls(conn, out, key, title, fieldName, fieldCode,isShowEN);
				out.flush();
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (DBException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
