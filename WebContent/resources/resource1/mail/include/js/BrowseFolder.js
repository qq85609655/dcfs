function BrowseFolder(){
	try{
	  var Message = "��ѡ���ļ���";  //ѡ�����ʾ��Ϣ
	  var Shell = new ActiveXObject( "Shell.Application" );
	  var Folder = Shell.BrowseForFolder(0,Message,0x0040,0x11);//��ʼĿ¼Ϊ���ҵĵ���
	  //var Folder = Shell.BrowseForFolder(0,Message,0); //��ʼĿ¼Ϊ������
	  if(Folder != null){
	    Folder = Folder.items();  // ���� FolderItems ����
	    Folder = Folder.item();  // ���� Folderitem ����
	    Folder = Folder.Path;   // ����·��
	    if(Folder.charAt(Folder.length-1) != "\\"){
	      Folder = Folder + "\\";
	    }
	    //document.all.savePath.value=Folder;
	    
	    return Folder;
	  }
	 }catch(e){ 
	  	alert(e.message);
	 }
}