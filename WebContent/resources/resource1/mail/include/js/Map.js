/* $Id: Map.js,v 1.1 2009/04/14 03:23:24 zhanghj Exp $ */
/*
Title: gp.common.Map
Description:
Map �࣬�洢ʱ���ؼ��ִ洢,��ȡʱ���ؼ�����ȡ,�ṩ��Ч�ķ�����
Company: ��������
Author:leidh
*/

//----------------------------------------------------------------------
//���������Ҳ����Ĺ��캯����
function Map(){
  //1.���� =function();

  //2.���������� =function();
  this.CLASSNAME= "gp.common.Map";

  //3.���������� =function();
  this.asKey= new Array();   //private; ����Ŵ洢�Ĺؼ���;
  this.aiIndex= new Array(); //private; ���ؼ��ִ洢�����;
  this.avItem= new Array();  //private;
  this.avItemByIndex= new Array(); //private;

  //5.���������� =function();
  //public;
  this.clear= Map_clear;
  this.get= Map_get;
  this.getAllItem= Map_getAllItem;
  this.getAllKey= Map_getAllKey;
  this.isContain= Map_isContain;
  this.put= Map_put;
  this.remove= Map_remove;
  this.size= Map_size;
  //����������ĵ�

  //private;
  this.getKeyIndex= Map_getKeyIndex;
}
//----------------------------------------------------------------------
//6.������ =function();
//----------------------------------------------------------------------
//public; �����µ�Ԫ��;
//����ֵ:�ɹ�: true, ʧ��: false;
function Map_put(sKey, vItem){
  if (sKey== null || sKey.length== 0) return false;

  var viIndex= this.aiIndex[sKey];
  if (viIndex== null) viIndex= this.asKey.length;
  this.asKey[viIndex]= sKey;
  this.aiIndex[sKey]= viIndex;
  this.avItem[sKey]= vItem;
  this.avItemByIndex[viIndex]= vItem;
  return true;
}
//----------------------------------------------------------------------
//*
//public; ��ȡָ�� Key ֵ�����;
//����ֵ: �ɹ�: ���, ʧ��: -1;
function Map_getKeyIndex(sKey){
  var viIndex= this.aiIndex[sKey];
  if (viIndex== null) viIndex= -1;
  return viIndex
}
//*/
//----------------------------------------------------------------------
/*
//private; ��ȡָ���ؼ��ֵ����;
//����ֵ:�ɹ�: ���, ʧ��: -1;
function Map_getKeyIndex(sKey){
  if (sKey== null || sKey.length== 0) return false;
  var viIndex= -1;
  for (var i= 0; i< this.asKey.length; i++){
    if (this.asKey[i]== sKey){
      viIndex= i;
      break;
    }
  }
  return viIndex;
}
//*/
//----------------------------------------------------------------------
//public; ɾ��ָ����Ԫ��;
//����ֵ:�ɹ�: true, ʧ��: false;
function Map_remove(sKey){
  if (sKey== null || sKey.length== 0) return false;
  var viIndex= this.getKeyIndex(sKey);//this.aiIndex[sKey];
  if (typeof (viIndex)== "undefined" || viIndex== null) return false;

  //this.avItemKey[this.avItem[sKey]]= null;
  this.avItem[sKey]= null;
  this.aiIndex[sKey]= null;
  this.asKey[viIndex]= null;
  this.avItemByIndex[viIndex]= null;
  if (viIndex== 0){
    this.asKey= this.asKey.slice(viIndex+ 1);
    this.avItemByIndex= this.avItemByIndex.slice(viIndex+ 1);
  }else if (viIndex> 0){
    var vasKey= new Array();
    vasKey= this.asKey.slice(0, viIndex);
    this.asKey= vasKey.concat(this.asKey.slice(viIndex+ 1));
    var vaoItem= new Array();
    vaoItem= this.avItemByIndex.slice(0, viIndex);
    this.avItemByIndex= vaoItem.concat(this.avItemByIndex.slice(viIndex+ 1));
  }

  this.aiIndex= new Array();
  for (var i= 0, len= this.asKey.length; i< len; i++){
    this.aiIndex[this.asKey[i]]= i;
  }
  return true;
}
//----------------------------------------------------------------------
//public; ��ȡָ��λ�õ�Ԫ��;
//����ֵ:�ɹ�: ָ��Ԫ�ص�ֵ, ʧ��: null;
function Map_get(sKey){
  return this.avItem[sKey];
}
//----------------------------------------------------------------------
//public; ��ȡ���йؼ���Ԫ�ص�����;
//����ֵ:�ɹ�: �����йؼ���Ԫ�ص�����, ʧ��: null;
function Map_getAllKey(){
  return this.asKey;
}
//----------------------------------------------------------------------
//public; ��ȡ���ж����������;
//����ֵ:�ɹ�: ���ж����������, ʧ��: null;
function Map_getAllItem(){
  return this.avItemByIndex;
}
//----------------------------------------------------------------------
//public; ��ȡ���е�Ԫ�صĸ���;
//����ֵ:�ɹ�: ���е�Ԫ�صĸ���, ʧ��: -1;
function Map_size(){
  return this.asKey.length;
}
//----------------------------------------------------------------------
//public; �ж��Ƿ����ָ���ؼ��ֵ�Ԫ��;
//����ֵ: �������ָ���ؼ��ֵ�Ԫ�أ�true, ����: false;
function Map_isContain(sKey){
  if (this.avItem[sKey]== null) return false;
  return true;
}
//----------------------------------------------------------------------
//public; ������е����е�Ԫ��;
//����ֵ: void;
function Map_clear(){
  if (this.avItem== null) this.avItem= new Array();
  this.avItem.length= 0;
  this.avItem= null;
  this.avItem= new Array();

  //this.asItemKey.length= 0;
  //this.asItemKey= nll;
  //this.asItemKey= new Array();

  if (this.asKey== null) this.asKey= new Array();
  this.asKey.length= 0;
  this.asKey= null;
  this.asKey= new Array();

  //*
  if (this.aiIndex== null) this.aiIndex= new Array();
  this.aiIndex.length= 0;
  this.aiIndex= null;
  this.aiIndex= new Array();
  //*/

  if (this.avItemByIndex== null) this.avItemByIndex= new Array();
  this.avItemByIndex.length= 0;
  this.avItemByIndex= null;
  this.avItemByIndex= new Array();
  return;
}
//----------------------------------------------------------------------

