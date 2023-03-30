/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT PartyPEO.PARTY_NAME RES_RESOURCE_NAME
,PartyPEO.PARTY_NUMBER RES_REGISTRY_ID
,SetE0.SET_CODE RES_SET
,SetE0.SALESREP_NUMBER RES_SALESPERSON_NUMBER
,SetE0.SALES_CREDIT_TYPE_ID RES_SALES_CREDIT_TYPE
,SetE0.SALES_TAX_GEOCODE RES_SALES_TAX_GEOGRAPHY
,DECODE(SetE0.SALES_TAX_INSIDE_CITY_LIMITS,'1','Yes','No') RES_INSIDE_CITY_LIMITS
,TO_CHAR(SetE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(SetE0.END_DATE_ACTIVE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(SetE0.END_DATE_ACTIVE,'DD-Mon-YYYY'))
	RES_TO_DATE
,SetE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SetE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SetE0.CREATED_BY RSC_CREATED_BY
,SetE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_RESOURCE_PROFILES ResourceEO
,HZ_PARTIES PartyPEO
,(SELECT PERSON_ID
	FROM PER_ALL_PEOPLE_F 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) PersonDPEONQ1
,HZ_ORIG_SYS_REFERENCES OrigSysRefPEONQ1
,(SELECT ResourceSalesrep.RESOURCE_ID
	,SetIdSetPEO.SET_CODE
	,ResourceSalesrep.SALES_CREDIT_TYPE_ID
	,ResourceSalesrep.SALES_TAX_GEOCODE
	,ResourceSalesrep.SALES_TAX_INSIDE_CITY_LIMITS
	,ResourceSalesrep.SALESREP_NUMBER
	,ResourceSalesrep.START_DATE_ACTIVE
	,ResourceSalesrep.END_DATE_ACTIVE
	,ResourceSalesrep.LAST_UPDATED_BY
	,ResourceSalesrep.LAST_UPDATE_DATE
	,ResourceSalesrep.CREATED_BY
	,ResourceSalesrep.CREATION_DATE
	FROM JTF_RS_SALESREPS ResourceSalesrep
	,FND_SETID_SETS_VL SetIdSetPEO
	WHERE ResourceSalesrep.SET_ID = SetIdSetPEO.SET_ID
	AND(ResourceSalesrep.STATUS   = 'A')
	) SetE0
WHERE ResourceEO.PARTY_ID                    = PartyPEO.PARTY_ID
AND ResourceEO.PARTY_ID                        = SetE0.RESOURCE_ID
AND TO_CHAR(PersonDPEONQ1.PERSON_ID)         = OrigSysRefPEONQ1.ORIG_SYSTEM_REFERENCE
AND ResourceEO.PARTY_ID                      = OrigSysRefPEONQ1.OWNER_TABLE_ID
AND(SYSDATE BETWEEN SetE0.START_DATE_ACTIVE AND SetE0.END_DATE_ACTIVE)
ORDER BY RES_RESOURCE_NAME