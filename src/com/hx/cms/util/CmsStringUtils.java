package com.hx.cms.util;

import java.io.UnsupportedEncodingException;

public class CmsStringUtils {

    /**
     * 截断字符串
     * @param text
     * @param length
     * @param endWith
     * @return
     */
    public static String subString(String text, int length, String endWith) {
        int textLength = text.length();
        int byteLength = 0;
        StringBuffer returnStr = new StringBuffer();
        for (int i = 0; i < textLength && byteLength < length * 2; i++) {
            String str_i = text.substring(i, i + 1);
            if (str_i.getBytes().length == 1) {
                //英文   
                byteLength++;
            } else {
                //中文   
                byteLength += 2;
            }
            returnStr.append(str_i);
        }
        try {
            //getBytes("GBK")每个汉字长2，getBytes("UTF-8")每个汉字长度为3
            if (byteLength < text.getBytes("GBK").length) {   
                returnStr.append(endWith);
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return returnStr.toString();
    }
}
