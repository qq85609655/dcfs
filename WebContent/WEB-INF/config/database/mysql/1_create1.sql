CREATE TABLE BZ_CLUSTERNODE 
   (
	NODEID		VARCHAR(64) comment '�ڵ�ID', 
	IPADDRESS	VARCHAR(320) comment 'IP��ַ', 
	PORT		VARCHAR(10) comment '�˿ں�', 
	PROTOCOL	VARCHAR(10)  comment 'Э��', 
	CONTEXTPATH	VARCHAR(300)  comment '������·��', 
	CLUSTERID	INT  comment '��ȺID��,ֻ�к�����ͬ�ļ�Ⱥ��ͬ������', 
	PERSON_ID	VARCHAR(64)  comment '������ID',
	ADDTIME		DATETIME  comment '����ʱ��', 
	MEMO		VARCHAR(4000)  comment '����'
);
alter table BZ_CLUSTERNODE
  comment '��Ⱥ��';
create table BZ_CODESORT
(
  CODESORTID   VARCHAR(64) not null   comment '���뼯ID���ֹ����룩',
  CODESORTNAME VARCHAR(64)  comment '���뼯����',
  SORTDESC     VARCHAR(200)  comment '���뼯����'
);
  
create table BZ_CODE
(
  CODEID          VARCHAR(64) not null  comment '����ID���Զ����ɣ�',
  CODESORTID      VARCHAR(64)  comment '���뼯ID',
  PNO             INT  comment '�����',
  CODEVALUE       VARCHAR(100)  comment '����ֵ',
  CODENAME        VARCHAR(100)  comment '��������',
  CODELETTER      VARCHAR(50)  comment '��ĸ��',
  CODEDESC        VARCHAR(2000)  comment '��������',
  PINYIN        VARCHAR(1000)  comment 'ƴ����',
  PYHEAD        VARCHAR(500)  comment 'ƴ����ĸ��',
  PARENTCODEVALUE VARCHAR(100)  comment '�ϼ�����ֵ'
);
alter table BZ_CODE
  comment '����';

  
create table BZ_SYS_RSTYPE
(
  RESOURCETYPE VARCHAR(2) not null   comment '��Դ������',
  RESOURCEPATH VARCHAR(100) not null   comment '��Դ��·��'
);
  

--�û����Ի�����
create table BZ_SYS_DEFINED
(
  LOGINID      VARCHAR(100) not null   comment '�û��ĵ�¼ID',
  RESOURCETYPE VARCHAR(2) not null  comment '�û�����Դ����',
  APPID        VARCHAR(100)  comment 'Ӧ�õ�ID������д��Ϊ���е�Ӧ��',
  ID           VARCHAR(64) not null  comment '����'
);
alter table BZ_SYS_DEFINED
  comment '�û��Զ���������Ϣ���û��Զ���Ƥ���ã�';

--�������ͱ�
CREATE TABLE ATT_TYPE
   (
	ID				VARCHAR(64)  comment '����', 
	ATT_TYPE_NAME	VARCHAR(2000)  comment '������������', 
	CODE			VARCHAR(2000)  comment '�������͵Ĵ��룬�����е���', 
	STORE_TYPE		INT  comment '�洢���ͣ�2���ݿ⣻1����', 
	ATT_SIZE		INT  comment '������С����', 
	ATT_MORE		INT  comment '����������1��������2�฽��', 
	ATT_FORMAT		VARCHAR(2000)  comment '��������', 
	APP_NAME		VARCHAR(2000)  comment 'Ӧ������', 
	MOD_NAME		VARCHAR(2000)  comment 'ģ������', 
	FILE_SORT_WEEK	INT  comment '���̱������ڣ�1�գ�2�£�3��', 
	ENTITY_NAME		VARCHAR(2000)  comment '���ݱ�����'
   );
alter table ATT_TYPE
  comment '�������ͱ�';
  
  alter table BZ_CLUSTERNODE
  add constraint BZ_CLUSTERNODE_PK primary key (NODEID);
alter table BZ_CODESORT
  add constraint BZ_CODESORT_PK primary key (CODESORTID);
  
alter table BZ_CODE
  add constraint BZ_CODE_PK primary key (CODEID);

alter table BZ_SYS_RSTYPE
  add constraint BZSYSRSTYPE primary key (RESOURCETYPE);
  
alter table BZ_SYS_DEFINED
  add constraint BZSYSDEFINEDPK primary key (ID);
alter table ATT_TYPE
  add constraint ATT_TYPE_PK primary key (ID);
