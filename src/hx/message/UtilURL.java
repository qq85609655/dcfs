/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
/**
 * @Title: UtilURL.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-2 ÏÂÎç02:38:02
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class UtilURL {
    public static final String module = UtilURL.class.getName();


    public static URL fromFilename(String filename) {
        if (filename == null) return null;
        File file = new File(filename);
        URL url = null;

        try {
            if (file.exists()) url = file.toURL();
        } catch (java.net.MalformedURLException e) {
            e.printStackTrace();
            url = null;
        }
        return url;
    }
    
    public static URL fromUrlString(String urlString) {
        URL url = null;       
        try {
            url = new URL(urlString);
        } catch (MalformedURLException e) {                        
        }
        
        return url;
    }
}
