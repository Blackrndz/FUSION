/* ****************************************************************************
 * $Revision: 79238 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-08-18 15:16:12 +0700 (Thu, 18 Aug 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Year%20Periods.sql $:
 * $Id: Manage Benefit Plans - Year Periods.sql 79238 2022-08-18 08:16:12Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
/*,(SELECT NAME
    FROM BEN_PL_TYP_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND PL_TYP_ID = benPlansE0.PL_TYP_ID
    ) RES_PLAN_TYPE
,DECODE(TO_CHAR(benPlansE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(benPlansE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE*/
,TO_CHAR(yearPeriodsE0.START_DATE,'DD')
	||'-'||DECODE(TO_CHAR(yearPeriodsE0.START_DATE,'MM'),'01','Jan','02','Feb','03','Mar','04','Apr','05','May','06','Jun'
																,'07','Jul','08','Aug','09','Sep','10','Oct','11','Nov','12','Dec')
	||'-'||TO_CHAR(yearPeriodsE0.START_DATE,'YYYY')
	||' - '||TO_CHAR(yearPeriodsE0.END_DATE,'DD')
	||'-'||DECODE(TO_CHAR(yearPeriodsE0.END_DATE,'MM'),'01','Jan','02','Feb','03','Mar','04','Apr','05','May','06','Jun'
																,'07','Jul','08','Aug','09','Sep','10','Oct','11','Nov','12','Dec')
	||'-'||TO_CHAR(yearPeriodsE0.END_DATE,'YYYY') RES_SELECTED
,TO_CHAR(yearPeriodsE0.START_DATE,'DD-Mon-YYYY') RES_YEAR_PERIODS_START_DATE
,TO_CHAR(yearPeriodsE0.END_DATE,'DD-Mon-YYYY') RES_YEAR_PERIODS_END_DATE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_PERD_TYP'
    AND LOOKUP_CODE = yearPeriodsE0.PERD_TYP_CD
    ) RES_PERIOD_TYPE
,yearPeriodsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,yearPeriodsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,yearPeriodsE0.CREATED_BY  RSC_CREATED_BY
,yearPeriodsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPlansE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_PL_F benPlansE0
,(SELECT NAME
	,PL_TYP_ID
    FROM BEN_PL_TYP_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND OPT_TYP_CD != 'FLXCR'
	) planTypesE0
,BEN_POPL_YR_PERD benplanYPsE0
,BEN_YR_PERD yearPeriodsE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = benplanYPsE0.PL_ID
AND benplanYPsE0.YR_PERD_ID = yearPeriodsE0.YR_PERD_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE
,yearPeriodsE0.START_DATE DESC