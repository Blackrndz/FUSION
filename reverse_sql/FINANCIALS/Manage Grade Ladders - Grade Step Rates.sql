/* ****************************************************************************
 * $Revision: 73701 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-03-05 12:34:33 +0700 (Thu, 05 Mar 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account.sql 73701 2020-03-05 05:34:33Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT TO_CHAR(laddersE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,laddersE0.NAME RES_NAME
,legisDataGroupsE0.NAME RES_LEGISLATIVE_DATA_GROUP
,gradeStepRatesE0.NAME RES_RATE_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'GRADE_PAY_RATE_TYPE'
    AND LOOKUP_CODE = gradeStepRatesE0.RATE_TYPE
    ) RES_RATE_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'CMP_SALARY_BASIS'
    AND LOOKUP_CODE = gradeStepRatesE0.RATE_FREQUENCY
    ) RES_FREQUENCY
,gradeStepRatesE0.ANNUALIZATION_FACTOR RES_ANNUALIZATION_FACTOR
,gradeStepRatesE0.CURRENCY_CODE RES_CURRENCY
,gradeStepRatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gradeStepRatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gradeStepRatesE0.CREATED_BY RSC_CREATED_BY
,gradeStepRatesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_GRADE_LADDERS_F_VL laddersE0
,PER_RATES_F_VL gradeStepRatesE0
,(SELECT LEGISLATIVE_DATA_GROUP_ID
    ,NAME
    FROM PER_LEGISLATIVE_DATA_GROUPS_TL
    WHERE LANGUAGE = USERENV('LANG')
    ) legisDataGroupsE0
WHERE laddersE0.GRADE_LADDER_ID = gradeStepRatesE0.GRADE_LADDER_ID
AND laddersE0.EFFECTIVE_END_DATE BETWEEN gradeStepRatesE0.EFFECTIVE_START_DATE AND gradeStepRatesE0.EFFECTIVE_END_DATE
AND gradeStepRatesE0.LEGISLATIVE_DATA_GROUP_ID = legisDataGroupsE0.LEGISLATIVE_DATA_GROUP_ID
ORDER BY laddersE0.NAME
,laddersE0.EFFECTIVE_START_DATE
,legisDataGroupsE0.NAME