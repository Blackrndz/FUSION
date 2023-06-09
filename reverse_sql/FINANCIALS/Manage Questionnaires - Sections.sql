/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Questionnaires%20-%20Sections.sql $:
 * $Id: Manage Questionnaires - Sections.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

/*<RSC_PRE_STEPS_LARGE_COLUMN_POSITION>13</RSC_PRE_STEPS_LARGE_COLUMN_POSITION>
	
-- The column position that using special data type.
 <RSC_PRE_STEPS_LARGE_COLUMN_TYPE>LONG</RSC_PRE_STEPS_LARGE_COLUMN_TYPE>

-- Specify what type of the data.
*/

-- RSC_PREREQUISITE_OBJECTS=HRQ_QSTNR_SECTIONS_VL
-- REPLACE_HTML_KEYWORD = RES_INTRODUCTION

SELECT (SELECT NAME
    FROM HRQ_SUBSCRIBERS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND SUBSCRIBER_ID = foldersE0.SUBSCRIBER_ID
	) RES_SUBSCRIBER
,(SELECT QUESTIONNAIRE_CODE FROM HRQ_QUESTIONNAIRES_VL WHERE QUESTIONNAIRE_ID = qTemplatesE0.QUESTIONNAIRE_ID) RES_QUESTIONNAIRE_TEMPLATE_ID
,qTemplatesE0.NAME RES_QUESTIONNAIRE_TEMPLATE_NAM
,questionairsE0.QUESTIONNAIRE_CODE RES_QUESTIONNAIRE_CODE
,questionairsE0.NAME RES_QUESTIONNAIRE_NAME
,foldersE0.RES_PARENT_FOLDER_1
,foldersE0.RES_PARENT_FOLDER_2
,foldersE0.RES_PARENT_FOLDER_3
,foldersE0.RES_PARENT_FOLDER_4
,foldersE0.RES_PARENT_FOLDER_5
,foldersE0.NAME RES_FOLDER
,sectionsE0.NAME RES_TITLE
,sectionsE0.DESCRIPTION RES_DESCRIPTION
,REPLACE(REPLACE(REPLACE(sectionsE0.INTRO_TEXT,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_INTRODUCTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRQ_QUESTION_ORDER'
    AND LOOKUP_CODE = sectionsE0.QUESTION_ORDER
    ) RES_QUESTION_ORDER
,sectionsE0.RANDOM_SAMPLE_SIZE RES_SAMPLE_SIZE
,DECODE(sectionsE0.ALLOW_ADHOC,'Y','Yes','No') RES_ALLOW_ADDITIONAL_QUESTIONS
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRQ_QUESTION_ORDER'
    AND LOOKUP_CODE = sectionsE0.RESPONSE_ORDER
    ) RES_RESPONSE_ORDER
,DECODE(sectionsE0.MANDATORY,'Y','Yes','No') RES_REQUIRED

,sectionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,sectionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,sectionsE0.CREATED_BY RSC_CREATED_BY
,sectionsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT SUBSTR(SYS_CONNECT_BY_PATH(NAME,'###'),INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,1)+3,INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,2)-4) RES_PARENT_FOLDER_1
,SUBSTR(SYS_CONNECT_BY_PATH(NAME,'###'),INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,2)+3,INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,3) - INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,2)-3) RES_PARENT_FOLDER_2
,SUBSTR(SYS_CONNECT_BY_PATH(NAME,'###'),INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,3)+3,INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,4) - INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,3)-3) RES_PARENT_FOLDER_3
,SUBSTR(SYS_CONNECT_BY_PATH(NAME,'###'),INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,4)+3,INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,5) - INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,4)-3) RES_PARENT_FOLDER_4
,SUBSTR(SYS_CONNECT_BY_PATH(NAME,'###'),INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,5)+3,INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,6) - INSTR(SYS_CONNECT_BY_PATH(NAME,'###'),'###',1,5)-3) RES_PARENT_FOLDER_5
,CATEGORY_ID,NAME,CONTAIN_QUESTIONNAIRES,SUBSCRIBER_ID FROM HRQ_CATEGORIES_VL START WITH PARENT_CATEGORY_ID IS NULL
CONNECT BY PRIOR CATEGORY_ID = PARENT_CATEGORY_ID) foldersE0
,HRQ_QUESTIONNAIRES_VL questionairsE0
,HRQ_QSTNR_TEMPLATES_VL qTemplatesE0
,HRQ_QSTNR_SECTIONS_VL sectionsE0
WHERE foldersE0.SUBSCRIBER_ID IN (SELECT SUBSCRIBER_ID FROM HRQ_SUBSCRIBERS_VL WHERE SUBSCRIBER_CODE IN ('PER_CHK','WLF_ASSESSMENTS','WLF_ENROLLMENTS','WFL','HRA','HWR','IRC','HWRTMS','HXLTLTC','HNS'))
AND foldersE0.CONTAIN_QUESTIONNAIRES = 'Y'
AND foldersE0.CATEGORY_ID = questionairsE0.CATEGORY_ID
AND questionairsE0.CATEGORY_ID IN (SELECT CATEGORY_ID FROM HRQ_CATEGORIES_VL foldersE0
START WITH foldersE0.PARENT_CATEGORY_ID IS NULL
CONNECT BY PRIOR foldersE0.CATEGORY_ID = foldersE0.PARENT_CATEGORY_ID)
AND questionairsE0.QSTNR_TEMPLATE_ID = qTemplatesE0.QSTNR_TEMPLATE_ID
AND questionairsE0.QUESTIONNAIRE_ID = sectionsE0.QUESTIONNAIRE_ID
AND questionairsE0.TEMPLATE_FLAG = 'N'
ORDER BY 1,questionairsE0.NAME