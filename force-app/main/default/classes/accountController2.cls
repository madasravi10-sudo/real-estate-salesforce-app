/**
* @File Name : accountController2.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : December 22, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 22, 2025 |   | Initial Version
**/

public class accountController2 {
	@AuraEnabled(cacheable=true)
	public static list<account> GetAccounts(){
		return [SELECT ID,name,phone,industry from account LIMIT 10];

	
	}
}