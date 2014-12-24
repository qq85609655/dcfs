package com.dcfs.common;

/**
 * 收养组织以及收养组织所在国家基本信息VO
 * @description 
 * @author MaYun
 * @date Oct 16, 2014
 * @return
 */
public class SyzzDept {
	
	private String syzzId;//收养组织ID
	private String syzzCode;//收养组织Code
    private String syzzCnName;//收养组织中文名称
    private String syzzEnName;//收养组织英文名称
    private String countryCode;//所属国家Code
    private String countryCnName;//所属国家中文名称
    private String countryEnName;//所属国家英文名称
    private String convention;//所属国家是否公约国
    private String solicitSubmissions;//所属国家在华居住是否公约收养
    private String currency;//所属国家币种
    private String licenseStartvalId;//生效日期
    private String licenseValId;//失效日期
    private String foundedDate;//组织成立日期
    private String cnstartDate;//在中国开展项目日期
    private String headquarterAddress;//总部地址
    private String mailingAddress;//邮寄地址
    private String tel;//电话
    private String fax;//传真
    private String webSite;//网址
    private String email;//电子邮件
    private String authorDepartment;//委托或认证部门
    private String adviceGetmethod;//征求意见领取方式
    private String transFlag;//预批是否翻译
    private String service;//服务项目
    private String otherCountry;//其他合作国家
    private String state;//组织合作状态
    private String introduction;//机构介绍
    private String remark;//机构介绍
    private String recordState;//组织备案状态
    private float accountLmt;//余额账户_限额
    private float accountCurr;//余额账户_当前额度
    
	public String getSyzzCode() {
		return syzzCode;
	}
	public void setSyzzCode(String syzzCode) {
		this.syzzCode = syzzCode;
	}
	public String getSyzzCnName() {
		return syzzCnName;
	}
	public void setSyzzCnName(String syzzCnName) {
		this.syzzCnName = syzzCnName;
	}
	public String getSyzzEnName() {
		return syzzEnName;
	}
	public void setSyzzEnName(String syzzEnName) {
		this.syzzEnName = syzzEnName;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getCountryCnName() {
		return countryCnName;
	}
	public void setCountryCnName(String countryCnName) {
		this.countryCnName = countryCnName;
	}
	public String getCountryEnName() {
		return countryEnName;
	}
	public void setCountryEnName(String countryEnName) {
		this.countryEnName = countryEnName;
	}
	public String getConvention() {
		return convention;
	}
	public void setConvention(String convention) {
		this.convention = convention;
	}
	public String getSolicitSubmissions() {
		return solicitSubmissions;
	}
	public void setSolicitSubmissions(String solicitSubmissions) {
		this.solicitSubmissions = solicitSubmissions;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getLicenseStartvalId() {
		return licenseStartvalId;
	}
	public void setLicenseStartvalId(String licenseStartvalId) {
		this.licenseStartvalId = licenseStartvalId;
	}
	public String getLicenseValId() {
		return licenseValId;
	}
	public void setLicenseValId(String licenseValId) {
		this.licenseValId = licenseValId;
	}
	public String getFoundedDate() {
		return foundedDate;
	}
	public void setFoundedDate(String foundedDate) {
		this.foundedDate = foundedDate;
	}
	public String getCnstartDate() {
		return cnstartDate;
	}
	public void setCnstartDate(String cnstartDate) {
		this.cnstartDate = cnstartDate;
	}
	public String getHeadquarterAddress() {
		return headquarterAddress;
	}
	public void setHeadquarterAddress(String headquarterAddress) {
		this.headquarterAddress = headquarterAddress;
	}
	public String getMailingAddress() {
		return mailingAddress;
	}
	public void setMailingAddress(String mailingAddress) {
		this.mailingAddress = mailingAddress;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getWebSite() {
		return webSite;
	}
	public void setWebSite(String webSite) {
		this.webSite = webSite;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthorDepartment() {
		return authorDepartment;
	}
	public void setAuthorDepartment(String authorDepartment) {
		this.authorDepartment = authorDepartment;
	}
	public String getAdviceGetmethod() {
		return adviceGetmethod;
	}
	public void setAdviceGetmethod(String adviceGetmethod) {
		this.adviceGetmethod = adviceGetmethod;
	}
	public String getTransFlag() {
		return transFlag;
	}
	public void setTransFlag(String transFlag) {
		this.transFlag = transFlag;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getOtherCountry() {
		return otherCountry;
	}
	public void setOtherCountry(String otherCountry) {
		this.otherCountry = otherCountry;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getRecordState() {
		return recordState;
	}
	public void setRecordState(String recordState) {
		this.recordState = recordState;
	}
	public float getAccountLmt() {
		return accountLmt;
	}
	public void setAccountLmt(float accountLmt) {
		this.accountLmt = accountLmt;
	}
	public float getAccountCurr() {
		return accountCurr;
	}
	public void setAccountCurr(float accountCurr) {
		this.accountCurr = accountCurr;
	}
	public String getSyzzId() {
		return syzzId;
	}
	public void setSyzzId(String syzzId) {
		this.syzzId = syzzId;
	}
    
    
    
}
