/*******************************************************************************
		DC¶ÔÏóÉùÃ÷
*********************************************************************************/
function BaseObject () {
  this.objName
  this.objType
  this.ID
  this.CODE
  this.TITLE
  this.DESC
}

function ExSubject () {
  this.objName
  this.objType
  this.SUB_ID
  this.SUB_CODE
  this.SUB_TITLE
  this.SUB_TYPE
  this.SUB_TIER
  this.SUB_ORDER
  this.SUB_DESC
  this.SUB_PARENT
  this.SUB_BUILD_MAN
  this.SUB_BUILD_TIME
  this.SUB_MODIFY_MAN
  this.SUB_MODIFY_TIME
}

function ExDataModel () {
  this.objName
  this.objType
  this.DM_ID
  this.DM_CODE
  this.DM_TITLE
  this.DM_SUB_ID
  this.DM_DESC
  this.DM_ORDER
  this.DM_STATUS
  this.DM_BUILD_MAN
  this.DM_BUILD_TIME
  this.DM_MODIFY_MAN
  this.DM_MODIFY_TIME
  this.DC_DMDL_ID
  this.DM_IFQUERY
  this.DM_IFAREA
}

function ExDimension () {
  this.objName
  this.objType
  this.DIM_ID
  this.DIM_DM_ID
  this.DIM_CODE
  this.DIM_TITLE
  this.DIM_TYPE
  this.DIM_SUBTYPE
  this.DIM_DESC
  this.DIM_ORDER
}

function ExGranularity () {
  this.objName
  this.objType
  this.GRAN_ID
  this.GRAN_DM_ID
  this.GRAN_DIM_ID
  this.GRAN_DIM_CODE
  this.GRAN_CODE
  this.GRAN_TITLE
  this.GRAN_FIELD
  this.GRAN_FIELD_TYPE
  this.GRAN_DESC
  this.GRAN_VALUES
  this.GRAN_TIER
  this.GRAN_LEVEL
  this.GRAN_PARENT
  this.GRAN_UNIT
}

function ExAccount () {
  this.objName
  this.objType
  this.ACCT_DM_ID
  this.ACCT_DIM_ID
  this.ACCT_GRAN_ID
  this.ACCT_FIELD
  this.ACCT_FIELD_TYPE
  this.ACCT_VALUES
  this.ACCT_UNIT
  this.ACCT_ID
  this.ACCT_CODE
  this.ACCT_TITLE
  this.ACCT_DESC
  this.ACCT_ORDER
  this.ACCT_LEVEL
}











