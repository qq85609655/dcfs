/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

/**
 * @Title: MultiPartRequest.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-2 下午02:24:33
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MultiPartRequest {

    private HttpServletRequest m_request = null;

    private String m_boundary = null;

    private int m_allowedTotalSize = MessageConfig.getUploadsize()* 1024 * 1024;

    private Properties parampairs = new Properties();

    private Properties filepairs = new Properties();

    private HashMap fileparam = new HashMap();

    private HashMap filecontenttype = new HashMap();

    private String curr_field_name;

    private String curr_file_name;

    /** 处理ServletInputStream */
    class ServletInputStreamProcessor {
        private ServletInputStream servletIns = null;

        private int totalLength = 0;

        private int totalRead = 0;

        private byte[] buffer = new byte[4 * 1024];

        public ServletInputStreamProcessor(ServletInputStream ins,
                int totalLength) {
            this.servletIns = ins;
            this.totalLength = totalLength;
        }

        /** 读取一行直到遇到一个换行符 */
        public String readLine() throws IOException {
            int curRead;
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            do {
                curRead = readLine(buffer, 0, buffer.length);
                if (curRead != -1) {
                    bos.write(buffer, 0, curRead);
                }
            } while (curRead == buffer.length);
            bos.flush();
            // System.out.println(bos.size());
            byte[] bytes = bos.toByteArray();
            if (bytes.length == 0) {
                return null;
            }
            return new String(bytes, 0, bytes.length - 2, m_encoding);
        }

        public int readLine(byte[] buffer, int off, int length)
                throws IOException {
            if (totalRead >= totalLength) {
                return -1;
            }
            if (length > totalLength - totalRead) {
                length = totalLength - totalRead;
            }
            int readLen = servletIns.readLine(buffer, off, length);
            totalRead += readLen;
            return readLen;
        }
    }

    /**
     * 检查Content-Disposition: form-data;行 Creation date: (2000-12-22 12:27:12)
     * 
     * @exception java.io.IOException
     *                The exception description.
     */
    private boolean checkDisposition(String str) throws java.io.IOException {
        String ds = "content-disposition: form-data;";
        String h_field = "name=\"";
        String h_file = "filename=\"";
        if (!str.toLowerCase().startsWith(ds)) {
            return false;
        }
        int idx1 = str.indexOf(h_field);
        if (idx1 == -1) {
            return false;
        }
        idx1 += h_field.length();
        int idx2 = str.indexOf("\"", idx1);
        this.curr_field_name = str.substring(idx1, idx2);
        idx1 = str.indexOf(h_file);
        if (idx1 == -1) { // 没有文件名
            return true;
        }
        idx1 += h_file.length();
        idx2 = str.indexOf("\"", idx1);
        this.curr_file_name = str.substring(idx1, idx2);
        return true;
    }

    /**
     * 检查文件类型是否合法 Creation date: (2000-12-22 13:38:49)
     * 
     * @param filename
     *            java.lang.String
     * @exception java.io.IOException
     *                The exception description.
     */
    private boolean checkFileType(String filename) throws java.io.IOException {
        if ((m_allowFileTypeList == null) || (m_allowFileTypeList.size() == 0)) {
            return true;
        }
        String extention = extractFileExtention(filename);
        if (!m_allowFileTypeList.contains(extention)) {
            return false;
        }
        return true;
    }

    /**
     * 从Content-type中截取boundary 创建日期：(2000-11-24 14:49:07)
     * 
     * @return java.lang.String
     * @param contentType
     *            java.lang.String
     */
    private String extractBoundary(String contentType) {
        int idx = contentType.indexOf("boundary=") + "boundary=".length();
        return "--" + contentType.substring(idx);
    }

    /**
     * 从文件名中得到扩展名 Creation date: (2000-12-21 14:32:23)
     * 
     * @return java.lang.String
     * @param src
     *            java.lang.String
     */
    private String extractFileExtention(String filename) {
        int idx = filename.lastIndexOf(".") + 1;
        if (idx == 0) {
            return "";
        }
        return filename.substring(idx);
    }

    /**
     * 生成唯一的文件名 Creation date: (2000-12-22 13:56:04)
     * 
     * @return java.lang.String
     * @param filename
     *            java.lang.String
     */
    private String genFileName(String filename) {
        int _index = filename.lastIndexOf("\\");
        return filename.substring(_index + 1, filename.length());
        /*
         * String extention =
         * m_remainFileType?extractFileExtention(filename):"upload"; Random rand =
         * new Random(); while(true){ int num = Math.abs(rand.nextInt());
         * StringBuffer name_buf = new StringBuffer();
         * name_buf.append(num).append(".").append(extention); File file = new
         * File(m_destinePath,name_buf.toString()); if(!file.exists()){ return
         * name_buf.toString(); } }
         */
    }

    /**
     * 得到所有File域的名字列表 Creation date: (2000-12-22 15:27:49)
     * 
     * @return java.util.Enumeration
     */
    public Enumeration getFileFieldNames() {
        if (filepairs == null) {
            return null;
        }
        return filepairs.keys();
    }

    /**
     * 获得指定域的文件名 Creation date: (2000-12-22 15:24:56)
     * 
     * @return java.lang.String
     * @param field
     *            java.lang.String
     */
    public String getFileName(String field) {
        if ((filepairs == null) || !filepairs.containsKey(field)) {
            return null;
        }
        Vector files = (Vector) filepairs.get(field);
        if ((files == null) || (files.size() == 0)) {
            return null;
        }
        return (String) files.elementAt(0);
    }

    /**
     * 得到域名相同的文件名列表 Creation date: (2000-12-22 15:32:56)
     * 
     * @return java.lang.String[]
     * @param fieldname
     *            java.lang.String
     */
    public String[] getFileNames(String fieldname) {
        if ((filepairs == null) || !filepairs.containsKey(fieldname)) {
            return null;
        }
        Vector files = (Vector) filepairs.get(fieldname);
        if ((files == null) || (files.size() == 0)) {
            return null;
        }
        String[] fileNames = new String[files.size()];
        for (int i = 0; i < fileNames.length; i++) {
            fileNames[i] = (String) files.elementAt(i);
        }
        return fileNames;
    }

    /**
     * 和ServletRequest对象的相应方法相同 Creation date: (2000-12-22 9:23:47)
     * 
     * @return java.lang.String
     * @param name
     *            java.lang.String
     */
    public String getParameter(String name) {
        if ((parampairs == null) || !parampairs.containsKey(name)) {
            return null;
        }
        Vector values = (Vector) parampairs.get(name);
        if ((values == null) || (values.size() == 0)) {
            return null;
        }
        return (String) values.elementAt(0);
    }

    /**
     * 和ServletRequest对象的相应方法相同。 Creation date: (2000-12-22 9:22:27)
     * 
     * @return java.util.Enumeration
     */
    public Enumeration getParameterNames() {
        if (parampairs == null) {
            return null;
        }
        return parampairs.keys();
    }

    /**
     * 和ServletRequest对象的相应方法相同 Creation date: (2000-12-22 9:25:42)
     * 
     * @return java.lang.String[]
     * @param name
     *            java.lang.String
     */
    public String[] getParameterValues(String name) {
        if (parampairs == null) {
            return null;
        }
        Vector values = (Vector) parampairs.get(name);
        if ((values == null) || (values.size() == 0)) {
            return null;
        }
        String[] paraValues = new String[values.size()];
        for (int i = 0; i < paraValues.length; i++) {
            paraValues[i] = (String) values.elementAt(i);
        }
        return paraValues;
    }

    /**
     * 解析ServletRequest对象，保存文件和参数 创建日期：(2000-11-24 14:43:14)
     */
    public int parseAndSave() throws IOException {
        if ((m_allowedTotalSize != 0)
                && (m_request.getContentLength() > m_allowedTotalSize)) {
            System.err.println("Request Object Too Huge To Tolerate!");
            return 1;
        }

        ServletInputStreamProcessor insp = new ServletInputStreamProcessor(
                m_request.getInputStream(), m_request.getContentLength());

        String aLine = null;
        aLine = insp.readLine();

        if (aLine.length() == 0) { // 没有数据，成功！
            return 0;
        }
        while ((aLine != null) && !aLine.startsWith(m_boundary)) {
            aLine = insp.readLine();
        }

        if (aLine == null) {
            System.err.println("Request fomat error!");
            return 2;
        }

        byte[] buf = new byte[10 * 1024];
        while (true) {
            aLine = insp.readLine();

            if ((aLine == null) || (aLine.length() == 0)) {
                break;
            }

            this.curr_field_name = null;
            this.curr_file_name = null;
            if (!checkDisposition(aLine)) {
                System.err.println("Request fomat error!");
                return 2;
            }

            if (curr_file_name == null) { // 不存在filename=...，是个parameter
                aLine = insp.readLine();
                if (aLine.length() != 0) {
                    System.err.println("Request fomat error!");
                    return 2;
                }

                StringBuffer value_buf = new StringBuffer();
                String ss;
                boolean valueGot = false;
                do {
                    ss = insp.readLine();
                    if (ss == null) {
                        System.err.println("Request fomat error!");
                        return 2;
                    }
                    if (!ss.startsWith(m_boundary)) {
                        valueGot = true;
                        value_buf.append(ss).append("\r\n");
                    }
                } while ((ss != null) && !ss.startsWith(m_boundary));

                if (!valueGot) {
                    System.err.println("Request fomat error!");
                    return 2;
                }

                value_buf.setLength(value_buf.length() - 2);
                String value = value_buf.toString();
                if (!parampairs.containsKey(curr_field_name)) {
                    Vector values = new Vector(0, 1);
                    values.add(value);
                    parampairs.put(curr_field_name, values);
                } else {
                    Vector values = (Vector) parampairs.get(curr_field_name);
                    values.add(value);
                }
            } else if (curr_file_name.length() == 0) { // filename="",是个空File域
                aLine = insp.readLine();
                if ((aLine == null)
                        || !aLine.toLowerCase().startsWith("content-type:")) {
                    System.err.println("Request fomat error!");
                    return 2;
                }
                aLine = insp.readLine();
                if ((aLine == null) || (aLine.length() != 0)) {
                    System.err.println("Request fomat error!");
                    return 2;
                }
                aLine = insp.readLine();
                if ((aLine == null) || (aLine.length() != 0)) {
                    System.err.println("Request fomat error!");
                    return 2;
                }
                aLine = insp.readLine();
                if ((aLine == null) || !aLine.startsWith(m_boundary)) {
                    System.err.println("Request fomat error!");
                    return 2;
                }

            } else { // 一个File域，如果文件类型允许，则读取并保存之
                aLine = insp.readLine();
                if ((aLine == null)
                        || !aLine.toLowerCase().startsWith("content-type:")) {
                    System.err.println("Request fomat error!");
                    return 2;
                } else {
                    String strContentType = aLine.substring(14, aLine.length());
                    filecontenttype.put(curr_field_name, strContentType);
                }
                aLine = insp.readLine();
                if ((aLine == null) || (aLine.length() != 0)) {
                    System.err.println("Request fomat error!");
                    return 2;
                }
                if (checkFileType(curr_file_name) == false) {
                    System.err.println("FileType not allowed!");
                    return 3;
                }

                String filename = genFileName(curr_file_name);
                if (!filepairs.containsKey(curr_field_name)) {
                    Vector filenames = new Vector(0, 1);
                    filenames.add(filename);
                    filepairs.put(curr_field_name, filenames);
                } else {
                    Vector filenames = (Vector) filepairs.get(curr_field_name);
                    filenames.add(filename);
                }
                ByteArrayOutputStream bos = null;
                BufferedOutputStream fos = null;
                String ss;
                try {
                    bos = new ByteArrayOutputStream();
                    fos = new BufferedOutputStream(bos);
                    boolean crcn = false;
                    do {
                        int readLen = insp.readLine(buf, 0, buf.length);
                        if (readLen == 0) {
                            System.err.println("Request fomat error!");
                            return 2;
                        }
                        ss = new String(buf, 0, readLen);
                        if (!ss.startsWith(m_boundary)) {
                            if (crcn) {
                                fos.write('\r');
                                fos.write('\n');
                                crcn = false;
                            }
                            if ((readLen >= 2) && (buf[readLen - 2] == '\r')
                                    && (buf[readLen - 1] == '\n')) {
                                crcn = true;
                                fos.write(buf, 0, readLen - 2);
                            } else {
                                fos.write(buf, 0, readLen);
                            }
                        }
                    } while ((ss != null) && !ss.startsWith(m_boundary));
                    fos.flush();
                    fos.close();
                    // add by lxl 2003-1， 如果长度为0就认为上传的文件不存在！
                    byte[] bFile = bos.toByteArray();
                    if (bFile.length != 0) {
                        fileparam.put(curr_field_name, bFile);
                    } else {
                        filepairs.remove(curr_field_name);
                        filecontenttype.remove(curr_field_name);
                    }
                } finally {
                    if (fos != null) {
                        fos.close();
                    }
                    if (bos != null) {
                        bos.close();
                    }
                }
            }
        }
        return 0;
    }

    /**
     * 设置允许的文件类型列表。 格式,用逗号隔开的文件扩展名，如："bmp,gif,jpeg,jpg,psd" 创建日期：(2000-11-24
     * 14:17:11)
     * 
     * @param filetypes
     *            java.lang.String
     */
    public void setAllowFileTypes(String filetypes) {
        if ((filetypes == null) || filetypes.equals("")) {
            return;
        }
        StringTokenizer tokens = new StringTokenizer(filetypes, ",");
        while (tokens.hasMoreElements()) {
            m_allowFileTypeList.addElement(tokens.nextToken());
        }
    }

    private Vector m_allowFileTypeList = new Vector(0, 1);

    private String m_encoding;

    /**
     * MultiPartRequest 构造子注解。
     */
    public MultiPartRequest(ServletContext context, HttpServletRequest request)
            throws ServletException, IOException {
        // this(context,request,destPath,"UTF8");
        this(context, request, "", "GBK");
    }

    /**
     * MultiPartRequest 构造子注解。
     */
    public MultiPartRequest(ServletContext context, HttpServletRequest request,
            String destPath) throws ServletException, IOException {
        // this(context,request,destPath,"UTF8");
        this(context, request, destPath, "GBK");
    }

    /**
     * MultiPartRequest 构造子注解。
     */
    public MultiPartRequest(ServletContext context, HttpServletRequest request,
            String destPath, String encoding) throws ServletException,
            IOException {
        this.m_request = request;
        this.m_encoding = encoding;
        String contentTypeStr = m_request.getContentType();
        if (contentTypeStr.indexOf(",") != -1) {
            contentTypeStr = contentTypeStr.substring(0, contentTypeStr
                    .indexOf(","));
        }
        if ((contentTypeStr == null)
                || !contentTypeStr.startsWith("multipart/form-data")) {
            System.err
                    .println("The Form's encoding is not multipart/form-data!");
            return;
        }
        this.m_boundary = new String(extractBoundary(contentTypeStr));
        // if(!checkDestPath(destPath)) throw new IOException("The Destined Path
        // doesn't exist or is not writable!");
    }

    /**
     * 创建日期：(2000-11-24 14:05:59)
     * 
     * @param context
     *            javax.servlet.ServletContext
     * @param req
     *            javax.servlet.http.HttpServletRequest
     * @param destinPath
     *            java.lang.String
     * @param remainFileType
     *            boolean
     */
    public MultiPartRequest(ServletContext context, HttpServletRequest request,
            String destPath, String encoding, boolean remainFileType)
            throws ServletException, IOException {
        this(context, request, destPath, encoding);
    }

    /**
     * 创建日期：(2000-11-24 14:05:59)
     * 
     * @param context
     *            javax.servlet.ServletContext
     * @param req
     *            javax.servlet.http.HttpServletRequest
     * @param destinPath
     *            java.lang.String
     * @param remainFileType
     *            boolean
     */
    public MultiPartRequest(ServletContext context, HttpServletRequest request,
            String destPath, boolean remainFileType) throws ServletException,
            IOException {
        this(context, request, destPath, "UTF8", remainFileType);
    }

    /**
     * 设置允许的Content-Length的最大值 Creation date: (2000-12-21 11:05:18)
     * 
     * @param totalSize
     *            long
     */
    public void setAllowedTotalSize(int totalSize) {
        m_allowedTotalSize = totalSize;
    }

    public byte[] getFileBinary(String param) {
        return (byte[]) fileparam.get(param);
    }

    public String getFileContentType(String param) {
        return (String) filecontenttype.get(param);
    }
    
}
