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
,pcConstraintsE0.DISPLAY_NAME RES_DISPLAY_NAME
,(SELECT DISPLAY_NAME
	FROM DOO_OBJECTS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ENTITY_ID = pcConstraintsE0.ENTITY_ID
	) RES_CONSTRAINT_ENTITY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'DOO_PC_OPERATION'
	AND LOOKUP_CODE = pcConstraintsE0.CONSTRAINED_OPERATION
	) RES_CONSTRAINED_OPERATION
,(SELECT DESCRIPTION
	FROM DOO_OBJECT_ATTRIBUTES_VL
	WHERE ENTITY_ID = pcConstraintsE0.ENTITY_ID
	AND COLUMN_NAME = pcConstraintsE0.COLUMN_NAME
	AND NVL(EFF_CONTEXT_CODE,'XXX') = NVL(pcConstraintsE0.EFF_CONTEXT_CODE,'XXX')
	) RES_ATTRIBUTE_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'DOO_PC_ON_OPERATION_ACTION'
	AND LOOKUP_CODE = pcConstraintsE0.ON_OPERATION_ACTION
	) RES_ON_OPERATION_ACTION
,pcConstraintsE0.APPLICABLE_ROLES_CATEGORY RES_APPLICABLE_ROLES
,DECODE(pcConstraintsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(pcConstraintsE0.SYSTEM_FLAG,'N','No','Yes') RES_PREDEFINED
,pcConstraintsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pcConstraintsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pcConstraintsE0.CREATED_BY RSC_CREATED_BY
,pcConstraintsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_PC_CONSTRAINTS_VL pcConstraintsE0
ORDER BY DECODE(pcConstraintsE0.SYSTEM_FLAG,'N',1,2)
,pcConstraintsE0.CONSTRAINT_NAME