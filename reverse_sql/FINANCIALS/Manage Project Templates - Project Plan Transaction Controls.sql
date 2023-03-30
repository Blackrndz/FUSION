/* ****************************************************************************
* $Revision: 78557 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-05-24 10:32:18 +0700 (Tue, 24 May 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Project%20Plan%20Transaction%20Controls.sql $:
* $Id: Manage Project Templates - Project Plan Transaction Controls.sql 78557 2022-05-24 03:32:18Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT ELEMENT_NUMBER
	FROM PJF_PROJ_ELEMENTS_VL
	WHERE PROJ_ELEMENT_ID = projElementsE0.DENORM_PARENT_ELEMENT_ID
	) RES_PARENT_TASK_NUMBER
,projElementsE0.ELEMENT_NUMBER RES_TASK_NUMBER
,(SELECT MEANING
    FROM FND_LOOKUPS
    WHERE LOOKUP_TYPE = 'PJC_LIMIT_FLAG'
    AND LOOKUP_CODE = projElementsE0.LIMIT_TO_TXN_CONTROLS_FLAG 
	 ) RES_TRANSACTION_CONTROL
,trxControlsE0.RULE_NUMBER RES_RULE_NUMBER
,(SELECT EXPENDITURE_CATEGORY_NAME
    FROM PJF_EXP_CATEGORIES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND EXPENDITURE_CATEGORY_ID = trxControlsE0.EXPENDITURE_CATEGORY_ID
    ) RES_EXPENDITURE_CATEGORY
,(SELECT EXPENDITURE_TYPE_NAME
    FROM PJF_EXP_TYPES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND EXPENDITURE_TYPE_ID = trxControlsE0.EXPENDITURE_TYPE_ID
    ) RES_EXPENDITURE_TYPE
,(SELECT NLR_NAME
    FROM PJF_NON_LABOR_RES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND NON_LABOR_RESOURCE_ID = trxControlsE0.NON_LABOR_RESOURCE_ID
    ) RES_NONLABOR_RESOURCE
,(SELECT FULL_NAME
    FROM PER_PERSON_NAMES_F
    WHERE PERSON_ID = trxControlsE0.PERSON_ID
    AND NAME_TYPE = 'GLOBAL'
    AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    ) RES_PERSON
,(SELECT NAME
    FROM PER_JOBS_F_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND JOB_ID = trxControlsE0.JOB_ID
    AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    ) RES_JOB
,(SELECT NAME
    FROM HR_ALL_ORGANIZATION_UNITS
    WHERE ORGANIZATION_ID = trxControlsE0.ORGANIZATION_ID
    ) RES_ORGANIZATION
,(SELECT MEANING
    FROM FND_LOOKUPS
    WHERE LOOKUP_TYPE = 'PJC_PERSON_TYPE'
    AND LOOKUP_CODE = trxControlsE0.PERSON_TYPE
    ) RES_SYSTEM_PERSON_TYPE
,DECODE(trxControlsE0.CHARGEABLE_FLAG,'Y','Yes','No') RES_CHARGEABLE
,(CASE
	WHEN projTypesE0.ENABLE_BILLING_FLAG = 'Y' THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'PJC_BILLABLE_INDICATOR'
			AND LOOKUP_CODE = trxControlsE0.BILLABLE_FLAG)
    END) RES_BILLABLE
,(CASE
	WHEN projTypesE0.ENABLE_CAPITALIZATION_FLAG = 'Y' THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'PJC_BILLABLE_INDICATOR'
			AND LOOKUP_CODE = trxControlsE0.CAPITALIZABLE_FLAG)
	END) RES_CAPITALIZABLE
,TO_CHAR(trxControlsE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(trxControlsE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,trxControlsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,trxControlsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,trxControlsE0.CREATED_BY  RSC_CREATED_BY
,trxControlsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJF_PROJ_ELEMENTS_VL projElementsE0
,PJC_TRANSACTION_CONTROLS trxControlsE0
,PJF_PROJECT_TYPES_B projTypesE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = projElementsE0.PROJECT_ID
AND projElementsE0.PROJECT_ID = trxControlsE0.PROJECT_ID
AND projElementsE0.PROJ_ELEMENT_ID = trxControlsE0.TASK_ID
AND projTemplatesE0.PROJECT_TYPE_ID = projTypesE0.PROJECT_TYPE_ID
ORDER BY projTemplatesE0.NAME
,DECODE(projElementsE0.OBJECT_TYPE,'PJF_STRUCTURES',1,2)
,projElementsE0.DENORM_WBS_LEVEL
,projElementsE0.ELEMENT_NUMBER
,trxControlsE0.RULE_NUMBER