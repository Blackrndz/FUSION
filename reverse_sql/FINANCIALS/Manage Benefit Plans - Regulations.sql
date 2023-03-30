/* ****************************************************************************
 * $Revision: 78867 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-24 16:46:08 +0700 (Fri, 24 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Regulations.sql $:
 * $Id: Manage Benefit Plans - Regulations.sql 78867 2022-06-24 09:46:08Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_PL_F

SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(benRegulationsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_REGULATIONS_EFFECTIVE_STAR
,DECODE(TO_CHAR(benRegulationsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(benRegulationsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_REGULATIONS_EFFECTIVE_END_
,(SELECT NAME
    FROM BEN_REGN_F_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND REGN_ID = benRegulationsE0.REGN_ID
    ) RES_REGULATION_NAME
,(SELECT NAME
    FROM BEN_RPTG_GRP_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RPTG_GRP_ID = benRegulationsE0.RPTG_GRP_ID
    ) RES_REPORTING_GROUP_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_REGY_PL_TYP'
    AND LOOKUP_CODE = benRegulationsE0.REGY_PL_TYP_CD
    ) RES_REGULATORY_PLAN_TYPE
,benRegulationsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benRegulationsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benRegulationsE0.CREATED_BY  RSC_CREATED_BY
,benRegulationsE0.CREATION_DATE  RSC_CREATION_DATE
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
,BEN_PL_REGN_F benRegulationsE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = benRegulationsE0.PL_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE