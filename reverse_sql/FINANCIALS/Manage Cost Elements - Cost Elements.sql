/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT CostElementPEO.COST_ELEMENT_CODE RES_COST_ELEMENT
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CostElementPEO.SET_ID
	) RES_COST_ELEMENT_SET
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_COST_ELEMENT_TYPES'
	ANd LOOKUP_CODE = CostElementPEO.COST_ELEMENT_TYPE
	) RES_COST_ELEMENT_TYPE
,CostElementPEO.COST_ELEMENT_DESC RES_DESCRIPTION
,(SELECT ORGANIZATION_NAME
	FROM INV_ORGANIZATION_DEFINITIONS_V
	WHERE ORGANIZATION_ID = CostElementPEO.INV_ORG_ID
	) RES_INVENTORY_ORGANIZATION
,CostElementPEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CostElementPEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CostElementPEO.CREATED_BY RSC_CREATED_BY
,CostElementPEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostElementPEO.INV_ORG_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COST_ELEMENTS_VL CostElementPEO
ORDER BY CostElementPEO.COST_ELEMENT_CODE