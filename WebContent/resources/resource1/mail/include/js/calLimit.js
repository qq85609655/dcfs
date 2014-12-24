function calLimit(startDate,startTime,endDate,endTime)
 {
	this.startDate = document.getElementById(startDate);
	this.startTime = document.getElementById(startTime);
    this.endDate = document.getElementById(endDate);
    this.endTime = document.getElementById(endTime);
	this.getStartTimeLimit=function()
	{
		
		if(this.startDate.value == this.endDate.value&&this.startDate.value!=null&&this.startDate.value!="")
		{
				if(this.endTime.value!=null&&this.endTime.value!="")
				{
					return this.endTime.value;
				}
				else
				{
					return "23:59:59";
				}
		}
		else
		{
			return "23:59:59";
		}
	}
	this.getEndTimeLimit=function()
	{
		
		if(this.startDate.value == this.endDate.value&&this.startDate.value!=null&&this.startDate.value!="")
		{
				if(this.startTime.value!=null&&this.startTime.value!="")
				{
					return this.startTime.value;
				}
				else
				{
					return "00:00:00";
				}
		}
		else
		{
			return "00:00:00";
		}
	}
 }
 
 
 
 