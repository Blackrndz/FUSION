/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_ABC_ASSIGNMENT_GROUPS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT 
(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = AbcAssignmentGroup.ORGANIZATION_ID
	) RES_ORGANIZATION
,AbcAssignmentGroup.ASSIGNMENT_GROUP_NAME RES_ASSIGNMENT_GROUP_NAME
,AbcAssignmentGroup.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,AbcAssignmentGroup.ATTRIBUTE1
,AbcAssignmentGroup.ATTRIBUTE2
,AbcAssignmentGroup.ATTRIBUTE3
,AbcAssignmentGroup.ATTRIBUTE4
,AbcAssignmentGroup.ATTRIBUTE5
,AbcAssignmentGroup.ATTRIBUTE6
,AbcAssignmentGroup.ATTRIBUTE7
,AbcAssignmentGroup.ATTRIBUTE8
,AbcAssignmentGroup.ATTRIBUTE9
,AbcAssignmentGroup.ATTRIBUTE10
,AbcAssignmentGroup.ATTRIBUTE11
,AbcAssignmentGroup.ATTRIBUTE12
,AbcAssignmentGroup.ATTRIBUTE13
,AbcAssignmentGroup.ATTRIBUTE14
,AbcAssignmentGroup.ATTRIBUTE15
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
WHERE (AbcAssignmentGroup.ATTRIBUTE_CATEGORY IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE1          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE2          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE3          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE4          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE5          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE6          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE7          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE8          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE9          IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE10         IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE11         IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE12         IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE13         IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE14         IS NOT NULL
OR AbcAssignmentGroup.ATTRIBUTE15         IS NOT NULL)
ORDER BY RES_ORGANIZATION
,AbcAssignmentGroup.ASSIGNMENT_GROUP_NAME