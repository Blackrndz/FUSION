/* ****************************************************************************
 * $Revision: 68493 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-29 15:56:19 +0700 (Wed, 29 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Allow%20Account%20Updates%20on%20Project-Related%20Distributions%20-%20Profile%20Options.sql $:
 * $Id: Allow Account Updates on Project-Related Distributions - Profile Options.sql 68493 2018-08-29 08:56:19Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT benRatesE0.NAME RES_RATE_NAME
,inputValuesE0.NAME RES_INPUT_VALUE
,DECODE(extraInputsE0.UPD_WHEN_ELE_ENDED_CD,'Y','Yes','N','No') RES_FORMULA_RETURN_VARIABLE_NA
,extraInputsE0.RETURN_VAR_NAME RES_UPDATE_WHEN_ENROLLMENT_END
,extraInputsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,extraInputsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,extraInputsE0.CREATED_BY RSC_CREATED_BY
,extraInputsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ACTY_BASE_RT_F benRatesE0
,BEN_EXTRA_INPUT_VALUES extraInputsE0
,PAY_INPUT_VALUES_TL inputValuesE0
WHERE SYSDATE BETWEEN benRatesE0.EFFECTIVE_START_DATE AND benRatesE0.EFFECTIVE_END_DATE
AND benRatesE0.ACTY_BASE_RT_ID = extraInputsE0.ACTY_BASE_RT_ID
AND extraInputsE0.INPUT_VALUE_ID = inputValuesE0.INPUT_VALUE_ID
AND inputValuesE0.LANGUAGE = USERENV('LANG')
ORDER BY benRatesE0.NAME
,inputValuesE0.NAME
,extraInputsE0.RETURN_VAR_NAME