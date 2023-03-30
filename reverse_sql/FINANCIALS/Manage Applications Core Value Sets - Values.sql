/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Applications Core Value Sets - Manage Applications Core Value Sets.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HEAD.VALUE_SET_CODE RES_VALUE_SET_CODE
,DECODE(HEAD.VALUE_DATA_TYPE,'DATE',TO_CHAR(Detail.VALUE_DATE,'DD-Mon-YYYY'),'TIMESTAMP',TO_CHAR(
	Detail.VALUE_TIMESTAMP,'DD-Mon-YYYY HH24:MI:SS'),TO_CHAR(Detail.VALUE)) RES_VALUE
,Detail.TRANSLATED_VALUE RES_TRANSLATED_VALUE
,Detail.DESCRIPTION RES_DESCRIPTION
,DECODE(Detail.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(Detail.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(Detail.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,(
	CASE
		WHEN Head.VALIDATION_TYPE = 'SUBSET' 
		THEN NULL
		WHEN Detail.INDEPENDENT_VALUE_DATE IS NOT NULL
		THEN TO_CHAR(Detail.INDEPENDENT_VALUE_DATE,'DD-Mon-YYYY')
		WHEN Detail.INDEPENDENT_VALUE_TIMESTAMP IS NOT NULL
		THEN TO_CHAR(Detail.INDEPENDENT_VALUE_TIMESTAMP,'DD-Mon-YYYY HH24:MI:SS')
		ELSE Detail.INDEPENDENT_VALUE
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
		WHERE t.module_type      = 'APPLICATION'
		AND t.module_key         = 'FND'
		))
	AND(((ValueSetEO.VALUE_SET_CODE NOT LIKE('%' ||'$FLEX$'|| '%'))
	AND(ValidationTypeLookupPEO.LOOKUP_TYPE = 'FND_VS_VALIDATION_TYPES')
	AND(ValueDataTypeLookupPEO.LOOKUP_TYPE  = 'FND_VS_VALUE_DATA_TYPES')))
	) HEAD
,FND_VS_VALUES_VL Detail
WHERE Head.VALUE_SET_ID = Detail.VALUE_SET_ID
ORDER BY Head.VALUE_SET_CODE
,RES_VALUE