/* ****************************************************************************
 * $Revision: 74208 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-06-03 19:08:12 +0700 (Wed, 03 Jun 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/branches/core/v2.2.3.0.B/reverse_sql/FINANCIALS/Manage%20AutoPost%20Criteria%20Sets%20-%20AutoPost%20Criteria.sql $:
 * $Id: Manage AutoPost Criteria Sets - AutoPost Criteria.sql 74208 2020-06-03 12:08:12Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT personNamesE0.DISPLAY_NAME RES_PERSON_NAME
,personsE0.PERSON_NUMBER RES_PERSON_NUMBER
,ky.KEYWORD_NAME RES_NAME
,ky.DESCRIPTION RES_DESCRIPTION
,keywordsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,keywordsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,keywordsE0.CREATED_BY RSC_CREATED_BY
,keywordsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_PERSONS personelE0
,PER_ALL_PEOPLE_F personsE0
,PER_PERSON_NAMES_F personNamesE0
,GMS_PERSONNEL_KEYWORDS keywordsE0
,(SELECT KEYWORD_ID
	,KEYWORD_NAME
	,DESCRIPTION
	FROM GMS_KEYWORDS_TL
	WHERE LANGUAGE = USERENV('LANG')
	) ky
WHERE personelE0.PERSON_ID = personsE0.PERSON_ID
AND personelE0.PERSON_ID = personNamesE0.PERSON_ID
AND personNamesE0.NAME_TYPE = 'GLOBAL'
AND SYSDATE BETWEEN personsE0.EFFECTIVE_START_DATE AND personsE0.EFFECTIVE_END_DATE
AND SYSDATE BETWEEN personNamesE0.EFFECTIVE_START_DATE AND personNamesE0.EFFECTIVE_END_DATE
AND personelE0.PERSON_ID = keywordsE0.PERSON_ID
AND keywordsE0.KEYWORD_ID = ky.KEYWORD_ID
ORDER BY personNamesE0.DISPLAY_NAME
,ky.KEYWORD_NAME