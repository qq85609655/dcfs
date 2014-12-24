/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.word.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import sun.misc.BASE64Encoder;

/**
 * @Title: ImageBase64.java
 * @Description:图片base64 编码
 * @Company: 21softech
 * @Created on 2014-11-5 下午05:32:40
 * @author 鹤云
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ImageBase64 {
    
    public static String GetImageStr(String imgFile)
    {//将图片文件转化为字节数组字符串，并对其进行Base64编码处理
        InputStream in = null;
        byte[] data = null;
        //读取图片字节数组
        try 
        {
            in = new FileInputStream(imgFile);        
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } 
        catch (IOException e) 
        {
            e.printStackTrace();
        }
        //对字节数组Base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);//返回Base64编码过的字节数组字符串
    }
    
    public static void main(String[] args) {
        System.out.println(GetImageStr("C:/Users/鹤云/Desktop/222222.png"));
    }

}
