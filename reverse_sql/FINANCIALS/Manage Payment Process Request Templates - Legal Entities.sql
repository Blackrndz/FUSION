/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT apTemplatesE0.TEMPLATE_NAME RES_NAME
,DECODE(apTemplatesE0.LE_GROUP_OPTION,'ALL','All','SPECIFY','Specific') RES_OPTION_LEGAL_ENTITIES
,legalEntitiesE0.NAME RES_LEGAL_ENTITY
,legalRegistationsE0.REGISTRATION_NUMBER RES_FIRST_PARTY_TAXPAYER_ID
,apLeGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,apLeGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,apLeGroupsE0.CREATED_BY RSC_CREATED_BY
,apLeGroupsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,apLeGroupsE0.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_PAYMENT_TEMPLATES apTemplatesE0
,AP_LE_GROUP apLeGroupsE0
,XLE_ENTITY_PROFILES legalEntitiesE0
,XLE_REGISTRATIONS legalRegistationsE0
WHERE apTemplatesE0.TEMPLATE_ID = apLeGroupsE0.TEMPLATE_ID
AND apLeGroupsE0.LEGAL_ENTITY_ID = legalEntitiesE0.LEGAL_ENTITY_ID
AND legalEntitiesE0.LEGAL_ENTITY_ID = legalRegistationsE0.SOURCE_ID(+)
ORDER BY apTemplatesE0.TEMPLATE_NAME,3