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
,OrganizationDefinitionPEO.ORGANIZATION_NAME RES_ORGANIZATION_NAME
,(SELECT DECODE(MFG_PLANT_FLAG,'Y','Yes','No')
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = CostInvOrgEO.INV_ORG_ID
	) RES_MANUFACTURING_PLANT
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = OrganizationDefinitionPEO.PROFIT_CENTER_BUSINESS_UNIT_ID
	AND SYSDATE BETWEEN DATE_FROM AND DATE_TO
	) RES_PROFIT_CENTER_BUSINESS_UNI
,TO_CHAR(CostInvOrgEO.FROM_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(Extract(YEAR FROM CostInvOrgEO.TO_DATE),'4712',NULL,TO_CHAR(CostInvOrgEO.TO_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,DECODE(OrganizationDefinitionPEO.STATUS,'A','Active') RES_STATUS
,CostInvOrgEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CostInvOrgEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CostInvOrgEO.CREATED_BY RSC_CREATED_BY
,CostInvOrgEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostInvOrgEO.COST_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ORG_PARAMETERS CostOrgParametersEO
,CST_COST_ORGS_V CostOrgEO
,CST_COST_INV_ORGS CostInvOrgEO
,CST_ORGANIZATION_DEFINITIONS_V OrganizationDefinitionPEO
WHERE CostOrgParametersEO.COST_ORG_ID       = CostOrgEO.COST_ORG_ID
AND SYSDATE BETWEEN CostOrgEO.EFFECTIVE_START_DATE AND CostOrgEO.EFFECTIVE_END_DATE
AND CostOrgEO.COST_ORG_ID = CostInvOrgEO.COST_ORG_ID
AND CostInvOrgEO.INV_ORG_ID = OrganizationDefinitionPEO.ORGANIZATION_ID
AND OrganizationDefinitionPEO.CLASSIFICATION_CODE = 'INV'
ORDER BY CostOrgEO.COST_ORG_NAME
,OrganizationDefinitionPEO.ORGANIZATION_NAME