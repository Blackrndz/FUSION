/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Person%20Extensible%20Flexfield%20-%20Contexts.sql $:
 * $Id: Manage Person Extensible Flexfield - Contexts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT flexfieldsE0.NAME RES_FLEXFIELD_NAME
,flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE RES_FLEXFIELD_CODE
,contextsE0.NAME RES_DISPLAY_NAME
,contextsE0.CONTEXT_CODE RES_CONTEXT_CODE
,contextsE0.CONTEXT_IDENTIFIER RES_API_NAME
,contextsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(contextsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(contextsE0.TRANSLATABLE_FLAG,'Y','Yes','No') RES_TRANSLATABLE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FND_EF_CONTEXT_MULTIROW_TYPES'
	AND LOOKUP_CODE = contextsE0.MULTIROW_FLAG
	) RES_BEHAVIOR
,contextsE0.INSTRUCTION_HELP_TEXT RES_INSTRUCTION_HELP_TEXT
,contextsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextsE0.CREATED_BY RSC_CREATED_BY
,contextsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfieldsE0
,FND_DF_CONTEXTS_VL contextsE0
WHERE flexfieldsE0.FLEXFIELD_TYPE = 'EFF'
AND flexfieldsE0.APPLICATION_ID = 800
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'extensibleFlexfieldCode'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'ORA_PER_MANAGE_PERSON_EXTENSIBLE_FLEXFIELDS'))
		)
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfieldsE0.APPLICATION_ID = contextsE0.APPLICATION_ID
ORDER BY flexfieldsE0.NAME
,contextsE0.NAME