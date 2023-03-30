/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT pcRecordSetsE0.DISPLAY_NAME RES_NAME
,pcRecordSetsE0.DESCRIPTION RES_DESCRIPTION
,pcRecordSetsE0.RECORD_SET_SHORT_NAME RES_SHORT_NAME
,(SELECT DISPLAY_NAME
	FROM DOO_OBJECTS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ENTITY_ID = pcRecordSetsE0.ENTITY_ID
	) RES_ENTITY
,DECODE(pcRecordSetsE0.SYSTEM_FLAG,'Y','Yes','No') RES_PREDEFINED
,pcRecordSetsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pcRecordSetsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pcRecordSetsE0.CREATED_BY RSC_CREATED_BY
,pcRecordSetsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_PC_RSETS_VL pcRecordSetsE0
ORDER BY DECODE(pcRecordSetsE0.SYSTEM_FLAG,'Y',2,1)
,pcRecordSetsE0.DISPLAY_NAME