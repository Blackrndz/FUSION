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
	WHERE ORGANIZATION_ID = AbcCompileHeader.ORGANIZATION_ID
	) RES_ORGANIZATION
,AbcCompileHeader.COMPILE_NAME RES_NAME
,AbcCompileHeader.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_ABC_ITEM_SCOPE'
	AND LOOKUP_CODE = DECODE(SECONDARY_INVENTORY,NULL,1,2)
	) RES_CONTENT_SCOPE
,AbcCompileHeader.SECONDARY_INVENTORY RES_SUBINVENTORY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_ABC_ITEM_SCOPE'
	AND LOOKUP_CODE = AbcCompileHeader.ITEM_SCOPE_CODE
	) RES_VALUATION_SCOPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_ABC_COMPILE_TYPE'
	AND LOOKUP_CODE = AbcCompileHeader.COMPILE_TYPE
	) RES_CRITERIA
,TO_CHAR(AbcCompileHeader.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(AbcCompileHeader.CUTOFF_DATE,'DD-Mon-YYYY') RES_END_DATE
,AbcCompileHeader.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,AbcCompileHeader.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,AbcCompileHeader.CREATED_BY  RSC_CREATED_BY
,AbcCompileHeader.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,AbcCompileHeader.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM INV_ABC_COMPILE_HEADERS AbcCompileHeader
ORDER BY RES_ORGANIZATION
,AbcCompileHeader.COMPILE_NAME