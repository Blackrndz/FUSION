/* ****************************************************************************
 * $Revision: 78867 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-24 16:46:08 +0700 (Fri, 24 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Reporting%20Groups.sql $:
 * $Id: Manage Benefit Plans - Reporting Groups.sql 78867 2022-06-24 09:46:08Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_PL_F
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(benRptGrpsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_REPORTING_GROUPS_EFFECTIVE
,DECODE(TO_CHAR(benRptGrpsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(benRptGrpsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_REPORTING_GROUPS_EFFECTI_0
,benRptGrpsE0.ORDR_NUM RES_SEQUENCE
,(SELECT NAME
    FROM BEN_RPTG_GRP_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RPTG_GRP_ID = benRptGrpsE0.RPTG_GRP_ID
    ) RES_GROUP_NAME
,benRptGrpsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benRptGrpsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benRptGrpsE0.CREATED_BY  RSC_CREATED_BY
,benRptGrpsE0.CREATION_DATE  RSC_CREATION_DATE
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
,BEN_POPL_RPTG_GRP_F benRptGrpsE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = benRptGrpsE0.PL_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE
,benRptGrpsE0.ORDR_NUM