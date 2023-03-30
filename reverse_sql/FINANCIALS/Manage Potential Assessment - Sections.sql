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
,DECODE(sectionsE0.ALLOW_ADHOC,'Y','Yes','No') RES_ALLOW_ADDITIONAL_QUESTIONS
,sectionsE0.DESCRIPTION RES_DESCRIPTION
,sectionsE0.INTRO_TEXT RES_INTRODUCTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRQ_QUESTION_ORDER'
    AND LOOKUP_CODE = sectionsE0.QUESTION_ORDER
    ) RES_QUESTION_ORDER
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRQ_QUESTION_ORDER'
    AND LOOKUP_CODE = sectionsE0.RESPONSE_ORDER
    ) RES_RESPONSE_ORDER
,DECODE(sectionsE0.MANDATORY,'Y','Yes','No') RES_REQUIRED
,DECODE(sectionsE0.NEW_PAGE,'Y','Yes','No') RES_NEW_PAGE
,sectionsE0.CREATED_BY  AS RSC_CREATED_BY
,sectionsE0.CREATION_DATE AS RSC_CREATION_DATE
,sectionsE0.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,sectionsE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
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
WHERE foldersE0.CATEGORY_ID = questionairsE0.CATEGORY_ID
AND questionairsE0.QSTNR_TEMPLATE_ID = qTemplatesE0.QSTNR_TEMPLATE_ID
AND questionairsE0.CATEGORY_ID IN (SELECT CATEGORY_ID FROM HRQ_CATEGORIES_VL foldersE0
START WITH foldersE0.CATEGORY_ID = 3
CONNECT BY PRIOR foldersE0.CATEGORY_ID = foldersE0.PARENT_CATEGORY_ID)
AND questionairsE0.QUESTIONNAIRE_ID = sectionsE0.QUESTIONNAIRE_ID