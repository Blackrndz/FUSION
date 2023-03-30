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
,TO_CHAR(variableFormularsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(variableFormularsE0.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(variableFormularsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,variableFormularsE0.ORDR_TO_APLY_NUM RES_SEQUENCE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_VL
    WHERE FORMULA_ID = variableFormularsE0.FORMULA_ID
    ) RES_VARIABLE_RATE_FORMULA
,variableFormularsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,variableFormularsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,variableFormularsE0.CREATED_BY RSC_CREATED_BY
,variableFormularsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ACTY_BASE_RT_F benRatesE0
,BEN_VRBL_RT_RL_F variableFormularsE0
WHERE SYSDATE BETWEEN benRatesE0.EFFECTIVE_START_DATE AND benRatesE0.EFFECTIVE_END_DATE
AND SYSDATE BETWEEN variableFormularsE0.EFFECTIVE_START_DATE AND variableFormularsE0.EFFECTIVE_END_DATE
AND benRatesE0.ACTY_BASE_RT_ID = variableFormularsE0.ACTY_BASE_RT_ID
ORDER BY benRatesE0.NAME
,variableFormularsE0.ORDR_TO_APLY_NUM