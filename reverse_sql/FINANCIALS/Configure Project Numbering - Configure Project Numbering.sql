 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Project%20Numbering%20-%20Configure%20Project%20Numbering.sql $:
 * $Id: Configure Project Numbering - Configure Project Numbering.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PJF_UNIQUE_ID_CONTROL
-- RSC_PREREQUISITE_OBJECTS=PJF_PROJ_NUM_DETAILS

SELECT (SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LOOKUP_type = 'PJF_PROJECT_NUMBER_ENTRY'
		AND lookup_code   = pjfPROJNUMDEO.METHOD_CODE
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	    AND LANGUAGE = USERENV('LANG')
		) RES_METHOD 
,(SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LOOKUP_type = 'PJF_MANUAL_PROJECT_NUMBER'
		AND lookup_code   = pjfPROJNUMDEO.NUMBER_TYPE
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	    AND LANGUAGE = USERENV('LANG')
		) RES_TYPE  
,pjfPROJNUMDEO.PREFIX_VALUE RES_PREFIX
,pjfPROJNUMDEO.NEXT_AUTOMATIC_NUMBER RES_NEXT_NUMBER

,pjfPROJNUMDEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pjfPROJNUMDEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pjfPROJNUMDEO.CREATED_BY RSC_CREATED_BY
,pjfPROJNUMDEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJ_NUM_DETAILS pjfPROJNUMDEO
,PJF_UNIQUE_ID_CONTROL pjfUNIQIDCONEO
WHERE pjfPROJNUMDEO.DETERMINANT_VALUE_ID = '-1'
--AND pjfPROJNUMDEO.NEXT_AUTOMATIC_NUMBER = pjfUNIQIDCONEO.NEXT_UNIQUE_IDENTIFIER
AND pjfUNIQIDCONEO.TABLE_NAME = 'PA_PROJECTS'
ORDER BY 1,2