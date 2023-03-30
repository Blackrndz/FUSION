/* ****************************************************************************
 * $Revision: 79925 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-01-04 11:23:17 +0700 (Wed, 04 Jan 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Party%20Tax%20Profiles%20-%20Business%20Unit%20Tax%20Profile%20(Controls%20and%20Defaults).sql $:
 * $Id: Manage Party Tax Profiles - Business Unit Tax Profile (Controls and Defaults).sql 79925 2023-01-04 04:23:17Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 --RSC_PREREQUISITE_OBJECTS=ZX_PARTY_TAX_PROFILE

SELECT FinancialsBusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,DECODE(BusinessUnitTaxProfileEO.TAX_GROSS_NET_FLAG,'G','Yes','No') RES_USE_GROSS_AMOUNT_FOR_PAYAB
,DECODE(BusinessUnitTaxProfileEO.USE_LE_AS_SUBSCRIBER_FLAG,'Y','Yes','No') RES_USE_LEGAL_ENTITY_TAX_SUBSC
,TO_CHAR(BusinessUnitTaxProfileEO.EFFECTIVE_FROM_USE_LE,'DD-Mon-YYYY') RES_USE_SUBSCRIPTION_OF_THE_LE
,DECODE(BusinessUnitTaxProfileEO.WHT_USE_LE_AS_SUBSCRIBER_FLAG,'Y','Yes','No') RES_USE_LEGAL_ENTITY_WITHHOLDI

,BusinessUnitTaxProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BusinessUnitTaxProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BusinessUnitTaxProfileEO.CREATED_BY RSC_CREATED_BY
,BusinessUnitTaxProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,FinancialsBusinessUnitPEO.BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE BusinessUnitTaxProfileEO
,FUN_ALL_BUSINESS_UNITS_V FinancialsBusinessUnitPEO
WHERE BusinessUnitTaxProfileEO.PARTY_ID = FinancialsBusinessUnitPEO.BU_ID
ORDER BY FinancialsBusinessUnitPEO.BU_NAME