/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HEAD.VALUE_SET_CODE RES_VALUE_SET_CODE
,DECODE(HEAD.VALUE_DATA_TYPE, 'DATE', TO_CHAR(Detail.VALUE_DATE, 'DD-Mon-YYYY'), 'TIMESTAMP', TO_CHAR(Detail.VALUE_TIMESTAMP, 'DD-Mon-YYYY HH24:MI:SS'), TO_CHAR(Detail.VALUE)) RES_VALUE 
,Detail.TRANSLATED_VALUE RES_TRANSLATED_VALUE
,Detail.DESCRIPTION RES_DESCRIPTION
,DECODE(Detail.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(Detail.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(Detail.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,(CASE
	WHEN Head.VALIDATION_TYPE = 'SUBSET' THEN
		NULL
	WHEN Detail.INDEPENDENT_VALUE_DATE IS NOT NULL THEN
		TO_CHAR(Detail.INDEPENDENT_VALUE_DATE, 'DD-Mon-YYYY')
	WHEN Detail.INDEPENDENT_VALUE_TIMESTAMP IS NOT NULL THEN
		TO_CHAR(Detail.INDEPENDENT_VALUE_TIMESTAMP, 'DD-Mon-YYYY HH24:MI:SS')
	ELSE
		Detail.INDEPENDENT_VALUE
	END) RES_INDEPENDENT_VALUE
,Detail.SORT_ORDER RES_SORT_ORDER
,Detail.ATTRIBUTE1 RES_FUND_TYPE
,Detail.ATTRIBUTE2 RES_FUND_PURPOSE
,DECODE(Detail.SUMMARY_FLAG,'Y','Yes','N','No') RES_SUMMARY
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = Detail.FLEX_VALUE_ATTRIBUTE1
	) AS RES_ALLOW_POSTING
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = Detail.FLEX_VALUE_ATTRIBUTE2
	) AS RES_ALLOW_BUDGETING
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'ACCOUNT_TYPE'
	AND lookup_code   = Detail.FLEX_VALUE_ATTRIBUTE3
	) AS RES_ACCOUNT_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'GL_CONTROL_ACCOUNT_SOURCES'
	AND lookup_code   = Detail.FLEX_VALUE_ATTRIBUTE4
	) AS RES_THIRD_PARTY_CONTROL_ACCOUN
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = Detail.FLEX_VALUE_ATTRIBUTE5
	) AS RES_RECONCILE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'FINANCIAL_CATEGORY'
	AND lookup_code   = Detail.FLEX_VALUE_ATTRIBUTE6
	) AS RES_FINANCIAL_CATEGORY
,Detail.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY RSC_CREATED_BY
,Detail.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ValueSetEO.VALUE_SET_CODE
	,ValueSetEO.VALUE_SET_ID
	,ValueSetEO.VALUE_DATA_TYPE
	,ValueSetEO.VALIDATION_TYPE
	FROM FND_VS_VALUE_SETS ValueSetEO
	,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
	,FND_LOOKUPS ValidationTypeLookupPEO
	,FND_LOOKUPS ValueDataTypeLookupPEO
	WHERE ValueSetEO.MODULE_ID     = ApplTaxonomyPEO.MODULE_ID
	AND ValueSetEO.VALIDATION_TYPE = ValidationTypeLookupPEO.LOOKUP_CODE
	AND ValueSetEO.VALUE_DATA_TYPE = ValueDataTypeLookupPEO.LOOKUP_CODE
	AND(ValueSetEO.module_id      IN
		(SELECT rf.child_module_id
		FROM fnd_appl_taxonomy_rf rf
		INNER JOIN fnd_appl_taxonomy t
		ON rf.ancestor_module_id = t.module_id
		WHERE t.module_type      = 'LBA'
		AND t.module_key         = 'PrcPoCommonPo'
		))
	AND(((ValueSetEO.VALUE_SET_CODE NOT LIKE('%' ||'$FLEX$'|| '%'))
	AND(ValidationTypeLookupPEO.LOOKUP_TYPE = 'FND_VS_VALIDATION_TYPES')
	AND(ValueDataTypeLookupPEO.LOOKUP_TYPE  = 'FND_VS_VALUE_DATA_TYPES')))
	) HEAD
,(SELECT ValueSetValueEO.VALUE_SET_ID
	,ValueSetValueEO.VALUE
	,ValueSetValueEO.VALUE_DATE
	,ValueSetValueEO.VALUE_TIMESTAMP
	,ValueSetValueEO.TRANSLATED_VALUE
	,ValueSetValueEO.DESCRIPTION
	,ValueSetValueEO.ENABLED_FLAG
	,ValueSetValueEO.START_DATE_ACTIVE
	,ValueSetValueEO.END_DATE_ACTIVE
	,ValueSetValueEO.INDEPENDENT_VALUE
	,ValueSetValueEO.INDEPENDENT_VALUE_DATE
	,ValueSetValueEO.INDEPENDENT_VALUE_TIMESTAMP
	,ValueSetValueEO.SORT_ORDER
	,ValueSetValueEO.SUMMARY_FLAG
	,ValueSetValueEO.FLEX_VALUE_ATTRIBUTE1
	,ValueSetValueEO.FLEX_VALUE_ATTRIBUTE2
	,ValueSetValueEO.FLEX_VALUE_ATTRIBUTE3
	,ValueSetValueEO.FLEX_VALUE_ATTRIBUTE4
	,ValueSetValueEO.FLEX_VALUE_ATTRIBUTE5
	,ValueSetValueEO.FLEX_VALUE_ATTRIBUTE6
	,ValueSetValueEO.ATTRIBUTE1
	,ValueSetValueEO.ATTRIBUTE2
	,ValueSetValueEO.LAST_UPDATED_BY
	,ValueSetValueEO.LAST_UPDATE_DATE
	,ValueSetValueEO.CREATED_BY
	,ValueSetValueEO.CREATION_DATE
	FROM FND_VS_VALUES_VL ValueSetValueEO
	) Detail
WHERE Head.VALUE_SET_ID = Detail.VALUE_SET_ID
ORDER BY Head.VALUE_SET_CODE
,RES_VALUE