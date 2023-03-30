/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT SetIdSetPEO.SET_NAME RES_VALUATION_STRUCTURE_SET
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_VALUATION_STRUCTURE_TYPES'
	AND LOOKUP_CODE = ValStructureEO.VAL_STRUCTURE_TYPE_CODE
	) RES_VALUATION_STRUCTURE_TYPE
,ValStructureEO.VAL_STRUCTURE_CODE RES_VALUATION_STRUCTURE_CODE
,ValStructureEO.VAL_STRUCTURE_DESC RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CST_VALUATION_STRUCTURE_MODES'
	AND LOOKUP_CODE = ValStructureEO.VAL_STRUCTURE_MODE_CODE
	)RES_VALUATION_STRUCTURE_MODE
,(SELECT NAME
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = ValStructureEO.STRUCTURE_INSTANCE_NUMBER
	) RES_FLEXFIELD_STRUCTURE
,ValStructureEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ValStructureEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ValStructureEO.CREATED_BY  RSC_CREATED_BY
,ValStructureEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_VAL_STRUCTURES_VL ValStructureEO
,FND_SETID_SETS_VL SetIdSetPEO
WHERE ValStructureEO.SET_ID = SetIdSetPEO.SET_ID
ORDER BY ValStructureEO.VAL_STRUCTURE_CODE