/**
* @File Name : PostalApi.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : January 28, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | January 28, 2025 |   | Initial Version
**/

public class PostalApi {
	@AuraEnabled(cacheable=false)
	public static List<Map<String,Object>> IndiaPostall(String pincode){
		String url='https://api.postalpincode.in/pincode/'+pincode;
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		req.setEndpoint(url);
		req.setMethod('GET');
		HttpResponse res= http.send(req);

		if (res.getStatuscode()==200)
		{
			List<Object>result = (List<Object>) JSON.deserializeUntyped(res.getBody());
			List<Map<String,Object>> postOfficeList = new List<Map<String,Object>>();

			for (Object obj: result)
			{
				Map<String,Object> deserializeObj = (Map<String,Object>)obj;
				List<Object> postOffices = (List<Object>)deserializeObj.get('PostOffice');

			for(Object postOfficeObj :postOffices)
			{
				Map<String,Object>postofficeMap = (Map<String,Object>)postOfficeObj;
				postOfficeList.add(postOfficeMap);
			}
		}
		return postOfficeList;
		}
		
		else
		{
			throw new AuraHandledException('Failed to fetch postal data. Status code: '+res.getStatusCode());

		}
		
	}
}