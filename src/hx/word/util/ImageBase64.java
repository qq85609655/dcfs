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
 * @Description:ͼƬbase64 ����
 * @Company: 21softech
 * @Created on 2014-11-5 ����05:32:40
 * @author ����
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ImageBase64 {
    
    public static String GetImageStr(String imgFile)
    {//��ͼƬ�ļ�ת��Ϊ�ֽ������ַ��������������Base64���봦��
        InputStream in = null;
        byte[] data = null;
        //��ȡͼƬ�ֽ�����
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
        //���ֽ�����Base64����
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);//����Base64��������ֽ������ַ���
    }
    
    public static void main(String[] args) {
        System.out.println(GetImageStr("C:/Users/����/Desktop/222222.png"));
    }

}
