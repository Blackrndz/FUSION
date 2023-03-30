/* ****************************************************************************
 * $Revision: 73417 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2020-01-31 11:27:39 +0700 (Fri, 31 Jan 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Employment%20Extensible%20Flexfields%20-%20Extensible%20FlexFields.sql $:
 * $Id: Manage Employment Extensible Flexfields - Extensible FlexFields.sql 73417 2020-01-31 04:27:39Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT flexfieldsE0.NAME RES_FLEXFIELD_NAME
,flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE RES_FLEXFIELD_CODE
,flexfieldsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT APPLICATION_NAME
	FROM FND_APPLICATION_VL
	WHERE APPLICATION_ID = flexfieldsE0.APPLICATION_ID
	) RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = flexfieldsE0.MODULE_ID
	) RES_MODULE
,flexfieldsE0.CATEGORY_HIERARCHY_LABEL RES_CATEGORY_HIERARCHY
,flexfieldsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,flexfieldsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,flexfieldsE0.CREATED_BY RSC_CREATED_BY
,flexfieldsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfieldsE0
WHERE flexfieldsE0.FLEXFIELD_TYPE = 'EFF'
AND flexfieldsE0.APPLICATION_ID = 800
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'extensibleFlexfieldCode'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'ORA_PER_MANAGE_EMPLOYMENT_EXTENSIBLE_FLEXFIELDS'))
		)
ORDER BY flexfieldsE0.NAME