/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.word.vo;

/**
 * @Title: Image.java
 * @Description:
 * @Company: 21softech
 * @Created on 2014-11-5 05:43:28
 * @author °Øº×ÔÆ
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class Image {
    
    private String imagedata;
    
    private String imagename;
    
    private String imagesort;
    
    private String imageformat;

    /**
     * @return Returns the imageformat.
     */
    public String getImageformat() {
        return imageformat;
    }

    /**
     * @param imageformat The imageformat to set.
     */
    public void setImageformat(String imageformat) {
        this.imageformat = imageformat;
    }

    /**
     * @return Returns the imagesort.
     */
    public String getImagesort() {
        return imagesort;
    }

    /**
     * @param imagesort The imagesort to set.
     */
    public void setImagesort(String imagesort) {
        this.imagesort = imagesort;
    }

    /**
     * @return Returns the imagedata.
     */
    public String getImagedata() {
        return imagedata;
    }

    /**
     * @return Returns the imagename.
     */
    public String getImagename() {
        return imagename;
    }

    /**
     * @param imagedata The imagedata to set.
     */
    public void setImagedata(String imagedata) {
        this.imagedata = imagedata;
    }

    /**
     * @param imagename The imagename to set.
     */
    public void setImagename(String imagename) {
        this.imagename = imagename;
    }

}
