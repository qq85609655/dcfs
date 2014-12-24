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
 * @Created on 2011-3-2 ����02:35:29
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class UploadBase {
    
    /**
     * ���ļ����浽ָ��λ����
     * 
     * @param request -
     *            HttpServletRequest
     * @param paramName -
     *            �ϴ��ļ��Ĳ�����
     * @param strPath -
     *            ָ�������ļ���λ�ã�����·���������ļ������磺D:/images/1.jpg��
     * @return true - �ɹ� false - ʧ��
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
     * ȡ���ļ������ݣ������ƣ�
     */
    public static byte[] getFileBinary(HttpServletRequest request, String paramName) {
        MultiPartRequest parser = (MultiPartRequest) request.getAttribute("MultiPartRequest_Parser");
        return parser.getFileBinary(paramName);
    }

}
