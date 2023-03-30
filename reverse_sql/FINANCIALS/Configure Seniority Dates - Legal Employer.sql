/* ****************************************************************************
* $Revision: 78239 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Seniority%20Dates%20-%20Seniority%20Date%20Rule%20List.sql $:
* $Id: Configure Seniority Dates - Seniority Date Rule List.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_SENIORITY_DATES_SETUP

SELECT (SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_PER_SENIORITY_ITEMS'
    AND LOOKUP_CODE = seniorityDatesE0.SENIORITY_DATE_CODE
    ) RES_SENIORITY_RULE_NAME
,TRIM(REGEXP_SUBSTR(seniorityDatesE0.SELECT_LEGAL_EMPLOYER_NAME, '[^,]+', 1, levels.column_value)) RES_LEGAL_EMPLOYER 
,'Yes' RES_LEGAL_EMPLOYER_VALUE
,seniorityDatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,seniorityDatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,seniorityDatesE0.CREATED_BY RSC_CREATED_BY
,seniorityDatesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,seniorityDatesE0.LEGISLATION_CODE RSC_COUNTRY_ID
FROM PER_SENIORITY_DATES_SETUP seniorityDatesE0
,table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(seniorityDatesE0.SELECT_LEGAL_EMPLOYER_NAME, '[^,]+'))  + 1) as sys.OdciNumberList)) levels
WHERE seniorityDatesE0.SELECT_LEGAL_EMPLOYER_NAME IS NOT NULL
ORDER BY seniorityDatesE0.SENIORITY_DATE_CODE,RES_LEGAL_EMPLOYER