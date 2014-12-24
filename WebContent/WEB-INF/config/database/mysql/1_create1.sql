CREATE TABLE BZ_CLUSTERNODE 
   (
	NODEID		VARCHAR(64) comment '节点ID', 
	IPADDRESS	VARCHAR(320) comment 'IP地址', 
	PORT		VARCHAR(10) comment '端口号', 
	PROTOCOL	VARCHAR(10)  comment '协议', 
	CONTEXTPATH	VARCHAR(300)  comment '上下文路径', 
	CLUSTERID	INT  comment '集群ID号,只有号码相同的集群才同步缓存', 
	PERSON_ID	VARCHAR(64)  comment '创建者ID',
	ADDTIME		DATETIME  comment '创建时间', 
	MEMO		VARCHAR(4000)  comment '描述'
);
alter table BZ_CLUSTERNODE
  comment '集群表';
create table BZ_CODESORT
(
  CODESORTID   VARCHAR(64) not null   comment '代码集ID（手工输入）',
  CODESORTNAME VARCHAR(64)  comment '代码集名称',
  SORTDESC     VARCHAR(200)  comment '代码集描述'
);
  
create table BZ_CODE
(
  CODEID          VARCHAR(64) not null  comment '代码ID（自动生成）',
  CODESORTID      VARCHAR(64)  comment '代码集ID',
  PNO             INT  comment '排序号',
  CODEVALUE       VARCHAR(100)  comment '代码值',
  CODENAME        VARCHAR(100)  comment '代码名称',
  CODELETTER      VARCHAR(50)  comment '字母码',
  CODEDESC        VARCHAR(2000)  comment '代码描述',
  PINYIN        VARCHAR(1000)  comment '拼音码',
  PYHEAD        VARCHAR(500)  comment '拼音声母码',
  PARENTCODEVALUE VARCHAR(100)  comment '上级代码值'
);
alter table BZ_CODE
  comment '代码';

  
create table BZ_SYS_RSTYPE
(
  RESOURCETYPE VARCHAR(2) not null   comment '资源的类型',
  RESOURCEPATH VARCHAR(100) not null   comment '资源的路径'
);
  

--用户个性化设置
create table BZ_SYS_DEFINED
(
  LOGINID      VARCHAR(100) not null   comment '用户的登录ID',
  RESOURCETYPE VARCHAR(2) not null  comment '用户的资源类型',
  APPID        VARCHAR(100)  comment '应用的ID，不填写即为所有的应用',
  ID           VARCHAR(64) not null  comment '主键'
);
alter table BZ_SYS_DEFINED
  comment '用户自定义配置信息（用户自定义皮肤用）';

--附件类型表
CREATE TABLE ATT_TYPE
   (
	ID				VARCHAR(64)  comment '主键', 
	ATT_TYPE_NAME	VARCHAR(2000)  comment '附件类型名称', 
	CODE			VARCHAR(2000)  comment '附件类型的代码，程序中调用', 
	STORE_TYPE		INT  comment '存储类型，2数据库；1磁盘', 
	ATT_SIZE		INT  comment '附件大小限制', 
	ATT_MORE		INT  comment '附件数量，1单附件；2多附件', 
	ATT_FORMAT		VARCHAR(2000)  comment '附件类型', 
	APP_NAME		VARCHAR(2000)  comment '应用名称', 
	MOD_NAME		VARCHAR(2000)  comment '模块名称', 
	FILE_SORT_WEEK	INT  comment '磁盘保存周期，1日；2月；3年', 
	ENTITY_NAME		VARCHAR(2000)  comment '数据表名称'
   );
alter table ATT_TYPE
  comment '附件类型表';
  
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
