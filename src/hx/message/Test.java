/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import hx.database.databean.DataList;

/**
 * @Title: Test.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-3 ÉÏÎç10:27:52
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class Test {

    /**
     * @param args
     * @throws UnsupportedEncodingException 
     */
    public static void main(String[] args) throws UnsupportedEncodingException {
        String ss=URLDecoder.decode("%25E6%2588%2591%25E7%259A%2584", "UTF-8");
        String bb=URLDecoder.decode(URLDecoder.decode("%25E6%2588%2591%25E7%259A%2584","UTF-8"),"UTF-8");
    }

}
