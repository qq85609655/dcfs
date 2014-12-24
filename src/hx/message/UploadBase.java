/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
/**
 * @Title: UploadBase.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-2 下午02:35:29
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class UploadBase {
    
    /**
     * 将文件储存到指定位置上
     * 
     * @param request -
     *            HttpServletRequest
     * @param paramName -
     *            上传文件的参数名
     * @param strPath -
     *            指定储存文件的位置，绝对路径，包括文件名（如：D:/images/1.jpg）
     * @return true - 成功 false - 失败
     */
    public static boolean saveFileTo(HttpServletRequest request, String paramName, String strPath) {
        byte[] bFile = getFileBinary(request, paramName);
        if (bFile == null) {
            return false;
        }
        try {
            UtilFile.saveToFile(bFile, strPath);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
    /**
     * 取得文件的数据（二进制）
     */
    public static byte[] getFileBinary(HttpServletRequest request, String paramName) {
        MultiPartRequest parser = (MultiPartRequest) request.getAttribute("MultiPartRequest_Parser");
        return parser.getFileBinary(paramName);
    }

}
