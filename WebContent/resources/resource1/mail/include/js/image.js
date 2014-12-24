function _formatImg(mypic,maxWidth,maxHeight){ 
    var xw=maxHeight; 
    var xl=maxWidth; 
         
    var width = mypic.width; 
    var height = mypic.height; 
    var bili = width/height;         
         
    var A=xw/width; 
    var B=xl/height; 
         
    if(!(A>1&&B>1)) 
    { 
        if(A<B) 
        { 
            mypic.width=xw; 
            mypic.height=xw/bili; 
        } 
        if(A>B) 
        { 
            mypic.width=xl*bili; 
            mypic.height=xl; 
        } 
    } 
}
function checkImg(that,divid,imgid){   
        var obj = document.getElementById(divid);
        var img = document.getElementById(imgid); 
       if(!obj || ! img || that.value=="") 
       {
        return;
       }
       var patn = /\.jpg$|\.jpeg$|\.png$|\.bmp$|\.dib$|\.jpe$|\.jfif$|\.tif$|\.tiff$|\.gif$/i;
       if(patn.test(that.value))
       {  
      try{
        obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";  
        obj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src  =  that.value;
        obj.style.width = " 150px ";
	    obj.style.height = " 100px ";
        img.style.display="none";
       }
       catch(e)
       {
         Ext.Msg.alert("提示","您选择文件可能已经被破坏，无法预览！");
         obj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src  ="<%=path%>/include/images/none.gif"; 
       } 
      }
     else
        { 
        Ext.Msg.alert("提示","您选择的不是图像文件。");
        obj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src  ="<%=path%>/include/images/none.gif";
        } 
      } 