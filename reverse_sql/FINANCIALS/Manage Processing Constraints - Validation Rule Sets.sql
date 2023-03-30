/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT DOO.DISPLAY_NAME RES_NAME
,DOO.DESCRIPTION RES_DESCRIPTION
,DOO.VALIDATION_TMPLT_SHORT_NAME RES_SHORT_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'DOO_PC_VALIDATION_TYPE'
	AND LOOKUP_CODE = DOO.VALIDATION_TYPE
	AND LANGUAGE = USERENV('LANG')) RES_VALIDATION_TYPE
,(SELECT DATABASE_OBJECT_CODE
	FROM DOO_OBJECTS_B
	WHERE ENTITY_ID = DOO.ENTITY_ID) RES_ENTITY
,DECODE(DOO.SYSTEM_FLAG,'Y','Yes','No') RES_PREDEFINED
,DOO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,DOO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,DOO.CREATED_BY  RSC_CREATED_BY
,DOO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_PC_VTMPLTS_VL DOO