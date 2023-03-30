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
-- DFF_LOGIC_TO_APPLY=401##RES##INV_ABC_COMPILE_HEADERS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT 
(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = AbcCompileHeader.ORGANIZATION_ID
	) RES_ORGANIZATION
,AbcCompileHeader.COMPILE_NAME RES_NAME
,AbcCompileHeader.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,AbcCompileHeader.ATTRIBUTE1
,AbcCompileHeader.ATTRIBUTE2
,AbcCompileHeader.ATTRIBUTE3
,AbcCompileHeader.ATTRIBUTE4
,AbcCompileHeader.ATTRIBUTE5
,AbcCompileHeader.ATTRIBUTE6
,AbcCompileHeader.ATTRIBUTE7
,AbcCompileHeader.ATTRIBUTE8
,AbcCompileHeader.ATTRIBUTE9
,AbcCompileHeader.ATTRIBUTE10
,AbcCompileHeader.ATTRIBUTE11
,AbcCompileHeader.ATTRIBUTE12
,AbcCompileHeader.ATTRIBUTE13
,AbcCompileHeader.ATTRIBUTE14
,AbcCompileHeader.ATTRIBUTE15
,AbcCompileHeader.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AbcCompileHeader.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AbcCompileHeader.CREATED_BY RSC_CREATED_BY
,AbcCompileHeader.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,AbcCompileHeader.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ABC_COMPILE_HEADERS AbcCompileHeader
WHERE (AbcCompileHeader.ATTRIBUTE_CATEGORY IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE1          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE2          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE3          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE4          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE5          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE6          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE7          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE8          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE9          IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE10         IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE11         IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE12         IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE13         IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE14         IS NOT NULL
OR AbcCompileHeader.ATTRIBUTE15         IS NOT NULL)
ORDER BY RES_ORGANIZATION
,AbcCompileHeader.COMPILE_NAME