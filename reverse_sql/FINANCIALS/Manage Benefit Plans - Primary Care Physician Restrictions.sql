/* ****************************************************************************
 * $Revision: 78867 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-24 16:46:08 +0700 (Fri, 24 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Primary%20Care%20Physician%20Restrictions.sql $:
 * $Id: Manage Benefit Plans - Primary Care Physician Restrictions.sql 78867 2022-06-24 09:46:08Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_PRMRY_CARE_PRVDR_TYP'
    AND LOOKUP_CODE = restrictsE0.PCP_TYP_CD
    ) RES_PHYSICIAN_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_GNDR'
    AND LOOKUP_CODE = restrictsE0.GNDR_ALWD_CD
    ) RES_GENDER_ALLOWED
,restrictsE0.MAX_AGE RES_MAXIMUM_AGE
,restrictsE0.MIN_AGE RES_MINIMUM_AGE
,restrictsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,restrictsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,restrictsE0.CREATED_BY  RSC_CREATED_BY
,restrictsE0.CREATION_DATE  RSC_CREATION_DATE
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
,BEN_PL_PCP primariesE0
,BEN_PL_PCP_TYP restrictsE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = primariesE0.PL_ID
AND primariesE0.PL_PCP_ID = restrictsE0.PL_PCP_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE