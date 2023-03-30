/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT 
(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PARTY_TYPE'
	AND LOOKUP_CODE = HzPartiesE0.PARTY_TYPE
	) RES_CUSTOMER_TYPE
,HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzCustAccountsE0.ACCOUNT_NUMBER RES_ACCOUNT_NUMBER
,HzPartySiteE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,(SELECT SET_NAME
	FROM FND_SETID_SETS
	WHERE LANGUAGE = USERENV('LANG')
	AND SET_ID = HzCustAcctSitesAllE0.SET_ID
	) RES_ACCOUNT_ADDRESS_SET
--,HZ_FORMAT_PUB.FORMAT_ADDRESS(P_LOCATION_ID => HzPartySiteE0.LOCATION_ID, P_LINE_BREAK => ',')  RES_ACCOUNT_ADDRESS_SET
,HzCustAccountsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,HzCustAccountsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,HzCustAccountsE0.CREATED_BY  RSC_CREATED_BY
,HzCustAccountsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,buE0.BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM HZ_PARTIES HzPartiesE0
,(SELECT PARTY_ID 
	FROM HZ_PARTY_USG_ASSIGNMENTS
	WHERE PARTY_USAGE_CODE = 'CUSTOMER'
	) HzPartyUsgAssignmentsE0
,HZ_CUST_ACCOUNTS HzCustAccountsE0
,HZ_CUST_ACCT_SITES_ALL HzCustAcctSitesAllE0
,HZ_PARTY_SITES HzPartySiteE0
,FUN_ALL_BUSINESS_UNITS_V buE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzCustAccountsE0.PARTY_ID
AND HzCustAccountsE0.CUST_ACCOUNT_ID = HzCustAcctSitesAllE0.CUST_ACCOUNT_ID
AND HzCustAcctSitesAllE0.PARTY_SITE_ID = HzPartySiteE0.PARTY_SITE_ID
AND HzCustAcctSitesAllE0.SET_ID = buE0.DEFAULT_SET_ID(+)
ORDER BY HzPartiesE0.PARTY_NUMBER
,HzCustAccountsE0.ACCOUNT_NUMBER
,HzPartySiteE0.PARTY_SITE_NUMBER