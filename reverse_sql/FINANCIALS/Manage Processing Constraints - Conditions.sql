/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT pcConstraintsE0.CONSTRAINT_NAME RES_CONSTRAINT_NAME
,pcConditionsE0.GROUP_NUMBER RES_GROUP_NUMBER
,(SELECT DISPLAY_NAME
	FROM DOO_OBJECTS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ENTITY_ID = pcConditionsE0.VALIDATION_ENTITY_ID
	) RES_VALIDATION_ENTITY
,DECODE(pcConditionsE0.MODIFIER_FLAG,'Y','Yes','No') RES_INVERT_VALIDATION_RULE_SET
,(SELECT DISPLAY_NAME
	FROM DOO_PC_VTMPLTS_VL
	WHERE VALIDATION_TMPLT_ID = pcConditionsE0.VALIDATION_TMPLT_ID
	AND VALIDATION_ENTITY_ID = pcConditionsE0.VALIDATION_ENTITY_ID
	AND MODULE_ID = pcConditionsE0.MODULE_ID
	) RES_VALIDATION_RULE_SET
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'DOO_PC_SCOPE_OP'
	AND LOOKUP_CODE = pcConditionsE0.SCOPE_OP
	) RES_SCOPE
,(SELECT DISPLAY_NAME
	FROM DOO_PC_RSETS_VL
	WHERE RECORD_SET_ID = pcConditionsE0.RECORD_SET_ID
	) RES_RECORD_SET
,pcConditionsE0.USER_MESSAGE RES_MESSAGE
,DECODE(pcConditionsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,pcConditionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pcConditionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pcConditionsE0.CREATED_BY RSC_CREATED_BY
,pcConditionsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_PC_CONSTRAINTS_VL pcConstraintsE0
,DOO_PC_CONDITIONS_VL pcConditionsE0
WHERE pcConstraintsE0.CONSTRAINT_ID  = pcConditionsE0.CONSTRAINT_ID 
ORDER BY DECODE(pcConstraintsE0.SYSTEM_FLAG,'N',1,2)
,pcConstraintsE0.CONSTRAINT_NAME
,pcConditionsE0.GROUP_NUMBER