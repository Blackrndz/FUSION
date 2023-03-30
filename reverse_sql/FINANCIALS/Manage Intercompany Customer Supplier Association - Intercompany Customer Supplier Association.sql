/* ****************************************************************************
 * $Revision: 62668 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-06-19 18:28:29 +0700 (Mon, 19 Jun 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 62668 2017-06-19 11:28:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FUN_IC_CUST_SUPP_MAP

SELECT XleEntityProfilesE0.NAME RES_LEGAL_ENTITY_NAME
,XleEntityProfilesE0.LEGAL_ENTITY_IDENTIFIER RES_LEGAL_ENTITY_IDENTIFIER
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = CustomerAccE0.PARTY_ID
	) RES_CUSTOMER_NAME
,CustomerAccE0.ACCOUNT_NUMBER RES_CUSTOMER_ACCOUNT_NUMBER
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = SupplierE0.PARTY_ID
	) RES_SUPPLIER_NAME
,SupplierE0.SEGMENT1 RES_SUPPLIER_NUMBER
,FunIcCustSuppMapE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,FunIcCustSuppMapE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FunIcCustSuppMapE0.CREATED_BY  RSC_CREATED_BY
,FunIcCustSuppMapE0.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,FunIcCustSuppMapE0.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_IC_CUST_SUPP_MAP FunIcCustSuppMapE0
,XLE_ENTITY_PROFILES XleEntityProfilesE0
,HZ_CUST_ACCOUNTS CustomerAccE0
,POZ_SUPPLIERS SupplierE0
WHERE FunIcCustSuppMapE0.LEGAL_ENTITY_ID = XleEntityProfilesE0.LEGAL_ENTITY_ID
AND FunIcCustSuppMapE0.CUST_ACCOUNT_ID = CustomerAccE0.CUST_ACCOUNT_ID(+)
AND FunIcCustSuppMapE0.VENDOR_ID = SupplierE0.VENDOR_ID(+)
ORDER BY XleEntityProfilesE0.NAME