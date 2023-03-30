/* ****************************************************************************
 * $Revision: 78867 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-24 16:46:08 +0700 (Fri, 24 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Primary%20Care%20Physician%20Option%20Restrictions.sql $:
 * $Id: Manage Benefit Plans - Primary Care Physician Option Restrictions.sql 78867 2022-06-24 09:46:08Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,'' RES_PHYSICIAN_TYPE
,(SELECT NAME
    FROM BEN_OPT_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND OPT_ID = optionRsctsE0.OPT_ID
    ) RES_OPTION_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_PCP_DSGN'
    AND LOOKUP_CODE = optionRsctsE0.PCP_DSGN_CD
    ) RES_PARTICIPANT_DESIGNATION_RU
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_PCP_DSGN'
    AND LOOKUP_CODE = optionRsctsE0.PCP_DPNT_DSGN_CD
    ) RES_DEPENDENT_DESIGNATION_RULE
,TO_CHAR(optionRsctsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_OPTION_RESTRICTIONS_EFFECT
,DECODE(TO_CHAR(optionRsctsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(optionRsctsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_OPTION_RESTRICTIONS_EFFE_0
,optionRsctsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,optionRsctsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,optionRsctsE0.CREATED_BY  RSC_CREATED_BY
,optionRsctsE0.CREATION_DATE  RSC_CREATION_DATE
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
,BEN_OIPL_F optionRsctsE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = optionRsctsE0.PL_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE
,optionRsctsE0.ORDR_NUM