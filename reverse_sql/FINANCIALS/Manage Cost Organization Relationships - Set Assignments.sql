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
,(SELECT VISIBLE_GROUP_NAME
	FROM FND_SETID_REFERENCE_GROUPS_VL
	WHERE REFERENCE_GROUP_NAME = SetIdAssignmentsEO.REFERENCE_GROUP_NAME
	) RES_REFERENCE_DATA_OBJECT
,SetIdSetPEO.SET_NAME RES_REFERENCE_DATA_SET_NAME
,SetIdSetPEO.SET_CODE RES_REFERENCE_DATA_SET_CODE
,SetIdAssignmentsEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SetIdAssignmentsEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SetIdAssignmentsEO.CREATED_BY  RSC_CREATED_BY
,SetIdAssignmentsEO.CREATION_DATE  RSC_CREATION_DATE
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
,FND_SETID_ASSIGNMENTS SetIdAssignmentsEO
,CST_ORGANIZATION_DEFINITIONS_V OrganizationDefinitionPEO
,FND_SETID_SETS_VL SetIdSetPEO
WHERE((((CostOrgParametersEO.COST_ORG_ID           = CostOrgEO.COST_ORG_ID)
AND(CostOrgEO.LEGAL_ENTITY_ID                      = LegalEntityPEO.LEGAL_ENTITY_ID))
AND(CostOrgParametersEO.COST_ORG_ID                = SetIdAssignmentsEO.DETERMINANT_VALUE))
AND(CostOrgParametersEO.VALIDATION_ORGANIZATION_ID = OrganizationDefinitionPEO.ORGANIZATION_ID))
AND(SetIdAssignmentsEO.SET_ID                      = SetIdSetPEO.SET_ID)
AND SetIdAssignmentsEO.DETERMINANT_TYPE            = 'CST'
AND OrganizationDefinitionPEO.CLASSIFICATION_CODE  = 'INV'
AND SYSDATE BETWEEN CostOrgEO.EFFECTIVE_START_DATE AND CostOrgEO.EFFECTIVE_END_DATE
ORDER BY CostOrgEO.COST_ORG_NAME