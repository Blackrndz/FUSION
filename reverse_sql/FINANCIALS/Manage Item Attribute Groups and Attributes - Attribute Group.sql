/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-20 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Buyer Assignment Rule Sets Lookup - Lookup Codes.sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT contextFlexfeildsE0.NAME RES_DISPLAY_NAME
,contextFlexfeildsE0.CONTEXT_CODE RES_INTERNAL_NAME
,contextFlexfeildsE0.CONTEXT_IDENTIFIER RES_API_NAME
,contextFlexfeildsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(contextFlexfeildsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(contextFlexfeildsE0.TRANSLATABLE_FLAG,'Y','Yes','No') RES_TRANSLATABLE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FND_EF_CONTEXT_MULTIROW_TYPES'
	AND LOOKUP_CODE = contextFlexfeildsE0.MULTIROW_FLAG
	) RES_BEHAVIOR
,DECODE(contextFlexfeildsE0.C_EXT_ATTRIBUTE1,'Y','Yes','No') RES_VARIANT
,contextFlexfeildsE0.C_EXT_ATTRIBUTE2 RES_DATABASE_VIEW_NAME_PREFIX
,contextFlexfeildsE0.INSTRUCTION_HELP_TEXT RES_INSTRUCTION_HELP_TEXT
,contextFlexfeildsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextFlexfeildsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextFlexfeildsE0.CREATED_BY RSC_CREATED_BY
,contextFlexfeildsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfiieldsE0
,FND_DF_CONTEXTS_VL contextFlexfeildsE0
WHERE flexfiieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextFlexfeildsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfiieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = 'EGO_ITEM_EFF'
ORDER BY contextFlexfeildsE0.NAME