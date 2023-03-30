/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HzParties.PARTY_NAME RES_TAX_AUTHORITY_NAME
,(HzParties.ADDRESS1||HzParties.ADDRESS2||HzParties.ADDRESS3||HzParties.ADDRESS4||HzParties.CITY) RES_ADDRESS
,FndTerritoriesVl.TERRITORY_SHORT_NAME RES_COUNTRY
,(CASE
		WHEN PartyTaxProfileEO.COLLECTING_AUTHORITY_FLAG = 'Y'
		AND PartyTaxProfileEO.REPORTING_AUTHORITY_FLAG   = 'N'
		THEN 'Collecting'
		WHEN PartyTaxProfileEO.COLLECTING_AUTHORITY_FLAG = 'N'
		AND PartyTaxProfileEO.REPORTING_AUTHORITY_FLAG   = 'Y'
		THEN 'Reporting'
		WHEN PartyTaxProfileEO.COLLECTING_AUTHORITY_FLAG = 'Y'
		AND PartyTaxProfileEO.REPORTING_AUTHORITY_FLAG   = 'Y'
		THEN 'Collecting and Reporting'
	END) RES_TAX_AUTHORITY_TYPE
,NULL RES_DOCUMENT_CONTROL_TYPE
,NULL RES_ENABLED_VALUE
,NULL RES_UNIT
,NULL RES_START_DATE
,NULL RES_END_DATE
,'No' RES_ENABLED
,PartyTaxProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PartyTaxProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PartyTaxProfileEO.CREATED_BY RSC_CREATED_BY
,PartyTaxProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE PartyTaxProfileEO
,HZ_PARTIES HzParties
,FND_TERRITORIES_VL FndTerritoriesVl
WHERE PartyTaxProfileEO.COUNTRY_CODE  = FndTerritoriesVl.TERRITORY_CODE (+)
AND PartyTaxProfileEO.PARTY_ID        = HzParties.PARTY_ID
AND PartyTaxProfileEO.PARTY_TYPE_CODE = 'TAX_AUTHORITY'
ORDER BY HzParties.PARTY_NAME