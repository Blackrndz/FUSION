/* ****************************************************************************
* $Revision: 78759 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-15 12:41:43 +0700 (Wed, 15 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Options%20-%20Plan%20Type%20for%20Option.sql $:
* $Id: Manage Benefit Options - Plan Type for Option.sql 78759 2022-06-15 05:41:43Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT optionsE0.NAME RES_OPTION_NAME
,TO_CHAR(optionsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(planOptionsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_PLAN_TYPE_EFFECTIVE_START_
,DECODE(TO_CHAR(optionsE0.EFFECTIVE_END_DATE ,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(optionsE0.EFFECTIVE_END_DATE ,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,(SELECT NAME
	FROM BEN_PL_TYP_F
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND PL_TYP_ID = planOptionsE0.PL_TYP_ID 
	) RES_PLAN_TYPE_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_OPT_TYP'
	AND LOOKUP_CODE = planOptionsE0.PL_TYP_OPT_TYP_CD 
	) RES_USAGE_RULE
,planOptionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,planOptionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,planOptionsE0.CREATED_BY RSC_CREATED_BY
,planOptionsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,optionsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_OPT_F optionsE0 
,BEN_PL_TYP_OPT_TYP_F planOptionsE0
WHERE optionsE0.OPT_ID = planOptionsE0.OPT_ID
AND planOptionsE0.EFFECTIVE_START_DATE BETWEEN optionsE0.EFFECTIVE_START_DATE AND NVL(optionsE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY optionsE0.NAME
,optionsE0.EFFECTIVE_START_DATE