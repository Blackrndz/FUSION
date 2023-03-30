/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT lookupsE0.MEANING RES_PARTY_ROLE
,lookupsE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(lookupsE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(lookupsE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'OKC_PARTY_SOURCE'
	AND LOOKUP_CODE = sourceRolesE0.BUY_SOURCE_CODE
	) RES_BUY_INTENT_SOURCE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'OKC_PARTY_SOURCE'
	AND LOOKUP_CODE = sourceRolesE0.SELL_SOURCE_CODE
	) RES_SELL_INTENT_SOURCE
,sourceRolesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,sourceRolesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,sourceRolesE0.CREATED_BY  RSC_CREATED_BY
,sourceRolesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_PARTY_ROLE_SOURCES sourceRolesE0
,FND_LOOKUPS lookupsE0
WHERE lookupsE0.LOOKUP_TYPE = 'OKC_PARTY_ROLE'
AND lookupsE0.LOOKUP_CODE = sourceRolesE0.PARTY_ROLE_CODE
ORDER BY lookupsE0.MEANING