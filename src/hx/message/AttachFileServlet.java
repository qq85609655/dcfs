/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hx.util.Base64;

import hx.common.j2ee.servlet.BaseServlet;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.FileUtility;

/**
 * @Title: AttachFileServlet.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-3 …œŒÁ10:41:02
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AttachFileServlet extends HttpServlet{
    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private static Log log = UtilLog.getLog(AttachFileServlet.class);
    /* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    /* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            performTask(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void performTask(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        BufferedInputStream bi = null;
        OutputStream os = null;
        InputStream is = null;
        try {
            String fileUrl = request.getParameter("fileUrl");
            fileUrl=URLDecoder.decode(fileUrl,"UTF-8");
            String fileName = request.getParameter("fileName");
            fileName=URLDecoder.decode(fileName,"UTF-8");
            File file = new File(FileUtility.pathProcess(fileUrl));
            if (!file.exists())
            {
                forward(request, response, "/fileError.jsp");
            }
            else
            {
            String extend = FileUtility.getExtension(file.getName()).toLowerCase();
            String _fileName = new String( fileName.getBytes("gb2312"), "ISO8859-1" );
            
                if("doc".equalsIgnoreCase(extend)){
                    response.setContentType("application/msword");
                }else if("xls".equalsIgnoreCase(extend)){
                    response.setContentType("application/vnd.ms-excel");
                } else if ("pps".equalsIgnoreCase(extend)|| "ppt".equalsIgnoreCase(extend))
                {
                    response.setContentType("application/vnd.ms-powerpoint");
                }else if ("zip".equalsIgnoreCase(extend))
                {
                    response.setContentType("application/octet-stream");
                    _fileName = _fileName + "."+extend ;
                }else{
                    response.setContentType("application/unkonw");
                }
                response.setHeader("Content-disposition","attachment; filename=" +_fileName);
                bi = new BufferedInputStream(new FileInputStream(file));
                os = response.getOutputStream();
                byte[] buffer = new byte[1024];
                int count=0;
                while ((count=bi.read(buffer)) != -1){
                    os.write(buffer,0,count);
                }
                os.flush();
                bi.close();
                os.close();
            }
        }catch (Exception e) {
            if (log.isError()) {
                log.logError("œ¬‘ÿ¥ÌŒÛ:" + e.getMessage());
            }
            try {
                forward(request, response, "/fileError.jsp");
            } catch (ServletException e1) {
                e1.printStackTrace();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        } finally {
            if (bi != null) {
                bi.close();
            }
            if (os != null) {
                os.close();
            }
            if (is !=null){
                is.close();
            }
        }
    }

    protected void forward(HttpServletRequest request, HttpServletResponse response,String url) throws ServletException, IOException {
        request.getRequestDispatcher(url).forward(request, response);
    }
 
  }
