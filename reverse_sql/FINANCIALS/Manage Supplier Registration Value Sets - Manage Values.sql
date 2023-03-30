/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Supplier%20Registration%20Value%20Sets%20-%20Manage%20Values.sql $:
* $Id: Manage Supplier Registration Value Sets - Manage Values.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ValueSetPEO.VALUE_SET_CODE AS RES_VALUE_SET_CODE
,DECODE(ValueSetPEO.VALUE_DATA_TYPE,'VARCHAR2',ValueSetValuePEO.VALUE,'NUMBER',ValueSetValuePEO.VALUE_NUMBER,'DATE',
	TO_CHAR(ValueSetValuePEO.VALUE_DATE,'DD-Mon-YYYY'),'TIMESTAMP',TO_CHAR(ValueSetValuePEO.VALUE_TIMESTAMP,
	'DD-Mon-YYYY HH24:MI:SS'))        AS RES_VALUE
,ValueSetValuePEO.TRANSLATED_VALUE AS	RES_TRANSLATED_VALUE
,ValueSetValuePEO.DESCRIPTION                                              AS RES_DESCRIPTION
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ValueSetValuePEO.ENABLED_FLAG
	),'No')                                                         AS RES_ENABLED
,TO_CHAR(ValueSetValuePEO.START_DATE_ACTIVE,'DD-Mon-YYYY') AS RES_START_DATE
,TO_CHAR(ValueSetValuePEO.END_DATE_ACTIVE,'DD-Mon-YYYY')   AS RES_END_DATE
,DECODE(ValueSetPEO.VALUE_DATA_TYPE,'VARCHAR2',ValueSetValuePEO.INDEPENDENT_VALUE,'NUMBER',
	ValueSetValuePEO.INDEPENDENT_VALUE_NUMBER,'DATE',TO_CHAR(ValueSetValuePEO.INDEPENDENT_VALUE_DATE,'DD-Mon-YYYY'),
	'TIMESTAMP',TO_CHAR(ValueSetValuePEO.INDEPENDENT_VALUE_TIMESTAMP,'DD-Mon-YYYY HH24:MI:SS')) AS RES_INDEPENDENT_VALUE
,ValueSetValuePEO.SORT_ORDER                   AS RES_SORT_ORDER
,DECODE(ValueSetValuePEO.SUMMARY_FLAG,'Y','Yes','N','No')                 AS RES_SUMMARY
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ValueSetValuePEO.FLEX_VALUE_ATTRIBUTE1
	) AS RES_ALLOW_POSTING
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ValueSetValuePEO.FLEX_VALUE_ATTRIBUTE2
	) AS RES_ALLOW_BUDGETING
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'ACCOUNT_TYPE'
	AND lookup_code   = ValueSetValuePEO.FLEX_VALUE_ATTRIBUTE3
	) AS RES_ACCOUNT_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'GL_CONTROL_ACCOUNT_SOURCES'
	AND lookup_code   = ValueSetValuePEO.FLEX_VALUE_ATTRIBUTE4
	) AS RES_THIRD_PARTY_CONTROL_ACCOUN
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ValueSetValuePEO.FLEX_VALUE_ATTRIBUTE5
	) AS RES_RECONCILE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE lookup_type = 'FINANCIAL_CATEGORY'
	AND lookup_code   = ValueSetValuePEO.FLEX_VALUE_ATTRIBUTE6
	) AS RES_FINANCIAL_CATEGORY
,ValueSetValuePEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ValueSetValuePEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ValueSetValuePEO.CREATED_BY RSC_CREATED_BY
,ValueSetValuePEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_VS_VALUES_VL ValueSetValuePEO
,FND_VS_VALUE_SETS ValueSetPEO
WHERE ValueSetValuePEO.VALUE_SET_ID = ValueSetPEO.VALUE_SET_ID
AND ValueSetPEO.MODULE_ID   in   (SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'LBA'
	AND at.module_key    = 'PrcPozCommonPoz'
	AND AT.MODULE_ID     = RF.ANCESTOR_MODULE_ID
	)
ORDER BY RES_VALUE_SET_CODE
,RES_VALUE