/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_MAP_TYPES_VL

SELECT ExmMapTypesVl.MAP_TYPE_CODE RES_NAME
,ExmMapTypesVl.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUP_TYPES_VL
	WHERE LOOKUP_TYPE = ExmMapTypesVl.FROM_LOOKUP_TYPE
	) RES_SOURCE_LOOKUP_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_CARD_EXPENSE_TYPE'
	AND LOOKUP_CODE = ExmMapTypesVl.DEFAULT_LOOKUP_CODE
	) RES_DEFAULT_CARD_EXPENSE_TYPE
,ExmMapTypesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmMapTypesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmMapTypesVl.CREATED_BY RSC_CREATED_BY
,ExmMapTypesVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_MAP_TYPES_VL ExmMapTypesVl
ORDER BY ExmMapTypesVl.MAP_TYPE_CODE