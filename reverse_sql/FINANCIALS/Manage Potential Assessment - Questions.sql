/* ****************************************************************************
* $Revision: 71641 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-03-18 14:02:24 +0700 (Mon, 18 Mar 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Worker%20Time%20Entry%20Profiles%20-%20Worker%20View.sql $:
* $Id: Manage Worker Time Entry Profiles - Worker View.sql 71641 2019-03-18 07:02:24Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT qTemplatesE0.QUESTIONNAIRE_ID RES_QUESTIONNAIRE_TEMPLATE_ID
,qTemplatesE0.NAME RES_QUESTIONNAIRE_TEMPLATE_NAM
,questionairsE0.NAME RES_NAME
,sectionsE0.NAME RES_TITLE
,questionsE0.QUESTION_CODE RES_QUESTION_CODE
,questionsE0.QUESTION_TEXT RES_QUESTION_TEXT
,questionsE0.QSTN_VERSION_NUM RES_QUESTION_VERSION_NUMBER
,(SELECT NAME
    FROM HRQ_RESPONSE_TYPES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RESPONSE_TYPE_ID = NVL(secQuestionsE0.RESPONSE_TYPE_ID,questionsE0.RESPONSE_TYPE_ID)
    ) RES_RESPONSE_TYPE
,DECODE(secQuestionsE0.MANDATORY,'Y','Yes','No') RES_REQUIRED
,'' RES_CONTROLLING_QUESTION_CODE
,secQuestionsE0.CREATED_BY  AS RSC_CREATED_BY
,secQuestionsE0.CREATION_DATE AS RSC_CREATION_DATE
,secQuestionsE0.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,secQuestionsE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,questionairsE0.BUSINESS_GROUP_ID  RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HRQ_CATEGORIES_VL foldersE0
,(SELECT *
    FROM HRQ_QUESTIONNAIRES_VL
    WHERE TEMPLATE_FLAG = 'N'
    ) questionairsE0
,HRQ_QSTNR_TEMPLATES_VL qTemplatesE0
,HRQ_QSTNR_SECTIONS_VL sectionsE0
,HRQ_QSTNR_QUESTIONS secQuestionsE0
,HRQ_QUESTIONS_VL questionsE0
WHERE foldersE0.CATEGORY_ID = questionairsE0.CATEGORY_ID
AND questionairsE0.QSTNR_TEMPLATE_ID = qTemplatesE0.QSTNR_TEMPLATE_ID
AND questionairsE0.QUESTIONNAIRE_ID = sectionsE0.QUESTIONNAIRE_ID
AND sectionsE0.QSTNR_SECTION_ID = secQuestionsE0.QSTNR_SECTION_ID
AND secQuestionsE0.QUESTION_ID = questionsE0.QUESTION_ID
AND questionairsE0.CATEGORY_ID IN (SELECT CATEGORY_ID FROM HRQ_CATEGORIES_VL foldersE0
START WITH foldersE0.CATEGORY_ID = 3
CONNECT BY PRIOR foldersE0.CATEGORY_ID = foldersE0.PARENT_CATEGORY_ID)