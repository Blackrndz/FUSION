/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Mappings%20-%20Manage%20Chart%20of%20Accounts%20Mappings.sql $:
 * $Id: Manage Chart of Accounts Mappings - Manage Chart of Accounts Mappings.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
select COAMAPPINGEO.name RES_NAME
,CoaMappingEO.DESCRIPTION RES_DESCRIPTION
,KeyFlexfieldStructureInstanc1.NAME RES_TARGET_CHART_OF_ACCOUNTS
,KEYFLEXFIELDSTRUCTUREINSTANC11.name RES_SOURCE_CHART_OF_ACCOUNTS
,CoaMappingEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CoaMappingEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CoaMappingEO.CREATED_BY  RSC_CREATED_BY
,CoaMappingEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, (SELECT DISTINCT LedgerE0.CHART_OF_ACCOUNTS_ID 
	FROM GL_LEDGER_RELATIONSHIPS GlRelation
	,GL_LEDGERS LedgerE0
	WHERE GlRelation.SL_COA_MAPPING_ID = CoaMappingEO.COA_MAPPING_ID
	AND GlRelation.PRIMARY_LEDGER_ID = LedgerE0.LEDGER_ID
	) RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM GL_COA_MAPPINGS CoaMappingEO
,FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc1
,FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc11
WHERE(CoaMappingEO.TO_COA_ID                          = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER)
AND(CoaMappingEO.FROM_COA_ID                          = KeyFlexfieldStructureInstanc11.STRUCTURE_INSTANCE_NUMBER)
AND(KeyFlexfieldStructureInstanc1.APPLICATION_ID      = 101
AND KeyFlexfieldStructureInstanc1.KEY_FLEXFIELD_CODE  = 'GL#'
AND KeyFlexfieldStructureInstanc1.ENABLED_FLAG        = 'Y')
AND(KeyFlexfieldStructureInstanc11.APPLICATION_ID     = 101
AND KeyFlexfieldStructureInstanc11.KEY_FLEXFIELD_CODE = 'GL#'
AND KeyFlexfieldStructureInstanc11.ENABLED_FLAG       = 'Y')
ORDER BY CoaMappingEO.NAME