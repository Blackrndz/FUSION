/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=HRC_DL_LAYOUTS_VL
--RSC_PREREQUISITE_OBJECTS=HRC_DL_LAYOUT_PARAMS

SELECT hdcDLLAYOUTEO.LAYOUT_CODE RES_CODE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = hrcDLLAYOUYPARAMEO.PARAM_NAME
		AND LOOKUP_TYPE = 'HRC_DL_PARAMETERS' AND LANGUAGE = USERENV('LANG')
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_PARAMETER
,(CASE WHEN hrcDLLAYOUYPARAMEO.PARAM_NAME = 'ORA_PURGE_FUTURE_CHANGES'
	THEN 
		(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = hrcDLLAYOUYPARAMEO.PARAM_VALUE
		AND LOOKUP_TYPE = 'ORA_HRC_DL_PURGE_FUT_CHANGES' AND LANGUAGE = USERENV('LANG')
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) 
	WHEN hrcDLLAYOUYPARAMEO.PARAM_NAME IN ('LOAD_MULTI_THREAD_NUMBER','LOAD_MAX_PCNT_ERROR')
		THEN hrcDLLAYOUYPARAMEO.PARAM_VALUE
	ELSE
		 DECODE(hrcDLLAYOUYPARAMEO.PARAM_VALUE,'Y','Yes','No') 
		END) RES_VALUE
,(SELECT DESCRIPTION  FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = hrcDLLAYOUYPARAMEO.PARAM_NAME
		AND LOOKUP_TYPE = 'HRC_DL_PARAMETERS' AND LANGUAGE = USERENV('LANG')
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_DESCRIPTION
,hdcDLLAYOUTEO.LAYOUT_CATEGORY_CODE RES_CATEGORY

,hrcDLLAYOUYPARAMEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrcDLLAYOUYPARAMEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrcDLLAYOUYPARAMEO.CREATED_BY RSC_CREATED_BY
,hrcDLLAYOUYPARAMEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,(SELECT LEGISLATION_CODE 
	FROM PER_LEGISLATIVE_DATA_GROUPS
	WHERE LEGISLATIVE_DATA_GROUP_ID = hdcDLLAYOUTEO.LEGISLATIVE_DATA_GROUP_ID
	) RSC_COUNTRY_ID

FROM HRC_DL_LAYOUTS_VL  hdcDLLAYOUTEO
,HRC_DL_LAYOUT_PARAMS hrcDLLAYOUYPARAMEO
WHERE hdcDLLAYOUTEO.LAYOUT_ID = hrcDLLAYOUYPARAMEO.LAYOUT_ID
ORDER BY hdcDLLAYOUTEO.LAYOUT_CODE