/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT CostOrgEO.COST_ORG_NAME RES_COST_ORGANIZATION
,CostOrgEO.COST_ORG_CODE RES_COST_ORGANIZATION_CODE
,LegalEntityPEO.NAME RES_LEGAL_ENTITY_NAME
,OrganizationDefinitionPEO.ORGANIZATION_NAME RES_ITEM_VALIDATION_ORGANIZATI
,DECODE(CostOrgParametersEO.STD_COST_APPROVAL_FLAG,'Y','Yes','No') RES_STANDARD_COST_APPROVAL
,CostOrgParametersEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CostOrgParametersEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CostOrgParametersEO.CREATED_BY  RSC_CREATED_BY
,CostOrgParametersEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,CostOrgParametersEO.COST_ORG_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ORG_PARAMETERS CostOrgParametersEO
,CST_COST_ORGS_V CostOrgEO
,XLE_ENTITY_PROFILES LegalEntityPEO
,CST_ORGANIZATION_DEFINITIONS_V OrganizationDefinitionPEO
WHERE((((CostOrgParametersEO.COST_ORG_ID           = CostOrgEO.COST_ORG_ID)
AND(CostOrgEO.LEGAL_ENTITY_ID                      = LegalEntityPEO.LEGAL_ENTITY_ID)))
AND(CostOrgParametersEO.VALIDATION_ORGANIZATION_ID = OrganizationDefinitionPEO.ORGANIZATION_ID))
AND OrganizationDefinitionPEO.CLASSIFICATION_CODE  = 'INV'
AND SYSDATE BETWEEN CostOrgEO.EFFECTIVE_START_DATE AND CostOrgEO.EFFECTIVE_END_DATE
ORDER BY CostOrgEO.COST_ORG_NAME