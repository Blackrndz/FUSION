/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = AbcAssignmentGroup.ORGANIZATION_ID
	) RES_ORGANIZATION
,AbcAssignmentGroup.ASSIGNMENT_GROUP_NAME RES_ASSIGNMENT_GROUP_NAME
,AbcCompileHeader.COMPILE_NAME RES_ABC_CLASSIFICATION_SET
,AbcAssignmentGroup.SECONDARY_INVENTORY RES_SUBINVENTORY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_ABC_ITEM_SCOPE'
	AND LOOKUP_CODE = AbcAssignmentGroup.ITEM_SCOPE_TYPE
	) RES_VALUATION_SCOPE
,AbcAssignmentGroup.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,AbcAssignmentGroup.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,AbcAssignmentGroup.CREATED_BY  RSC_CREATED_BY
,AbcAssignmentGroup.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,AbcAssignmentGroup.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM INV_ABC_ASSIGNMENT_GROUPS AbcAssignmentGroup
,INV_ABC_COMPILE_HEADERS AbcCompileHeader
WHERE AbcAssignmentGroup.ORGANIZATION_ID              = AbcCompileHeader.ORGANIZATION_ID (+)
AND AbcAssignmentGroup.COMPILE_ID                     = AbcCompileHeader.COMPILE_ID (+)
ORDER BY RES_ORGANIZATION
,AbcAssignmentGroup.ASSIGNMENT_GROUP_NAME